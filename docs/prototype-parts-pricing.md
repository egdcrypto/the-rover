# Mini Prototype Parts List & Pricing
## 1:10 Scale Proof of Concept (Desktop Size)

### Prototype Specifications
- **Size**: 20cm x 15cm x 12cm (about 8" x 6" x 5")
- **Test Area**: 2.4m x 1.1m scaled tennis court (8ft x 3.6ft)
- **Mini Tennis Balls**: Ping pong balls or foam balls
- **Goal**: Prove AI detection, navigation, and collection mechanics

---

## Core Electronics - $165

### Computing & Vision
| Part | Supplier | Price | Notes |
|------|----------|-------|-------|
| Raspberry Pi Zero 2 W | [Adafruit](https://www.adafruit.com/product/5291) | $15 | Quad-core, WiFi/BT built-in |
| Pi Camera Module v3 | [Adafruit](https://www.adafruit.com/product/5657) | $25 | Better low-light, autofocus |
| 32GB MicroSD Card | Amazon | $8 | For OS and models |
| **Alternative**: ESP32-CAM | Amazon | $10 | Budget option if Pi unavailable |

### Power System
| Part | Supplier | Price | Notes |
|------|----------|-------|-------|
| 2S LiPo Battery 1500mAh | Amazon/HobbyKing | $15 | 7.4V, ~1hr runtime |
| TP4056 Charging Module | Amazon (5-pack) | $8 | USB charging |
| DC-DC Buck Converter | Amazon | $6 | 7.4V to 5V for Pi |
| Battery Holder/Connector | Amazon | $5 | JST connector |

### Motors & Control
| Part | Supplier | Price | Notes |
|------|----------|-------|-------|
| N20 Gear Motors (4x) | Amazon | $20 | 100-200 RPM, 6V |
| L298N Motor Driver | Amazon | $7 | Dual H-bridge |
| Mini Servo (for scoop) | Amazon | $8 | SG90 or similar |
| Wheels (4x) | Amazon | $12 | 65mm rubber wheels |

### Sensors
| Part | Supplier | Price | Notes |
|------|----------|-------|-------|
| HC-SR04 Ultrasonic (2x) | Amazon | $8 | Distance sensing |
| MPU6050 IMU | Amazon | $5 | Orientation tracking |
| Limit Switches (4x) | Amazon | $6 | Bump detection |
| LEDs & Resistors | Amazon | $5 | Status indicators |

### Wiring & Connectors
| Part | Supplier | Price | Notes |
|------|----------|-------|-------|
| Jumper Wires | Amazon | $7 | M-F, M-M, F-F set |
| Mini Breadboard | Amazon | $5 | For prototyping |
| Heat Shrink Tubing | Amazon | $6 | Wire management |
| Electrical Tape | Local | $3 | Insulation |

**Electronics Subtotal: $165**

---

## Mechanical Parts - $45

### 3D Printing
| Part | Source | Price | Notes |
|------|--------|-------|-------|
| PETG Filament (0.5kg) | Amazon | $12 | Main chassis |
| TPU Filament (0.25kg) | Amazon | $10 | Flexible scoop |
| Print Service (if no printer) | Craftcloud3D | $40-60 | Full set |

### Hardware
| Part | Supplier | Price | Notes |
|------|----------|-------|-------|
| M3 Screw Set | Amazon | $8 | Various lengths |
| Ball Bearings (608ZZ) | Amazon | $6 | For wheels |
| Aluminum Standoffs | Amazon | $7 | Electronics mounting |
| Zip Ties | Local | $2 | Cable management |

**Mechanical Subtotal: $45**

---

## Optional Upgrades - $85

### Better Performance
| Part | Price | Benefit |
|------|-------|---------|
| Raspberry Pi 4 (2GB) | $45 | 10x faster processing |
| Coral USB Accelerator | $60 | AI inference boost |
| Better Camera (IMX219) | $30 | Higher resolution |
| Encoder Motors | $40 | Precise odometry |

### Advanced Sensors
| Part | Price | Benefit |
|------|-------|---------|
| VL53L0X ToF Sensor | $15 | Better distance sensing |
| Color Sensor (TCS34725) | $8 | Ball color verification |
| Line Following Sensors | $12 | Court line detection |

---

## Budget Options

### Minimum Viable Prototype - $95
- ESP32-CAM ($10)
- 4x DC Motors ($12)
- L298N Driver ($7)
- 18650 Batteries + Holder ($15)
- HC-SR04 Sensor ($4)
- 3D Printed Parts ($30)
- Basic Hardware ($17)

### Mid-Range Build - $210
- All core electronics ($165)
- All mechanical parts ($45)

### Full Featured - $295
- Core + Mechanical ($210)
- Raspberry Pi 4 upgrade (+$30)
- Better sensors (+$35)
- Encoder motors (+$20)

---

## Supplier Links & Alternatives

### Primary Suppliers
1. **Adafruit** - Quality parts, good documentation
2. **Amazon** - Fast shipping, bundles available
3. **AliExpress** - Cheapest option (2-4 week shipping)
4. **Sparkfun** - Alternative to Adafruit
5. **Microcenter** - Local pickup if available

### 3D Printing Services
1. **Local Library** - Many have free/cheap 3D printers
2. **Craftcloud3D** - Compare multiple services
3. **Treatstock** - Local printer network
4. **Shapeways** - Higher quality, more expensive
5. **University Makerspaces** - Student access

### Budget Shopping Tips
- Buy motor/sensor kits for better value
- Check Facebook Marketplace for used parts
- University surplus stores often have components
- Electronic recycling centers for free parts
- Bundle purchases on AliExpress save 40-50%

---

## Sample Shopping Cart

### Amazon Quick List ($185)
```
1. ELEGOO UNO R3 Project Kit - $65
   (Includes Arduino, sensors, wires, breadboard)
   
2. 4WD Robot Car Chassis Kit - $25
   (Motors, wheels, chassis, battery holder)
   
3. Raspberry Pi Zero 2 W - $25
   (If in stock, otherwise use Arduino)
   
4. Pi Camera v2 - $25
   
5. 2S LiPo Battery + Charger - $20
   
6. M3 Hardware Kit - $10
   
7. PETG Filament Sample - $15
```

### AliExpress Budget List ($75)
```
1. ESP32-CAM Module - $5
2. 4x N20 Motors with Wheels - $12
3. L298N Motor Driver - $3
4. HC-SR04 Sensors (5 pack) - $5
5. 18650 Battery Holder + Cells - $10
6. MPU6050 Module - $2
7. Jumper Wire Kit - $3
8. M3 Screw Set - $5
9. 3D Printing Service - $30
```

---

## Development Phases

### Phase 1: Basic Movement ($50)
- Arduino/ESP32
- 4 motors + driver
- Battery
- Basic chassis

### Phase 2: Add Vision ($35)
- Camera module
- Raspberry Pi Zero 2 W upgrade

### Phase 3: Smart Navigation ($30)
- Ultrasonic sensors
- IMU
- Better algorithms

### Phase 4: Ball Collection ($20)
- Servo motor
- Flexible scoop
- Collection basket

### Phase 5: Optimization ($50)
- Better processor
- Encoder motors
- Advanced sensors

---

## Cost-Saving Alternatives

### Free/Recycled Parts
- **Chassis**: Cardboard prototype first
- **Wheels**: Bottle caps or toy car wheels  
- **Motors**: Old RC cars, DVD drives
- **Battery**: Power bank with 5V output
- **Sensors**: Salvage from old electronics
- **Computer**: Use existing Raspberry Pi/Arduino

### Educational Discounts
- Many suppliers offer 10-20% student discounts
- University bookstores may stock parts
- Educational grants available for STEM projects
- School robotics clubs may share components

---

## Total Investment Summary

| Build Level | Cost | Development Time | Success Probability |
|-------------|------|------------------|-------------------|
| Cardboard Prototype | $50 | 1 week | 60% |
| Basic 3D Printed | $95 | 2 weeks | 75% |
| Standard Build | $210 | 3-4 weeks | 85% |
| Advanced Build | $295 | 4-6 weeks | 95% |

## Recommended Starting Point
**Start with $95 minimum build** to prove concept, then upgrade components as needed. Most parts are reusable for the full-size robot.

---

## ROI Analysis

### Prototype Investment: $210
### Full Robot Build: $1,000
### Tennis Club Savings: $15,000/year
### **Payback Period: 2 months**

The prototype validates the technology for less than 2% of annual savings!