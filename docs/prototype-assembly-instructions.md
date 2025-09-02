# The Tennis Rover Mini - 1:10 Scale Prototype Assembly Instructions

## Overview
**The Tennis Rover Mini** is a complete functional prototype at 1:10 scale for testing The Rover platform technology. This miniature version of The Tennis Rover can collect 6.7mm diameter mini tennis balls and navigate a 2.4m x 0.8m scaled court, demonstrating all core RoverOS capabilities.

## Parts List & Print Settings

### 3D Printed Parts

| Part | Quantity | Material | Infill | Support | Print Time | File |
|------|----------|----------|--------|---------|------------|------|
| Chassis Base | 1 | PETG | 20% | No | 4 hrs | prototype-detailed.scad |
| Collection Scoop | 1 | TPU 95A | 15% | Yes | 1 hr | prototype-detailed.scad |
| Wheels | 4 | PETG + TPU | 20% | No | 30 min each | prototype-detailed.scad |
| Mini Basket | 1 | PETG | 15% | No | 2 hrs | prototype-detailed.scad |
| Top Cover | 1 | PETG | 15% | No | 1 hr | prototype-detailed.scad |
| Elevator Mechanism | 1 | PETG | 20% | Yes | 1.5 hrs | prototype-detailed.scad |
| **Court Components** |
| Mini Tennis Balls | 20-50 | TPU 95A | 10% | No | 5 min each | mini-tennis-ball.scad |
| Net Posts | 2 | PETG | 30% | No | 1 hr each | mini-tennis-court-environment.scad |
| Fence Sections | 15-20 | PETG | 20% | No | 45 min each | mini-tennis-court-environment.scad |
| Ball Hoppers | 2 | PETG | 15% | No | 2 hrs each | mini-tennis-court-environment.scad |

### Electronics Components

| Component | Quantity | Specifications | Purpose |
|-----------|----------|---------------|---------|
| Raspberry Pi Zero 2 W | 1 | 1GHz, 512MB RAM | Main controller |
| Pi Camera Module V2 | 1 | 8MP, 1080p | Ball detection |
| N20 Micro Motors | 5 | 6V, 100RPM | 4 wheels + elevator |
| L298N Motor Driver | 1 | Dual H-bridge | Motor control |
| HC-SR04 Ultrasonic | 1 | 2-400cm range | Obstacle detection |
| 18650 Battery | 2 | 3.7V, 2600mAh | Power supply |
| Battery Holder | 1 | 2x 18650 | Power management |
| BMS Module | 1 | 2S, 10A | Battery protection |
| Micro Servo | 1 | SG90 | Basket release |
| LED Indicators | 3 | 3mm, RGB | Status display |
| Power Switch | 1 | SPDT | Main power |
| Charging Port | 1 | USB-C or barrel | Battery charging |

### Hardware

| Item | Quantity | Size | Purpose |
|------|----------|------|---------|
| M2 Screws | 20 | 6mm | Electronics mounting |
| M3 Screws | 16 | 10mm | Chassis assembly |
| M2 Standoffs | 8 | 5mm | Pi Zero mounting |
| Ball Bearings | 8 | 3x7x3mm | Wheel smoothness |
| Jumper Wires | 30 | Various | Connections |
| Heat Shrink | 1m | 3-6mm | Wire protection |

### Court Construction Materials

| Material | Quantity | Specifications | Purpose |
|----------|----------|---------------|---------|
| Plywood Sheet | 1 | 3m x 1.5m x 18mm | Court base |
| Green Paint | 1L | Acrylic | Court surface |
| White Paint | 0.5L | Acrylic | Line marking |
| Polyurethane | 0.5L | Clear coat | Surface protection |
| Wood Screws | 50 | 20mm | Fence attachment |

## Assembly Instructions

### Step 1: Print All Parts
1. Start with the chassis base (longest print)
2. Print wheels while chassis is printing
3. Use TPU for scoop and ball tires for flexibility
4. Print mini tennis balls in batches of 10

