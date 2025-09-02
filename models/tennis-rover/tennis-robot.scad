// The Tennis Rover - 3D Model
// Based on design specifications from docs/the-tennis-rover-design.md

// Global Parameters
$fn = 50; // Resolution for curved surfaces
scale_factor = 1; // 1 for full size, 0.1 for 1:10 prototype

// Robot dimensions (in mm)
robot_length = 600 * scale_factor;
robot_width = 400 * scale_factor;
robot_height = 300 * scale_factor;
wall_thickness = 3;

// Colors for visualization
chassis_color = [0.2, 0.7, 0.3]; // Green
solar_color = [0.1, 0.2, 0.5]; // Dark Blue
scoop_color = [1, 0.5, 0]; // Orange
basket_color = [0.8, 0.8, 0.8]; // Light Gray
wheel_color = [0.2, 0.2, 0.2]; // Dark Gray
bumper_color = [0.9, 0.1, 0.1]; // Red

// Main assembly
module tennis_robot() {
    // Main chassis with integrated hopper
    color(chassis_color)
    chassis_with_hopper();
    
    // Solar panel with protective cover
    translate([0, 0, robot_height])
    solar_panel_assembly();
    
    // Front scoop
    translate([robot_length/2 - 50, 0, 30])
    color(scoop_color)
    ball_scoop();
    
    // Wheels
    wheel_assembly();
    
    // Basket (removable)
    translate([-robot_length/2 + 100, 0, 100])
    color(basket_color)
    ball_basket();
    
    // Protective bumpers
    bumpers();
    
    // Battery packs
    translate([0, -robot_width/3, 50])
    battery_pack();
    translate([0, robot_width/3, 50])
    battery_pack();
}

// Chassis with integrated hopper (no gaps as specified)
module chassis_with_hopper() {
    difference() {
        // Main body
        rounded_box(robot_length, robot_width, robot_height, 10);
        
        // Hollow interior for electronics and hopper
        translate([0, 0, wall_thickness])
        rounded_box(
            robot_length - 2*wall_thickness,
            robot_width - 2*wall_thickness,
            robot_height - wall_thickness,
            8
        );
        
        // Hopper cavity in rear section
        translate([-robot_length/4, 0, robot_height/3])
        rounded_box(
            robot_length/2 - 2*wall_thickness,
            robot_width - 4*wall_thickness,
            robot_height/2,
            5
        );
        
        // Ball feed opening
        translate([-robot_length/2 + 50, 0, robot_height/2])
        rotate([0, 90, 0])
        cylinder(h=100, r=30);
        
        // Motor mount cutouts
        for(x = [-1, 1]) {
            for(y = [-1, 1]) {
                translate([x * robot_length/3, y * robot_width/3, 0])
                cylinder(h=50, r=15);
            }
        }
    }
    
    // Add honeycomb structure for strength and weight reduction
    translate([robot_length/4, 0, robot_height/2])
    honeycomb_panel(robot_length/3, robot_width/2, wall_thickness);
}

// Solar panel assembly with protective plexiglass
module solar_panel_assembly() {
    // Solar cells
    color(solar_color)
    translate([0, 0, -2])
    solar_panel();
    
    // Protective plexiglass cover
    color([0.9, 0.9, 1, 0.3])
    rounded_box(robot_length - 20, robot_width - 20, 3, 5);
    
    // Frame
    color([0.5, 0.5, 0.5])
    difference() {
        rounded_box(robot_length - 10, robot_width - 10, 5, 5);
        translate([0, 0, -1])
        rounded_box(robot_length - 30, robot_width - 30, 7, 5);
    }
}

// Solar panel with cells
module solar_panel() {
    difference() {
        cube([robot_length - 30, robot_width - 30, 2], center=true);
        
        // Solar cell pattern
        for(x = [-3:3]) {
            for(y = [-2:2]) {
                translate([x * 70, y * 60, 0])
                cube([65, 55, 3], center=true);
            }
        }
    }
}

// Ball scoop with funnel design
module ball_scoop() {
    // Funnel shape - wide opening narrowing to collection point
    difference() {
        hull() {
            // Wide front opening
            translate([0, 0, 0])
            cube([10, robot_width * 0.8, 80], center=true);
            
            // Narrow rear
            translate([-60, 0, 0])
            cube([10, robot_width * 0.3, 60], center=true);
        }
        
        // Hollow interior
        hull() {
            translate([0, 0, 0])
            cube([12, robot_width * 0.75, 75], center=true);
            
            translate([-60, 0, 0])
            cube([12, robot_width * 0.25, 55], center=true);
        }
    }
    
    // Roller mechanism
    translate([5, 0, -20])
    rotate([0, 90, 0])
    cylinder(h=10, r=15);
}

// Wheel assembly
module wheel_assembly() {
    for(x = [-1, 1]) {
        for(y = [-1, 1]) {
            translate([x * robot_length/3, y * (robot_width/2 + 30), 30])
            rotate([90, 0, 0])
            wheel();
        }
    }
}

