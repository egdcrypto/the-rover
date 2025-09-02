[← Back to Main README](../README.md) | [The Rover Platform](../README.md#-the-rover-family)

---

# Tennis Ball Robot - Prototype Development Plan

## Phase 1: Desktop Proof of Concept

### Overview
Start with a small-scale prototype that demonstrates core functionality:
- AI-powered ball detection (distinguish tennis balls from other objects)
- Court boundary recognition
- Autonomous navigation within defined area
- Ball collection and storage mechanism

### Prototype Specifications

#### Scale Model (1:10 scale)
- **Size**: 20cm x 15cm x 12cm robot
- **Test Area**: 2.4m x 1.1m (scaled tennis court)
- **Mini Tennis Balls**: 2cm diameter foam balls
- **Basket Capacity**: 10-15 mini balls
- **Cost**: ~$200-300

#### Components
- **Raspberry Pi Zero 2 W** ($15)
  - Sufficient for basic vision processing
  - WiFi for remote monitoring
  - Small form factor
- **Pi Camera Module V2** ($30)
  - 8MP sensor
  - 1080p video capability
- **Motors**: 4x micro gear motors ($40)
- **Motor Driver**: L298N or similar ($10)
- **Battery**: 2S LiPo 1000mAh ($20)
- **Ultrasonic Sensor**: HC-SR04 ($5)
- **3D Printed Frame**: ~$30 in filament

### Court Detection & Mapping

#### Tennis Court Specifications (Full Scale)
```
Singles Court: 23.77m x 8.23m
Doubles Court: 23.77m x 10.97m
Service Box: 6.40m x 4.11m
Net Height: 0.914m (center)
```

#### Scaled Test Court (1:10)
```
Singles: 2.38m x 0.82m
Doubles: 2.38m x 1.10m
Service Box: 0.64m x 0.41m
```

#### Court Detection Algorithm
```python
import cv2
import numpy as np

class CourtDetector:
    def __init__(self):
        self.court_corners = None
        self.court_boundaries = None
        
    def detect_court_lines(self, image):
        """Detect white lines on court surface."""
        # Convert to grayscale
        gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
        
        # Apply Gaussian blur
        blurred = cv2.GaussianBlur(gray, (5, 5), 0)
        
        # Edge detection
        edges = cv2.Canny(blurred, 50, 150)
        
        # Hough transform for line detection
        lines = cv2.HoughLinesP(edges, 1, np.pi/180, 
                                threshold=100, minLineLength=100, maxLineGap=10)
        
        # Find court rectangle from lines
        if lines is not None:
            self.court_boundaries = self.find_court_rectangle(lines)
            
        return self.court_boundaries
    
    def find_court_rectangle(self, lines):
        """Extract court rectangle from detected lines."""
        # Group horizontal and vertical lines
        horizontal = []
        vertical = []
        
        for line in lines:
            x1, y1, x2, y2 = line[0]
            angle = np.abs(np.arctan2(y2-y1, x2-x1))
            
            if angle < np.pi/6:  # Nearly horizontal
                horizontal.append(line[0])
            elif angle > np.pi/3:  # Nearly vertical
                vertical.append(line[0])
        
        # Find outermost lines to form rectangle
        if len(horizontal) >= 2 and len(vertical) >= 2:
            # Sort and select boundary lines
            return self.construct_boundary(horizontal, vertical)
            
        return None
    
    def is_inside_court(self, x, y):
        """Check if point is within court boundaries."""
        if self.court_boundaries is None:
            return False
            
        return cv2.pointPolygonTest(self.court_boundaries, (x, y), False) >= 0
```

### Ball Detection System

#### Multi-Object Discrimination
```python
import tensorflow as tf
from tensorflow.keras import layers, models

class BallDetector:
    def __init__(self, model_path=None):
        if model_path:
            self.model = tf.keras.models.load_model(model_path)
        else:
            self.model = self.build_model()
            
    def build_model(self):
        """Build CNN for ball vs non-ball classification."""
        model = models.Sequential([
            layers.Conv2D(32, (3, 3), activation='relu', input_shape=(64, 64, 3)),
            layers.MaxPooling2D((2, 2)),
            layers.Conv2D(64, (3, 3), activation='relu'),
            layers.MaxPooling2D((2, 2)),
            layers.Conv2D(64, (3, 3), activation='relu'),
            layers.Flatten(),
            layers.Dense(64, activation='relu'),
            layers.Dropout(0.5),
            layers.Dense(3, activation='softmax')  # tennis_ball, other_ball, not_ball
        ])
        
        model.compile(optimizer='adam',
                     loss='categorical_crossentropy',
                     metrics=['accuracy'])
        return model
    
    def detect_tennis_balls(self, image):
        """Detect only tennis balls, ignore other objects."""
        # Color-based pre-filtering
        hsv = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)
        
        # Tennis ball color range (yellow-green)
        lower = np.array([25, 50, 50])
        upper = np.array([35, 255, 255])
        mask = cv2.inRange(hsv, lower, upper)
        
        # Find circular contours
        contours, _ = cv2.findContours(mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
        
        tennis_balls = []
        for contour in contours:
            # Check circularity
            area = cv2.contourArea(contour)
            perimeter = cv2.arcLength(contour, True)
            if perimeter > 0:
                circularity = 4 * np.pi * area / (perimeter ** 2)
                
                if circularity > 0.7 and area > 100:
                    # Extract ROI and classify
                    x, y, w, h = cv2.boundingRect(contour)
                    roi = image[y:y+h, x:x+w]
                    
                    if self.is_tennis_ball(roi):
                        tennis_balls.append({
                            'center': (x + w//2, y + h//2),
                            'radius': max(w, h) // 2,
                            'confidence': circularity
                        })
        
        return tennis_balls
    
    def is_tennis_ball(self, roi):
        """Use trained model to verify if object is tennis ball."""
        # Resize ROI to model input size
        roi_resized = cv2.resize(roi, (64, 64))
        roi_normalized = roi_resized / 255.0
        
        # Predict
        prediction = self.model.predict(np.expand_dims(roi_normalized, axis=0))
        class_idx = np.argmax(prediction)
        
        return class_idx == 0  # 0 = tennis_ball class
```

### Navigation & Collection Strategy

#### Grid-Based Navigation
```python
class GridNavigator:
    def __init__(self, court_bounds, grid_size=0.1):
        """Initialize navigation grid (0.1m squares for prototype)."""
        self.court_bounds = court_bounds
        self.grid_size = grid_size
        self.visited_cells = set()
        self.current_position = (0, 0)
        
    def plan_collection_path(self, ball_positions):
        """Plan efficient path to collect all balls."""
        # Sort balls by distance for nearest-neighbor approach
        unvisited = ball_positions.copy()
        path = []
        current = self.current_position
        
        while unvisited:
            # Find nearest ball
            nearest = min(unvisited, 
                         key=lambda b: self.distance(current, b['center']))
            path.append(nearest['center'])
            unvisited.remove(nearest)
            current = nearest['center']
            
        return path
    
    def spiral_search_pattern(self):
        """Generate spiral pattern for systematic court coverage."""
        x, y = 0, 0
        dx, dy = 0, -1
        path = []
        
        for _ in range(100):  # Limit iterations
            if self.is_in_bounds(x, y):
                path.append((x * self.grid_size, y * self.grid_size))
                
            if x == y or (x < 0 and x == -y) or (x > 0 and x == 1-y):
                dx, dy = -dy, dx  # Rotate direction
            x, y = x + dx, y + dy
            
        return path
```

### Prototype Testing Phases

#### Phase 1A: Static Detection (Week 1-2)
- **Goal**: Accurately identify tennis balls vs other objects
- **Setup**: 
  - Place various objects on scaled court
  - Mini tennis balls, ping pong balls, marbles, blocks
- **Success Criteria**: 
  - 95% accuracy distinguishing tennis balls
  - Detect all balls within court boundaries
  - Ignore objects outside court lines

#### Phase 1B: Mobile Collection (Week 3-4)
- **Goal**: Navigate and collect balls autonomously
- **Tests**:
  1. Single ball pickup
  2. Multiple balls in sequence
  3. Avoid non-ball objects
  4. Return to base when basket full
- **Success Criteria**:
  - Collect 90% of balls on court
  - No false pickups of other objects
  - Stay within court boundaries

#### Phase 1C: Intelligent Behavior (Week 5-6)
- **Goal**: Implement smart collection strategies
- **Features**:
  - Efficient path planning
  - Battery management
  - Mode switching (continuous vs batch)
- **Success Criteria**:
  - Optimize collection time
  - Demonstrate both operating modes
  - Handle edge cases gracefully

### Data Collection for Training

#### Training Dataset Requirements
```
tennis_balls/
├── on_court/
│   ├── hard_court/ (500 images)
│   ├── clay_court/ (300 images)
│   └── grass_court/ (200 images)
├── not_tennis_balls/
│   ├── other_balls/ (500 images)
│   ├── leaves/ (200 images)
│   ├── trash/ (200 images)
│   └── shadows/ (100 images)
└── augmented/
    ├── rotated/
    ├── scaled/
    └── lighting_variations/
```

#### Data Augmentation Script
```python
from tensorflow.keras.preprocessing.image import ImageDataGenerator

def augment_training_data(input_dir, output_dir):
    """Generate augmented training data."""
    datagen = ImageDataGenerator(
        rotation_range=180,
        width_shift_range=0.2,
        height_shift_range=0.2,
        shear_range=0.2,
        zoom_range=0.2,
        horizontal_flip=True,
        brightness_range=[0.5, 1.5],
        fill_mode='nearest'
    )
    
    # Process each image
    for img_path in glob.glob(f"{input_dir}/*.jpg"):
        img = load_img(img_path)
        x = img_to_array(img)
        x = x.reshape((1,) + x.shape)
        
        # Generate 5 augmented versions
        i = 0
        for batch in datagen.flow(x, batch_size=1, 
                                  save_to_dir=output_dir,
                                  save_prefix='aug', 
                                  save_format='jpg'):
            i += 1
            if i >= 5:
                break
```

### Prototype Assembly Guide

#### 3D Printed Components
1. **Main Chassis** (prototype_chassis.stl)
   - Print time: 3 hours
   - Material: PETG, 20% infill
   - Dimensions: 200x150x50mm

2. **Mini Ball Scoop** (prototype_scoop.stl)
   - Print time: 1 hour
   - Material: TPU, 15% infill
   - Flexible design for ball capture

3. **Basket Mount** (prototype_basket.stl)
   - Print time: 2 hours
   - Material: PETG, 15% infill
   - Removable design

#### Wiring Diagram
```
Raspberry Pi Zero 2 W
├── GPIO 17,27,22,23 → Motor Driver IN1-4
├── GPIO 18,24 → Motor Driver Enable pins
├── GPIO 5,6 → Ultrasonic Trigger/Echo
├── Camera Port → Pi Camera V2
├── I2C → IMU (optional)
└── Power → 5V from BEC

Motor Driver (L298N)
├── OUT1,2 → Left Motors
├── OUT3,4 → Right Motors
├── 12V → Battery
└── 5V → Pi Power (via BEC)
```

### Testing Checklist

#### Hardware Tests
- [ ] Motors respond to commands
- [ ] Camera captures clear images
- [ ] Ultrasonic sensor reads distances
- [ ] Battery provides adequate runtime
- [ ] 3D printed parts fit properly

#### Software Tests
- [ ] Court detection algorithm works
- [ ] Ball detection distinguishes tennis balls
- [ ] Navigation stays within boundaries
- [ ] Path planning optimizes routes
- [ ] Mode switching functions correctly

#### Integration Tests
- [ ] Robot collects balls autonomously
- [ ] Basket fills and empties properly
- [ ] System handles errors gracefully
- [ ] Performance metrics are logged
- [ ] Remote monitoring works

### Success Metrics

#### Prototype Goals
| Metric | Target | Measurement |
|--------|--------|-------------|
| Ball Detection Accuracy | >95% | True positives / Total balls |
| False Positive Rate | <5% | False detections / Total detections |
| Collection Success | >90% | Balls collected / Balls present |
| Battery Life | >30 min | Continuous operation time |
| Court Coverage | 100% | Area covered / Total area |
| Processing Speed | >10 FPS | Frames processed per second |

### Next Steps After Prototype

#### Scale to Full Size
1. Upgrade to Raspberry Pi 4 (8GB)
2. Use full-size motors and drivers
3. Implement solar charging
4. Add weather protection
5. Enhance AI models with more data
6. Test on real tennis courts

#### Advanced Features
- Player tracking and avoidance
- Multi-court operation
- Voice commands
- Mobile app control
- Performance analytics
- Fleet coordination

This prototype approach allows for:
- Lower initial investment
- Faster iteration cycles
- Risk-free testing
- Proof of concept for investors/users
- Training data collection
- Algorithm refinement