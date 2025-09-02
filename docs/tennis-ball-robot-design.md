# Tennis Ball Collecting Robot - Design Specifications

## Project Overview
An autonomous robot "dog" designed to collect tennis balls on tennis courts during practice sessions and clinics. The robot operates only when points are finished, can hold multiple balls, and delivers them to players or deposits them in storage bins.

## Operating Modes

### Mode 1: Practice Mode
- Continuous collection during individual practice
- Works on opposite side from player
- Deposits balls frequently in bins
- Automatically switches sides with player
- Individual player focused operation

### Mode 2: Clinic/Class Mode
- Parks at charging pad during drills (WAIT mode)
- Activates on instructor command when basket is empty
- Rapid collection of all balls on court (COLLECT mode)
- Systematic grid pattern for efficiency
- Returns to WAIT mode when court is clear
- Can handle 2-3 hour clinics with batch collection

## Design Features

### Frame & Structure
- **Construction**: 3D printed modular design
- **Materials**: 
  - PETG for main frame (UV resistant, outdoor durable)
  - TPU for flexible components (scoop, tires, bumpers)
  - ASA for extreme UV exposure parts (solar mount)
- **Weight Target**: 5-8 kg total
- **Infill**: 20% honeycomb/gyroid pattern
- **Assembly**: Snap-fit joints with M3 bolt reinforcement

### Durability Features
- **Rubber Bumpers**: TPU bumpers on all corners and impact zones
- **Protected Components**: 
  - Recessed sensors behind protective grilles
  - Electronics in sealed compartment (IP54 rating)
  - Conformal coating on all PCBs
- **Reinforced Areas**:
  - Motor mounts with extra wall thickness
  - Stress points with 30% infill density
  - Metal inserts at high-wear connection points

### Ball Collection System
- **Front Scoop**: 
  - Wide funnel design (1m opening narrowing to 0.3m)
  - TPU flexible mesh that won't damage balls
  - Angled side walls to guide balls inward
- **Internal Hopper**: 
  - Integrated into main body (no gaps)
  - Gravity-fed collection area
  - Capacity for staging 5-10 balls
- **Transfer Mechanism**:
  - Rotating paddle wheel prevents jams
  - Positive push system moves balls to basket
  - Vertical elevator for lifting balls to basket height

### Basket System
- **Modular Sizes**:
  - Small: 20-30 balls
  - Medium: 40-60 balls  
  - Large: 80-100 balls
- **Design**: 
  - Removable with ergonomic handle
  - Wire-frame construction like standard ball hoppers
  - Quick-release mounting system
  - Foldable arms for low profile during operation

### Power System

#### Battery Configuration
- **Hot-Swappable Design**: Dual battery slots for continuous operation
- **Battery Packs**: 
  - Standard: 8x 18650 cells in 4S2P (14.8V, 5000mAh)
  - Heavy Duty: 8x 21700 cells in 4S2P (14.8V, 8000mAh)
- **Runtime**: 
  - 1.5-2 hours continuous (standard pack)
  - 2.5-3 hours continuous (heavy duty pack)
- **Quick Change**: Tool-free removal with integrated handle
- **Multiple Packs**: Rotate 3-4 packs for all-day operation

#### Solar Charging
- **Panel**: 20W flat-mounted on top
- **Protection**: Clear polycarbonate cover
- **Integration**: Flush mount with robot body
- **Controller**: MPPT for optimal charging
- **Benefit**: Extends runtime by 30-50% on sunny days

#### Contact Charging
- **Charging Pads**: Multiple locations around court
- **Opportunistic Charging**: Robot charges between points
- **Spring-Loaded Contacts**: Reliable connection
- **Fast Charge**: 2-3 hours for full charge at dock

### Electronics & Control

#### Computing Platform
- **Main CPU**: Raspberry Pi 4 (8GB RAM)
- **Operating System**: ROS2 for modular control
- **Storage**: 32GB microSD for OS and models
- **Vision**: Pi Camera Module v2 for ball detection

