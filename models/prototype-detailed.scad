// Tennis Ball Robot - Detailed 1:10 Scale Functional Prototype
// Designed for actual 3D printing and assembly
// Uses mini tennis balls (2cm diameter) or ping pong balls

// =============================================
// GLOBAL PARAMETERS
// =============================================
$fn = 60; // Good resolution for printing
tolerance = 0.2; // Clearance for moving parts
wall = 2; // Wall thickness for strength at small scale

// Robot dimensions (1:10 scale in mm)
body_length = 60;  // 600mm full scale
body_width = 40;   // 400mm full scale  
body_height = 30;  // 300mm full scale

// Electronics dimensions (actual sizes)
pi_zero_length = 65;
pi_zero_width = 30;
pi_zero_height = 5;

// Motor dimensions (N20 micro gear motors)
motor_length = 25;
motor_width = 12;
motor_height = 10;
motor_shaft_diameter = 3;
motor_shaft_length = 10;

// Ball dimensions
ball_diameter = 20; // 2cm mini tennis balls

// =============================================
// MAIN ASSEMBLY
// =============================================
module prototype_robot_assembly() {
    // Chassis base with all mounting points
    chassis_base();
    
    // Top cover (removable for electronics access)
    translate([0, 0, body_height - 2])
    %top_cover(); // Transparent preview
    
    // Ball collection scoop
    translate([body_length/2, 0, 5])
    collection_scoop();
    
    // Wheels and motors
    for(x = [15, -15]) {
        for(y = [body_width/2 + 5, -(body_width/2 + 5)]) {
            translate([x, y, 5]) {
                wheel_assembly();
                translate([0, -y/abs(y) * 8, 0])
                %motor_n20(); // Show motor placement
            }
        }
    }
    
    // Ball elevator mechanism
    translate([0, 0, 10])
    elevator_mechanism();
    
    // Removable basket
    translate([-body_length/2 + 5, 0, 15])
    mini_basket();
    
    // Electronics mounting preview
    translate([5, 0, 3])
    %electronics_layout();
}

// =============================================
// PART 1: CHASSIS BASE (Main Print)
// =============================================
module chassis_base() {
    difference() {
        // Main body
        rounded_cube([body_length, body_width, body_height], 3);
        
        // Hollow interior
        translate([0, 0, wall])
        rounded_cube([body_length - 2*wall, body_width - 2*wall, body_height], 2);
        
        // Motor mounting slots (4 motors)
        for(x = [15, -15]) {
            for(y = [1, -1]) {
                // Motor cavity
                translate([x, y * (body_width/2 - 6), 5])
                cube([motor_length + 1, motor_width + 1, motor_height + 1], center=true);
                
                // Shaft hole
                translate([x, y * (body_width/2 + 1), 5])
                rotate([90, 0, 0])
                cylinder(h=10, r=motor_shaft_diameter/2 + 0.5);
                
                // Motor mounting screw holes
                for(mx = [-8, 8]) {
                    translate([x + mx, y * (body_width/2 - 6), 0])
                    cylinder(h=15, r=1);
                }
            }
        }
        
        // Raspberry Pi Zero mounting holes
        translate([5, 0, wall]) {
            // Standoff holes
            for(x = [0, 58]) {
                for(y = [-23/2, 23/2]) {
                    translate([x - 29, y, 0])
                    cylinder(h=5, r=1.3);
                }
            }
        }
        
        // Camera cable slot
        translate([body_length/2 - 10, 0, body_height - 5])
        cube([3, 15, 10], center=true);
        
        // Battery compartment (2x 18650 or 4x AA)
        translate([-10, 0, wall])
        cube([35, 35, 15], center=true);
        
        // Ultrasonic sensor mounting
        translate([body_length/2 - 2, 0, 15]) {
            // HC-SR04 mounting holes
            for(y = [-13, 13]) {
                translate([0, y, 0])
                rotate([0, 90, 0])
                cylinder(h=10, r=8);
            }
        }
        
        // Ball transfer opening
        translate([5, 0, 12])
        rotate([0, 90, 0])
        cylinder(h=30, r=ball_diameter/2 + 1);
        
        // Ventilation slots
        for(x = [-20, -10, 0, 10, 20]) {
            translate([x, body_width/2 - 1, 10])
            cube([3, 4, 15], center=true);
            translate([x, -(body_width/2 - 1), 10])
            cube([3, 4, 15], center=true);
        }
        
        // Power switch hole
        translate([-body_length/2 + 5, body_width/2 - 1, 15])
        rotate([90, 0, 0])
        cylinder(h=5, r=3);
        
        // Charging port
        translate([-body_length/2 + 5, 0, 5])
        rotate([0, 90, 0])
        cylinder(h=5, r=2.5);
    }
    