### Step 2: Electronics Preparation
1. **Solder headers to Raspberry Pi Zero**
   - GPIO headers for motor driver connection
   - Camera connector ribbon cable

2. **Prepare motor wiring**
   - Solder wires to each N20 motor
   - Add heat shrink for insulation
   - Length: 10cm for wheel motors, 15cm for elevator

3. **Battery pack assembly**
   - Connect batteries in series (7.4V)
   - Wire through BMS for protection
   - Add charging port and switch

### Step 3: Chassis Assembly

1. **Install motor mounts**
   ```
   - Insert N20 motors into chassis slots
   - Secure with M2 screws through mounting holes
   - Ensure shafts extend through chassis walls
   ```

2. **Mount Raspberry Pi Zero**
   ```
   - Install M2 standoffs in mounting holes
   - Place Pi Zero on standoffs
   - Secure with M2 screws
   - Connect camera ribbon cable
   ```

3. **Install motor driver**
   ```
   - Mount L298N on standoffs
   - Connect motor wires to output terminals
   - Wire power from battery through BMS
   ```

4. **Ultrasonic sensor mounting**
   ```
   - Insert HC-SR04 in front mounting holes
   - Secure with hot glue if needed
   - Wire to Pi GPIO pins
   ```

### Step 4: Mechanical Assembly

1. **Attach wheels**
   ```
   - Press wheels onto motor shafts
   - Ensure D-shaped shaft alignment
   - Tighten set screws
   - Test rotation freely
   ```

2. **Install collection scoop**
   ```
   - Attach scoop to front mounting tabs
   - Use M3 screws through holes
   - Ensure roller spins freely
   - Connect roller motor
   ```

3. **Mount elevator mechanism**
   ```
   - Install in center cavity
   - Connect paddle wheel motor
   - Test ball flow path
   - Adjust paddle clearance
   ```

4. **Attach basket**
   ```
   - Slide basket onto rear rails
   - Test removal/insertion
   - Install servo for auto-dump (optional)
   ```

### Step 5: Wiring Connections

#### GPIO Pin Assignments (Raspberry Pi Zero)
```python
# Motor Control
LEFT_MOTOR_1 = 17    # GPIO17
LEFT_MOTOR_2 = 27    # GPIO27
RIGHT_MOTOR_1 = 22   # GPIO22
RIGHT_MOTOR_2 = 23   # GPIO23
ELEVATOR_MOTOR_1 = 24 # GPIO24
ELEVATOR_MOTOR_2 = 25 # GPIO25

# Sensors
ULTRASONIC_TRIG = 5  # GPIO5
ULTRASONIC_ECHO = 6  # GPIO6

# Status LEDs
LED_RED = 16         # GPIO16
LED_GREEN = 20       # GPIO20
LED_BLUE = 21        # GPIO21

# Servo
BASKET_SERVO = 18    # GPIO18 (PWM)
```

### Step 6: Court Setup

1. **Prepare plywood base**
   ```
   - Sand surface smooth
   - Apply primer coat
   - Paint green court surface
   - Let dry 24 hours
   ```

2. **Mark court lines**
   ```
   Court dimensions (1:10 scale):
   - Full length: 2.377m
   - Singles width: 0.823m
   - Service box: 0.64m x 0.411m
   - Line width: 5mm
   ```

3. **Install fence sections**
   ```
   - Print fence sections
   - Connect with corner pieces
   - Screw to plywood edge
   - Install gate for access
   ```

4. **Setup net**
   ```
   - Install net posts at center
   - String net mesh between posts
   - Height: 91.4mm at center
   ```

### Step 7: Software Installation

1. **Raspberry Pi OS Setup**
   ```bash
   # Flash Raspberry Pi OS Lite to SD card
   # Enable SSH and WiFi
   # Boot Pi Zero and connect via SSH
   ```

2. **Install dependencies**
   ```bash
   sudo apt update
   sudo apt install -y python3-pip python3-opencv
   sudo apt install -y python3-rpi.gpio
   pip3 install numpy tensorflow-lite
   ```