#### Motors & Actuators
- **Drive Motors**: 4x 12V gear motors with encoders
- **Collection Motors**: 
  - Roller motor for ball pickup
  - Paddle wheel motor for ball transfer
  - Elevator motor for vertical lift
- **Control**: Arduino Nano for real-time motor control

#### Sensors
- **Navigation**: 
  - Ultrasonic sensors for obstacle avoidance
  - IMU (MPU6050) for orientation
  - Wheel encoders for odometry
- **Detection**:
  - Camera for ball and player tracking
  - Microphones for game state detection
- **Power**: INA219 for battery monitoring

### Software Architecture

#### Core Modules
1. **Vision Pipeline** (30Hz)
   - Ball detection using YOLO/MobileNet
   - Player position tracking
   - Court line detection
   
2. **Navigation Stack** (10Hz)
   - Path planning algorithms
   - Obstacle avoidance
   - Position estimation
   
3. **State Machine**
   - Practice mode controller
   - Clinic mode controller
   - Charging mode controller
   
4. **Hardware Interface**
   - Motor control (50Hz)
   - Sensor integration
   - Power management

#### AI Training Requirements
- **Data Collection**: 
  - Tennis ball images in various lighting
  - Court footage from robot perspective
  - Player movement patterns
- **Models**: 
  - TensorFlow Lite for edge deployment
  - OpenCV for court detection
- **Training Phases**:
  1. Static ball detection
  2. Movement and collection
  3. Safety and avoidance
  4. Mode switching logic
  5. Collection pattern optimization

## Manufacturing Specifications

### 3D Printing Guidelines
| Component | Material | Infill | Layer Height | Print Time |
|-----------|----------|---------|--------------|------------|
| Chassis sections | PETG | 20% | 0.2mm | 8-10 hrs each |
| Basket | PETG | 15% | 0.3mm | 12-15 hrs |
| Wheels | PETG/TPU | 30%/15% | 0.2mm | 3 hrs each |
| Bumpers | TPU 95A | 20% | 0.2mm | 2 hrs each |
| Solar mount | ASA | 25% | 0.2mm | 4 hrs |

**Total Print Time**: ~60-70 hours

### Assembly Requirements
1. **Tools Needed**:
   - 3D printer (minimum 220x220mm bed)
   - Soldering station
   - Basic hand tools
   - Multimeter
   
2. **Hardware**:
   - M3 bolts and nuts
   - Ball bearings for wheels
   - Metal inserts for high-stress points
   - Silicone gaskets for weatherproofing

### Cost Breakdown
- **3D Printing Filament**: $80-100
- **Electronics Package**: $300-400
- **Motors & Drivers**: $150-200
- **Battery Packs** (3x): $120-180
- **Solar Panel & Controller**: $50-80
- **Hardware & Misc**: $50-100
- **Total Estimated Cost**: $750-1,060

## Performance Specifications

### Operating Parameters
- **Speed**: 1.5 m/s maximum
- **Collection Rate**: 10-15 balls per minute
- **Operating Temperature**: 0-45°C
- **Weather Resistance**: IP54 rating
- **Court Surfaces**: Hard court, clay, synthetic

### Testing Protocol
1. **Bench Testing**:
   - Motor calibration
   - Sensor verification
   - Vision system accuracy
   
2. **Court Testing**:
   - Ball pickup success rate (target: >95%)
   - Navigation accuracy
   - Battery life verification
   - Mode switching reliability
   
3. **Endurance Testing**:
   - 4-hour continuous operation
   - Weather resistance verification
   - 10 cycles per day durability
   - Charging cycle validation

## Safety Features
- **Collision Avoidance**: Ultrasonic sensors with 1m detection range
- **Emergency Stop**: Manual override button
- **Speed Limiting**: Reduced speed near players
- **Visual Indicators**: LED status lights for operation mode
- **Protective Bumpers**: TPU bumpers on all impact zones
- **Fail-Safe Mode**: Returns to charging dock on system errors