    // Integrated mounting posts
    // Pi Zero standoffs
    translate([5, 0, wall]) {
        for(x = [0, 58]) {
            for(y = [-23/2, 23/2]) {
                translate([x - 29, y, 0])
                standoff(5, 2.5, 1);
            }
        }
    }
    
    // Motor driver standoffs
    translate([-10, 0, wall]) {
        for(x = [-10, 10]) {
            for(y = [-10, 10]) {
                translate([x, y, 0])
                standoff(4, 2.5, 1);
            }
        }
    }
}

// =============================================
// PART 2: COLLECTION SCOOP
// =============================================
module collection_scoop() {
    difference() {
        union() {
            // Scoop body with funnel shape
            hull() {
                // Wide opening
                translate([0, 0, 0])
                cube([2, body_width * 0.8, 15], center=true);
                
                // Narrow throat
                translate([-10, 0, 0])
                cube([2, ball_diameter + 4, 15], center=true);
            }
            
            // Mounting tabs
            for(y = [-body_width/3, body_width/3]) {
                translate([-2, y, 0])
                difference() {
                    cube([4, 8, 15], center=true);
                    rotate([0, 90, 0])
                    cylinder(h=5, r=1.5, center=true);
                }
            }
        }
        
        // Hollow interior
        hull() {
            translate([1, 0, 0])
            cube([2, body_width * 0.75, 12], center=true);
            
            translate([-9, 0, 0])
            cube([2, ball_diameter + 1, 12], center=true);
        }
        
        // Flex cuts for TPU printing
        for(i = [-2:2]) {
            translate([-5, i * 6, 0])
            cube([8, 0.5, 16], center=true);
        }
    }
    
    // Roller mechanism
    translate([2, 0, -5]) {
        difference() {
            cylinder(h=body_width * 0.7, r=4, center=true);
            cylinder(h=body_width * 0.7 + 1, r=1.5, center=true);
            
            // Grip pattern
            for(a = [0:30:330]) {
                rotate([0, 0, a])
                translate([3.5, 0, 0])
                cube([1, 1, body_width * 0.7 + 1], center=true);
            }
        }
    }
}

// =============================================
// PART 3: WHEEL ASSEMBLY
// =============================================
module wheel_assembly() {
    // Wheel
    difference() {
        union() {
            // Rim
            cylinder(h=8, r=12);
            
            // Tire (print in TPU for grip)
            color([0.3, 0.3, 0.3])
            difference() {
                cylinder(h=8, r=14);
                translate([0, 0, -1])
                cylinder(h=10, r=11);
            }
        }
        
        // Motor shaft hole (D-shaped)
        difference() {
            cylinder(h=9, r=motor_shaft_diameter/2 + 0.1);
            translate([motor_shaft_diameter/2 - 0.5, -5, -1])
            cube([2, 10, 11]);
        }
        
        // Set screw hole
        translate([0, 6, 4])
        rotate([90, 0, 0])
        cylinder(h=8, r=1);
        
        // Weight reduction
        for(a = [0:60:300]) {
            rotate([0, 0, a])
            translate([7, 0, -1])
            cylinder(h=10, r=2);
        }
    }
}

