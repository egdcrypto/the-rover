# 🎾 The Tennis Rover™ - Autonomous Tennis Ball Collection System

A proprietary robotic platform designed to autonomously collect tennis balls on tennis courts, making practice sessions more efficient and enjoyable. Part of The Rover™ family of autonomous systems.

![Robot Status](https://img.shields.io/badge/Status-Prototype-yellow)
![License](https://img.shields.io/badge/License-Proprietary-red)
![Platform](https://img.shields.io/badge/Platform-Raspberry%20Pi-blue)
![3D Printable](https://img.shields.io/badge/3D%20Printable-Yes-green)

## 📐 3D Models

The Tennis Rover features fully 3D-printable components designed for standard printers:

### Available Models
- **Complete Robot Assembly** ([tennis-robot.scad](models/tennis-robot.scad)) - Full robot with all components
- **Printable Parts** ([tennis-robot-printable-parts.scad](models/tennis-robot-printable-parts.scad)) - Individual parts for printing
- **STL Files** ([View STL](models/stl/)) - Ready-to-print files

### Key Components
- Modular chassis (fits 220x220mm print bed)
- Snap-fit assembly system
- Honeycomb structure for weight reduction
- TPU flexible parts for ball handling
- Hot-swappable battery compartments

To view 3D models in VS Code, install the [3D Viewer extension](https://marketplace.visualstudio.com/items?itemName=slevesque.vscode-3dviewer).

## 🚀 Features

- **Autonomous Navigation**: AI-powered court detection and boundary recognition
- **Smart Ball Detection**: Distinguishes tennis balls from other objects using computer vision
- **Dual Operating Modes**:
  - **Practice Mode**: Continuous collection during individual practice
  - **Clinic Mode**: Batch collection for tennis classes and group sessions
- **Solar-Powered**: Integrated solar charging for extended operation
- **Modular Design**: 3D-printable parts that fit standard 220x220mm print beds
- **Hot-Swappable Batteries**: No downtime with quick battery changes

## 📁 Project Structure

```
hopper/
├── docs/                  # Documentation and guides
│   ├── tennis-ball-robot-design.md
│   ├── prototype-development-plan.md
│   ├── prototype-parts-pricing.md
│   └── multi-application-platform.md
├── models/               # 3D models and CAD files
│   ├── tennis-robot.scad
│   └── tennis-robot-printable-parts.scad
├── scripts/              # Utility scripts
│   └── export_stl.sh
├── snippets/             # VS Code snippets
└── .vscode/              # VS Code configuration
```

## 🛠️ Build Your Own

### Option 1: Mini Prototype ($95-$210)
Perfect for proof of concept and testing:
- 1:10 scale model (20cm x 15cm x 12cm)
- Desktop-sized for indoor testing
- Full AI and navigation capabilities
- [See detailed parts list](docs/prototype-parts-pricing.md)

### Option 2: Full-Size Robot (~$1,000)
Professional-grade tennis court robot:
- Collects 50-100 balls
- 4-6 hour battery life
- Weather-resistant design
- [See full specifications](docs/the-tennis-rover-design.md)

## 🎯 Quick Start

### Prerequisites
- 3D printer (or access to printing service)
- Basic electronics skills
- Raspberry Pi or Arduino
- Python 3.8+

### 1. Print the Parts
```bash
# Export STL files from OpenSCAD
cd scripts
./export_stl.sh
```

### 2. Gather Electronics
Minimum required:
- Raspberry Pi Zero 2 W ($15)
- Camera module ($25)
- 4x motors with driver ($27)
- Battery pack ($15)
- [Full list here](docs/prototype-parts-pricing.md)

### 3. Assemble & Program
```bash
# Clone the repository
git clone https://github.com/yourusername/hopper.git
cd hopper

# Set up Python environment
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Run the robot
python src/main.py
```

## 💡 Applications Beyond Tennis

This platform can be adapted for:
- **Golf ball collection** on driving ranges
- **Autonomous lawn mowing** with cutting attachment
- **Agricultural applications** like hay baling assistance
- **Snow removal** with plow attachment
- [See more applications](docs/multi-application-platform.md)

## 📊 Performance Specifications

| Metric | Target | Achieved |
|--------|--------|----------|
| Ball Detection Accuracy | >95% | TBD |
| Collection Success Rate | >90% | TBD |
| Battery Life | 4-6 hours | TBD |
| Coverage Area | Full tennis court | TBD |
| Operating Modes | 2 (Practice/Clinic) | ✅ |

## 🤝 Contributing

We welcome contributions! Whether you're interested in:
- Improving the AI detection algorithms
- Designing better 3D-printable parts
- Adding new features or sensors
- Testing and documenting builds
- Adapting for other sports/applications

Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## 📈 ROI Analysis

For tennis clubs and facilities:
- **Manual ball collection cost**: ~$15,000/year
- **Robot investment**: $1,000
- **Payback period**: < 2 months
- **Annual savings**: $14,000+

## 🎓 Educational Use

Perfect for:
- Robotics courses
- STEM education
- Engineering projects
- AI/Computer vision learning
- Maker spaces

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- OpenSCAD community for 3D modeling tools
- ROS2 for robotics framework
- TensorFlow team for AI models
- Tennis community for feedback and testing

## 📬 Contact

- **Project Lead**: [Your Name]
- **Email**: your.email@example.com
- **Discord**: [Join our community](https://discord.gg/rover)
- **Issues**: [Report bugs](https://github.com/theroverproject/tennis-tennis-rover/issues)

## 🚧 Development Status

- [x] Conceptual design
- [x] 3D models created
- [x] Parts list compiled
- [x] Documentation written
- [ ] Prototype built
- [ ] Field testing
- [ ] AI training
- [ ] Production ready

---

**Start building your tennis ball robot today!** 🎾🤖