## Future Enhancements
- Voice command integration
- Mobile app for remote control
- Multiple robot coordination for large clinics
- Advanced ball trajectory prediction
- Integration with court booking systems
- Performance analytics for players

## 3D Design Tools & Honeycomb Structure Development

### Design Software for Honeycomb Components

#### Professional CAD Software
- **Fusion 360**: Parametric modeling with built-in lattice/honeycomb generation
- **SolidWorks**: Engineering designs with lattice structure add-ins
- **Rhino with Grasshopper**: Complex parametric honeycomb patterns
- **nTopology**: Specialized in advanced lattice and cellular structures

#### Free/Open Source Options
- **FreeCAD**: Open-source with lattice workbench add-on
- **Blender**: Organic honeycomb patterns using modifiers
- **OpenSCAD**: Code-based parametric honeycomb generation
- **Tinkercad**: Simple tool for basic honeycomb designs

### VS Code Extensions for 3D Printing Development

#### 3D File Viewers
- **3D Viewer for VSCode**: View STL, OBJ, 3MF files directly in editor
- **STL Viewer**: Lightweight STL file preview
- **glTF Tools**: View and validate glTF 3D models

#### CAD Scripting Support
- **OpenSCAD Extension**: 
  - Syntax highlighting and preview
  - IntelliSense support
  - Built-in renderer for .scad files
- **CadQuery**: Python-based CAD with 3D preview
- **JSCAD**: JavaScript-based modeling with live preview

#### G-Code & Firmware
- **G-Code Syntax**: Highlighting and documentation
- **PlatformIO IDE**: For Marlin firmware customization
- **3D Printing Snippets**: Common calculations and formulas

### Honeycomb Structure Design Guidelines

#### Structural Parameters
- **Wall Thickness**: 0.8-2mm for FDM printing
- **Cell Size**: 5-20mm diameter based on application
- **Height-to-Width Ratio**: Keep under 3:1 for stability
- **Infill Density**: 15-30% for structural components

#### Optimization Strategies
- Variable density honeycomb (denser at stress points)
- Hexagonal pattern for maximum strength-to-weight
- Vertical cell orientation for better print quality
- Solid shells around honeycomb cores

### Example: Parametric Honeycomb Generation (OpenSCAD)

```scad
// Honeycomb pattern for robot frame components
module honeycomb_frame(length, width, height) {
    cell_size = 10;
    wall_thickness = 1.2;
    
    difference() {
        // Outer shell
        cube([length, width, height]);
        
        // Honeycomb cutouts
        for(x = [cell_size : cell_size*1.5 : length-cell_size]) {
            for(y = [cell_size : cell_size*sqrt(3) : width-cell_size]) {
                translate([x + (y/cell_size/sqrt(3))%2 * cell_size*0.75, y, -1])
                    cylinder(h=height+2, r=cell_size/2-wall_thickness, $fn=6);
            }
        }
    }
}
```

### Recommended Workflow for Robot Components

1. **Design Phase**:
   - Model solid structure in Fusion 360/FreeCAD
   - Apply honeycomb infill to non-critical areas
   - Use VS Code with OpenSCAD for parametric components
   - Simulate stress points before printing

2. **Slicing Strategy**:
   - Use Cura/PrusaSlicer honeycomb infill
   - Orient parts for optimal strength
   - Custom support structures for overhangs

3. **Material Selection by Component**:
   - Frame: PETG with 20% honeycomb infill
   - Bumpers: TPU with 15% honeycomb for flexibility
   - Electronics mounts: PLA+ with 30% infill for rigidity
   - Outdoor parts: ASA with UV-resistant coating

### Testing Honeycomb Structures
- Compression testing for load-bearing parts
- Impact testing for protective components
- Fatigue testing for moving parts
- Weight optimization iterations