// =============================================
// PART 4: ELEVATOR MECHANISM
// =============================================
module elevator_mechanism() {
    // Elevator housing
    difference() {
        cube([15, ball_diameter + 6, 25], center=true);
        
        // Ball channel
        cube([13, ball_diameter + 2, 23], center=true);
        
        // Entry hole
        translate([8, 0, -5])
        rotate([0, 90, 0])
        cylinder(h=10, r=ball_diameter/2 + 1);
        
        // Exit hole
        translate([-8, 0, 10])
        rotate([0, 90, 0])
        cylinder(h=10, r=ball_diameter/2 + 1);
    }
    
    // Paddle wheel
    translate([0, 0, 0])
    rotate([90, 0, 0]) {
        // Shaft
        cylinder(h=ball_diameter + 10, r=1.5, center=true);
        
        // Paddles
        for(a = [0:90:270]) {
            rotate([0, 0, a])
            translate([0, 0, 0])
            cube([ball_diameter - 2, 2, ball_diameter + 8], center=true);
        }
    }
    
    // Motor mount for paddle wheel
    translate([0, ball_diameter/2 + 8, 0])
    motor_mount_bracket();
}

// =============================================
// PART 5: MINI BASKET
// =============================================
module mini_basket() {
    difference() {
        union() {
            // Basket frame
            difference() {
                rounded_cube([25, 30, 35], 2);
                translate([0, 0, 2])
                rounded_cube([22, 27, 35], 2);
            }
            
            // Handle
            translate([0, 0, 35])
            difference() {
                rounded_cube([15, 8, 8], 2);
                translate([0, 0, -2])
                rounded_cube([11, 5, 8], 1);
            }
            
            // Mounting rails
            for(y = [-12, 12]) {
                translate([10, y, 2])
                cube([5, 3, 3], center=true);
            }
        }
        
        // Mesh pattern (for looks and weight reduction)
        for(z = [5:8:30]) {
            for(x = [-8:8:8]) {
                translate([x, 15, z])
                rotate([90, 0, 0])
                cylinder(h=35, r=2);
            }
        }
        
        for(z = [5:8:30]) {
            for(y = [-10:8:10]) {
                translate([12, y, z])
                rotate([0, 90, 0])
                cylinder(h=30, r=2);
            }
        }
    }
}

// =============================================
// PART 6: TOP COVER
// =============================================
module top_cover() {
    difference() {
        union() {
            // Main cover
            rounded_cube([body_length - 0.4, body_width - 0.4, 2], 2);
            
            // Snap fit tabs
            for(x = [-20, 0, 20]) {
                for(y = [1, -1]) {
                    translate([x, y * (body_width/2 - 3), -2])
                    snap_tab();
                }
            }
        }
        
        // Camera mount hole
        translate([body_length/2 - 15, 0, 0])
        cylinder(h=3, r=4);
        
        // Ventilation pattern
        for(x = [-20:10:20]) {
            for(y = [-10:10:10]) {
                translate([x, y, 0])
                cylinder(h=3, r=2);
            }
        }
        
        // LED indicator holes
        for(i = [-1:1]) {
            translate([i * 8, body_width/2 - 5, 0])
            cylinder(h=3, r=1.5);
        }
    }
    
    // Camera mount post
    translate([body_length/2 - 15, 0, -5])
    camera_mount();
}

// =============================================
// PART 7: ELECTRONICS LAYOUT (Reference)
// =============================================
module electronics_layout() {
    // Raspberry Pi Zero
    color([0, 0.5, 0])
    translate([-20, 0, 0])
    cube([pi_zero_length, pi_zero_width, pi_zero_height], center=true);
    