3. **Clone robot code**
   ```bash
   git clone https://github.com/yourusername/tennis-robot
   cd tennis-robot
   pip3 install -r requirements.txt
   ```

4. **Test components**
   ```bash
   # Test motors
   python3 tests/motor_test.py
   
   # Test camera
   python3 tests/camera_test.py
   
   # Test sensors
   python3 tests/sensor_test.py
   ```

### Step 8: Calibration

1. **Camera calibration**
   - Place robot on court
   - Run calibration script
   - Adjust for court boundaries
   - Test ball detection

2. **Motor calibration**
   - Measure actual speed
   - Adjust PWM values
   - Test turning radius
   - Calibrate encoder counts

3. **Collection mechanism**
   - Test scoop angle
   - Adjust roller speed
   - Verify elevator timing
   - Test basket capacity

## Testing Procedures

### Basic Function Tests

1. **Movement Test**
   ```python
   # Test forward, backward, left, right
   # Verify speed control
   # Check emergency stop
   ```

2. **Ball Detection**
   ```python
   # Place balls at various positions
   # Verify detection accuracy
   # Test in different lighting
   ```

3. **Collection Test**
   ```python
   # Single ball pickup
   # Multiple ball sequence
   # Full basket handling
   ```

### Court Navigation Tests

1. **Boundary Recognition**
   - Robot stays within lines
   - Recognizes service boxes
   - Avoids net

2. **Coverage Patterns**
   - Systematic grid search
   - Efficient path planning
   - Return to base

3. **Mode Testing**
   - Practice mode (continuous)
   - Clinic mode (batch collection)
   - Charging behavior

## Troubleshooting

| Problem | Possible Cause | Solution |
|---------|---------------|----------|
| Motors don't turn | Power issue | Check battery voltage, connections |
| Can't detect balls | Camera focus | Adjust camera position, lighting |
| Wheels slip | Poor traction | Add rubber bands to wheels |
| Basket won't stay | Rail alignment | Adjust rail spacing, add guides |
| Pi won't boot | Power supply | Check voltage (5V), current (2A min) |
| Erratic movement | Loose connections | Secure all wires, check GPIO |

## Performance Metrics

### Target Specifications
- **Ball detection accuracy**: >95%
- **Collection success rate**: >90%
- **Battery runtime**: 30-45 minutes
- **Speed**: 0.15 m/s (scaled from 1.5 m/s)
- **Turning radius**: <10cm
- **Ball capacity**: 15-20 mini balls

### Testing Checklist
- [ ] All motors functioning
- [ ] Camera detecting balls
- [ ] Ultrasonic avoiding obstacles
- [ ] Battery lasting 30+ minutes
- [ ] Successfully collecting 10 balls
- [ ] Navigating full court
- [ ] Returning to charging position
- [ ] Mode switching working
- [ ] Basket removal smooth
- [ ] Status LEDs indicating states

## Next Steps

1. **Data Collection**
   - Record ball positions
   - Log collection times
   - Track success rates
   - Monitor battery usage

2. **AI Training**
   - Gather training images
   - Label ball positions
   - Train detection model
   - Deploy to Pi Zero

3. **Optimization**
   - Improve path planning
   - Reduce power consumption
   - Increase collection speed
   - Enhance detection accuracy

4. **Scale to Full Size**
   - Apply learnings to full robot
   - Scale mechanical design
   - Upgrade to Pi 4
   - Add solar charging

## Resources

- **3D Files**: `/models/` directory
- **Software**: `/src/` directory
- **Documentation**: `/docs/` directory
- **Test Scripts**: `/tests/` directory

## Support

For questions or issues:
- Check troubleshooting guide above
- Review test scripts for examples
- Consult wiring diagram
- Test individual components first

This prototype provides a complete testing platform for the tennis ball collecting robot at 1:10 scale, allowing full functionality testing before building the full-size version.