// Individual wheel
module wheel() {
    color(wheel_color)
    difference() {
        cylinder(h=30, r=50);
        translate([0, 0, -1])
        cylinder(h=32, r=45);
        
        // Tread pattern
        for(a = [0:30:359]) {
            rotate([0, 0, a])
            translate([48, 0, 15])
            cube([5, 10, 30], center=true);
        }
    }
    
    // Hub
    color([0.7, 0.7, 0.7])
    cylinder(h=35, r=15);
}

// Removable ball basket
module ball_basket() {
    // Wire frame basket design
    difference() {
        rounded_box(robot_length/2, robot_width * 0.7, 200, 10);
        translate([0, 0, 5])
        rounded_box(robot_length/2 - 10, robot_width * 0.7 - 10, 200, 10);
    }
    
    // Wire mesh pattern
    for(x = [-5:5]) {
        translate([x * 30, 0, 100])
        cube([2, robot_width * 0.7, 200], center=true);
    }
    
    for(y = [-3:3]) {
        translate([0, y * 40, 100])
        cube([robot_length/2, 2, 200], center=true);
    }
    
    // Handle
    translate([0, 0, 200])
    difference() {
        rounded_box(80, 30, 20, 10);
        translate([0, 0, -5])
        rounded_box(60, 20, 20, 8);
    }
}

// Protective bumpers
module bumpers() {
    color(bumper_color)
    for(corner = [[1,1], [1,-1], [-1,1], [-1,-1]]) {
        translate([
            corner[0] * (robot_length/2 - 10),
            corner[1] * (robot_width/2 - 10),
            30
        ])
        bumper_corner();
    }
}

// Individual bumper corner
module bumper_corner() {
    difference() {
        sphere(r=20);
        translate([0, 0, -20])
        cube([40, 40, 40], center=true);
    }
}

// Hot-swappable battery pack
module battery_pack() {
    color([0.3, 0.3, 0.8])
    difference() {
        rounded_box(150, 80, 40, 5);
        
        // Battery cell positions (8x 18650 cells in 4S2P)
        for(x = [-1.5:1:1.5]) {
            for(y = [-1:2:1]) {
                translate([x * 25, y * 20, 0])
                cylinder(h=41, r=9);
            }
        }
    }
    
    // Handle
    translate([0, 0, 20])
    color([1, 1, 0])
    difference() {
        rounded_box(60, 20, 10, 5);
        translate([0, 0, -2])
        rounded_box(45, 10, 10, 3);
    }
    
    // LED indicators
    for(i = [0:3]) {
        translate([-50 + i * 15, 35, 15])
        color([0, 1, 0])
        cylinder(h=2, r=3);
    }
}

// Honeycomb pattern for weight reduction
module honeycomb_panel(length, width, thickness) {
    cell_size = 15;
    
    intersection() {
        cube([length, width, thickness], center=true);
        
        union() {
            for(x = [-10:10]) {
                for(y = [-10:10]) {
                    translate([
                        x * cell_size * 1.5,
                        y * cell_size * sin(60) + (x % 2) * cell_size * sin(60) / 2,
                        0
                    ])
                    rotate([0, 0, 30])
                    cylinder(h=thickness + 1, r=cell_size/2, $fn=6, center=true);
                }
            }
        }
    }
}

// Paddle wheel mechanism for ball pushing
module paddle_wheel() {
    color([0, 0.8, 0])
    union() {
        // Central shaft
        cylinder(h=60, r=10);
        
        // Paddles
        for(a = [0:90:270]) {
            rotate([0, 0, a])
            translate([0, 0, 30])
            cube([50, 5, 50], center=true);
        }
    }
}

// Rounded box helper module
module rounded_box(length, width, height, radius) {
    hull() {
        for(x = [-1, 1]) {
            for(y = [-1, 1]) {
                translate([
                    x * (length/2 - radius),
                    y * (width/2 - radius),
                    0
                ])
                cylinder(h=height, r=radius, center=true);
            }
        }
    }
}

// Camera and sensor mount
module sensor_mount() {
    color([0.1, 0.1, 0.1])
    difference() {
        cube([40, 30, 20], center=true);
        translate([0, 0, 5])
        cube([35, 25, 15], center=true);
        
        // Camera lens opening
        translate([0, 15, 0])
        rotate([90, 0, 0])
        cylinder(h=10, r=8);
    }
}

// Charging contacts
module charging_contacts() {
    for(x = [-1, 1]) {
        translate([x * 30, 0, -5])
        color([0.8, 0.7, 0])
        union() {
            cylinder(h=10, r=10);
            translate([0, 0, 10])
            sphere(r=8);
        }
    }
}

// Render the complete robot
tennis_robot();

// Add sensors and electronics
translate([robot_length/2 - 50, 0, robot_height - 30])
sensor_mount();

// Add charging contacts on bottom
translate([0, 0, 0])
charging_contacts();

// Add paddle wheel in transfer mechanism
translate([-100, 0, robot_height/2])
rotate([90, 0, 0])
paddle_wheel();

// Export-ready version (uncomment to export)
// translate([0, 0, 0])
// tennis_robot();