    // Motor driver
    color([0.8, 0, 0])
    translate([15, 0, 0])
    cube([30, 25, 2], center=true);
    
    // Battery pack (2x 18650)
    color([0, 0, 0.8])
    translate([-10, 0, -5])
    for(y = [-9, 9]) {
        translate([0, y, 0])
        rotate([0, 90, 0])
        cylinder(h=65, r=9, center=true);
    }
    
    // Camera
    color([0.2, 0.2, 0.2])
    translate([body_length/2 - 15, 0, 20])
    cube([8, 8, 5], center=true);
}

// =============================================
// HELPER MODULES
// =============================================

module rounded_cube(size, radius) {
    hull() {
        for(x = [radius - size[0]/2, size[0]/2 - radius]) {
            for(y = [radius - size[1]/2, size[1]/2 - radius]) {
                for(z = [radius - size[2]/2, size[2]/2 - radius]) {
                    translate([x, y, z])
                    sphere(r=radius);
                }
            }
        }
    }
}

module standoff(height, outer_r, inner_r) {
    difference() {
        cylinder(h=height, r=outer_r);
        translate([0, 0, height - 3])
        cylinder(h=4, r=inner_r);
    }
}

module motor_n20() {
    // N20 micro gear motor model
    color([0.7, 0.7, 0.7]) {
        cube([motor_length, motor_width, motor_height], center=true);
        translate([motor_length/2, 0, 0])
        rotate([0, 90, 0])
        cylinder(h=motor_shaft_length, r=motor_shaft_diameter/2);
    }
}

module snap_tab() {
    hull() {
        cube([3, 5, 0.5], center=true);
        translate([0, 0, -2])
        cube([3, 4, 0.5], center=true);
    }
    translate([0, 0, -2.5])
    sphere(r=1);
}

module motor_mount_bracket() {
    difference() {
        cube([motor_width + 4, motor_length + 4, 3], center=true);
        cube([motor_width, motor_length, 4], center=true);
        
        // Screw holes
        for(x = [-6, 6]) {
            for(y = [-10, 10]) {
                translate([x, y, 0])
                cylinder(h=4, r=1, center=true);
            }
        }
    }
}

module camera_mount() {
    difference() {
        union() {
            cylinder(h=8, r=5);
            translate([0, 0, 8])
            sphere(r=5);
        }
        
        // Camera board slot
        translate([0, 0, 6])
        cube([9, 9, 4], center=true);
        
        // Cable hole
        cylinder(h=15, r=2);
        
        // Adjustment slots
        for(a = [0:90:270]) {
            rotate([0, 0, a])
            translate([0, 4, 8])
            rotate([90, 0, 0])
            cylinder(h=3, r=1, center=true);
        }
    }
}

// =============================================
// INDIVIDUAL PARTS FOR PRINTING
// =============================================

// Uncomment one at a time to export as STL:

// chassis_base();
// collection_scoop();
// wheel_assembly();
// elevator_mechanism();
// mini_basket();
// top_cover();

// =============================================
// FULL ASSEMBLY VIEW
// =============================================

prototype_robot_assembly();

// =============================================
// PRINTING INSTRUCTIONS
// =============================================

// Part 1: Chassis Base
// Time: 4 hours
// Material: PETG
// Infill: 20%
// Support: No

// Part 2: Collection Scoop  
// Time: 1 hour
// Material: TPU 95A (flexible)
// Infill: 15%
// Support: Yes

// Part 3: Wheels (x4)
// Time: 30 min each
// Material: PETG + TPU tire
// Infill: 20%
// Support: No

// Part 4: Elevator Mechanism
// Time: 1.5 hours
// Material: PETG
// Infill: 20%
// Support: Yes

// Part 5: Mini Basket
// Time: 2 hours
// Material: PETG
// Infill: 15%
// Support: No

// Part 6: Top Cover
// Time: 1 hour
// Material: PETG
// Infill: 15%
// Support: No