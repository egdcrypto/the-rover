// The Security Rover - Tank-Style Tracked Chassis
// Rugged all-terrain security patrol platform with night vision

// =============================================
// GLOBAL PARAMETERS
// =============================================
$fn = 60;
wall = 3;

// Chassis dimensions (mm)
chassis_length = 800;    // Longer for stability
chassis_width = 600;     // Wider for tank tracks
chassis_height = 200;    // Lower profile, harder to tip
track_width = 120;       // Wide tracks for terrain
track_height = 150;      // Large tracks for obstacles

// Armor plating angle for intimidation and durability
armor_angle = 15;

// =============================================
// MAIN ASSEMBLY
// =============================================
module security_rover_tank() {
    // Armored main chassis
    armored_chassis();
    
    // Tank track assemblies
    translate([0, chassis_width/2 - track_width/2, -50])
    track_assembly();
    translate([0, -(chassis_width/2 - track_width/2), -50])
    mirror([0, 1, 0])
    track_assembly();
    
    // Sensor turret (360° rotation)
    translate([chassis_length/4, 0, chassis_height])
    sensor_turret();
    
    // Front intimidation/protection
    translate([chassis_length/2, 0, 50])
    front_armor_plate();
    
    // Rear equipment bay
    translate([-chassis_length/2 + 50, 0, chassis_height/2])
    equipment_bay();
    
    // Side armor panels with cameras
    side_armor_panels();
    
    // Top-mounted solar panel (optional)
    translate([0, 0, chassis_height + 50])
    %armored_solar_panel();
}

// =============================================
// ARMORED CHASSIS
// =============================================
module armored_chassis() {
    difference() {
        union() {
            // Main hull with sloped armor
            hull() {
                // Bottom (wider)
                translate([0, 0, 0])
                cube([chassis_length, chassis_width, 10], center=true);
                
                // Top (narrower for armor angle)
                translate([0, 0, chassis_height])
                cube([
                    chassis_length - 50,
                    chassis_width - 100,
                    10
                ], center=true);
            }
            
            // Reinforced corners
            for(x = [-1, 1]) {
                for(y = [-1, 1]) {
                    translate([
                        x * (chassis_length/2 - 30),
                        y * (chassis_width/2 - 30),
                        chassis_height/2
                    ])
                    armor_corner();
                }
            }
        }
        
        // Hollow interior for components
        translate([0, 0, wall])
        hull() {
            translate([0, 0, 10])
            cube([
                chassis_length - 20,
                chassis_width - 20,
                10
            ], center=true);
            
            translate([0, 0, chassis_height - 10])
            cube([
                chassis_length - 70,
                chassis_width - 120,
                10
            ], center=true);
        }
        
        // Track mounting points
        for(y = [1, -1]) {
            for(x = [-chassis_length/3, 0, chassis_length/3]) {
                translate([x, y * (chassis_width/2 - 50), 0])
                cylinder(h=100, r=10);
            }
        }
        
        // Ventilation slots (protected)
        for(x = [-200:50:200]) {
            translate([x, chassis_width/2 - 10, chassis_height/2])
            rotate([45, 0, 0])
            cube([30, 20, 5], center=true);
            
            translate([x, -(chassis_width/2 - 10), chassis_height/2])
            rotate([-45, 0, 0])
            cube([30, 20, 5], center=true);
        }
    }
    
    // Internal component mounts
    translate([100, 0, wall])
    battery_compartment();
    
    translate([-100, 0, wall])
    electronics_bay();
}

// =============================================
// TANK TRACK ASSEMBLY
// =============================================
module track_assembly() {
    // Track frame
    color([0.2, 0.2, 0.2])
    difference() {
        union() {
            // Main track body
            hull() {
                // Front wheel
                translate([chassis_length/2 - 80, 0, 0])
                cylinder(h=track_width, r=60, center=true);
                
                // Rear wheel
                translate([-(chassis_length/2 - 80), 0, 0])
                cylinder(h=track_width, r=60, center=true);
                
                // Top section
                translate([0, 0, 40])
                cube([chassis_length - 200, 80, track_width], center=true);
                
                // Bottom section
                translate([0, 0, -40])
                cube([chassis_length - 160, 100, track_width], center=true);
            }
        }
        
        // Hollow center for wheels
        hull() {
            translate([chassis_length/2 - 80, 0, 0])
            cylinder(h=track_width - 20, r=50, center=true);
            
            translate([-(chassis_length/2 - 80), 0, 0])
            cylinder(h=track_width - 20, r=50, center=true);
            
            cube([chassis_length - 200, 60, track_width - 20], center=true);
        }
    }
    
    // Drive wheels
    for(x = [chassis_length/2 - 80, -(chassis_length/2 - 80)]) {
        translate([x, 0, 0])
        drive_wheel();
    }
    
    // Support wheels
    for(x = [-200:100:200]) {
        translate([x, 0, -40])
        support_wheel();
    }
    
    // Track treads (visual representation)
    track_treads();
}

module drive_wheel() {
    color([0.5, 0.5, 0.5])
    difference() {
        cylinder(h=track_width - 25, r=45, center=true);
        
        // Teeth for track grip
        for(a = [0:20:340]) {
            rotate([0, 0, a])
            translate([45, 0, 0])
            cube([10, 8, track_width - 20], center=true);
        }
        
        // Motor shaft hole
        cylinder(h=track_width, r=15, center=true);
    }
}

module support_wheel() {
    color([0.4, 0.4, 0.4])
    cylinder(h=track_width/2, r=25, center=true);
}

module track_treads() {
    color([0.1, 0.1, 0.1])
    for(i = [0:40]) {
        angle = i * 18;
        translate([
            cos(angle) * (chassis_length/2 - 100),
            0,
            sin(angle) * 60 - 30
        ])
        track_segment();
    }
}

module track_segment() {
    difference() {
        cube([40, track_width, 15], center=true);
        
        // Tread pattern
        for(y = [-track_width/2:20:track_width/2]) {
            translate([0, y, 7])
            rotate([0, 45, 0])
            cube([8, 15, 8], center=true);
        }
    }
}

// =============================================
// SENSOR TURRET (360° ROTATING)
// =============================================
module sensor_turret() {
    // Turret base (rotates)
    color([0.3, 0.3, 0.4])
    cylinder(h=30, r=80);
    
    // Turret housing
    difference() {
        union() {
            // Main turret body
            translate([0, 0, 30])
            hull() {
                cylinder(h=80, r1=80, r2=60);
                
                // Camera extension
                translate([60, 0, 40])
                sphere(r=30);
            }
            
            // Armor shield
            translate([0, 0, 30])
            for(a = [0:45:315]) {
                rotate([0, 0, a])
                translate([70, 0, 20])
                armor_plate();
            }
        }
        
        // Camera windows
        // Thermal camera
        translate([70, 0, 70])
        rotate([0, 90, 0])
        cylinder(h=40, r=20);
        
        // Night vision camera
        translate([70, 0, 40])
        rotate([0, 90, 0])
        cylinder(h=40, r=15);
        
        // 360° camera slots
        for(a = [45:90:315]) {
            rotate([0, 0, a])
            translate([60, 0, 50])
            rotate([0, 90, 0])
            cylinder(h=30, r=10);
        }
    }
    
    // Sensor equipment (visible)
    translate([70, 0, 70])
    thermal_camera();
    
    translate([70, 0, 40])
    night_vision_camera();
    
    // Spotlight/IR illuminator
    translate([50, 0, 90])
    rotate([0, 45, 0])
    spotlight();
    
    // Communication antenna
    translate([0, 0, 110])
    antenna_array();
}

module thermal_camera() {
    color([0.2, 0.2, 0.2])
    rotate([0, 90, 0])
    cylinder(h=30, r=18);
    
    color([0.8, 0.1, 0.1])
    translate([25, 0, 0])
    rotate([0, 90, 0])
    cylinder(h=5, r=15);
}

module night_vision_camera() {
    color([0.2, 0.2, 0.2])
    rotate([0, 90, 0])
    cylinder(h=25, r=12);
    
    color([0.1, 0.1, 0.1])
    translate([20, 0, 0])
    rotate([0, 90, 0])
    cylinder(h=5, r=10);
}

module spotlight() {
    color([0.9, 0.9, 0.9])
    difference() {
        cylinder(h=40, r1=15, r2=30);
        translate([0, 0, 5])
        cylinder(h=36, r1=12, r2=27);
    }
    
    // LED array
    color([1, 1, 0.8])
    translate([0, 0, 35])
    cylinder(h=2, r=25);
}

// =============================================
// ARMOR & PROTECTION
// =============================================
module armor_corner() {
    difference() {
        sphere(r=40);
        sphere(r=37);
        translate([0, 0, -40])
        cube([80, 80, 80], center=true);
    }
}

module armor_plate() {
    rotate([0, armor_angle, 0])
    difference() {
        cube([5, 40, 60], center=true);
        
        // Weight reduction
        for(z = [-20:20:20]) {
            translate([0, 0, z])
            rotate([0, 90, 0])
            cylinder(h=6, r=5, center=true);
        }
    }
}

module front_armor_plate() {
    color([0.3, 0.3, 0.3])
    difference() {
        rotate([armor_angle, 0, 0])
        cube([150, 5, 150], center=true);
        
        // Sensor windows
        translate([0, -10, 20])
        rotate([90, 0, 0])
        cylinder(h=20, r=15);
        
        // Ventilation
        for(x = [-50:25:50]) {
            translate([x, 0, -30])
            cube([15, 10, 40], center=true);
        }
    }
    
    // "Intimidation" features
    for(x = [-40, 40]) {
        translate([x, 5, 0])
        spike();
    }
}

module spike() {
    color([0.5, 0.5, 0.5])
    cylinder(h=30, r1=8, r2=1);
}

// =============================================
// EQUIPMENT & POWER
// =============================================
module equipment_bay() {
    difference() {
        cube([100, 200, 100], center=true);
        translate([0, 0, 5])
        cube([95, 195, 95], center=true);
        
        // Access door
        translate([-50, 0, 0])
        cube([10, 180, 80], center=true);
    }
    
    // Equipment racks
    for(z = [-30:30:30]) {
        translate([0, 0, z])
        equipment_rack();
    }
}

module battery_compartment() {
    // Dual battery system for hot-swap
    for(y = [-50, 50]) {
        translate([0, y, 20])
        battery_pack();
    }
    
    // Charging contacts
    translate([0, 0, 0])
    charging_system();
}

module battery_pack() {
    color([0.2, 0.2, 0.8])
    cube([150, 80, 60], center=true);
    
    // Handle
    translate([0, 0, 30])
    color([1, 1, 0])
    difference() {
        cube([80, 20, 10], center=true);
        cube([60, 10, 12], center=true);
    }
}

module electronics_bay() {
    // Main computer mount
    translate([0, 0, 40])
    color([0, 0.5, 0])
    cube([100, 80, 10], center=true);
    
    // Motor controllers
    for(y = [-60, 60]) {
        translate([0, y, 20])
        color([0.8, 0, 0])
        cube([60, 40, 5], center=true);
    }
    
    // Communication equipment
    translate([0, 0, 60])
    color([0.2, 0.2, 0.2])
    cube([80, 60, 20], center=true);
}

module antenna_array() {
    // 4G/5G antenna
    color([0.3, 0.3, 0.3])
    cylinder(h=60, r=3);
    
    // WiFi antennas
    for(a = [0, 120, 240]) {
        rotate([0, 0, a])
        translate([15, 0, 0])
        cylinder(h=40, r=2);
    }
    
    // GPS antenna
    translate([0, 0, 50])
    color([0.4, 0.4, 0.4])
    cylinder(h=10, r=15);
}

module side_armor_panels() {
    for(y = [1, -1]) {
        translate([0, y * (chassis_width/2 - 5), chassis_height/2])
        side_panel();
    }
}

module side_panel() {
    color([0.3, 0.3, 0.3])
    difference() {
        rotate([0, 0, 90])
        rotate([90, 0, 0])
        linear_extrude(height=5)
        polygon(points=[
            [-chassis_width/2 + 50, 0],
            [chassis_width/2 - 50, 0],
            [chassis_width/2 - 100, chassis_height],
            [-chassis_width/2 + 100, chassis_height]
        ]);
        
        // Camera ports
        for(x = [-200, 0, 200]) {
            translate([x, 0, 0])
            rotate([90, 0, 0])
            cylinder(h=10, r=8, center=true);
        }
    }
}

module armored_solar_panel() {
    color([0.1, 0.1, 0.3, 0.8])
    difference() {
        cube([chassis_length - 100, chassis_width - 150, 5], center=true);
        
        // Solar cell pattern
        for(x = [-300:60:300]) {
            for(y = [-150:60:150]) {
                translate([x, y, 0])
                cube([55, 55, 6], center=true);
            }
        }
    }
    
    // Protective frame
    color([0.5, 0.5, 0.5])
    difference() {
        cube([chassis_length - 90, chassis_width - 140, 10], center=true);
        cube([chassis_length - 110, chassis_width - 160, 11], center=true);
    }
}

module equipment_rack() {
    color([0.6, 0.6, 0.6])
    difference() {
        cube([90, 190, 5], center=true);
        
        // Mounting slots
        for(x = [-30:30:30]) {
            for(y = [-80:40:80]) {
                translate([x, y, 0])
                cube([20, 10, 6], center=true);
            }
        }
    }
}

module charging_system() {
    // Charging dock contacts
    for(x = [-30, 30]) {
        translate([x, 0, -5])
        color([0.8, 0.7, 0])
        cylinder(h=10, r=10);
    }
}

// =============================================
// COMPLETE ASSEMBLY
// =============================================
security_rover_tank();

// =============================================
// INDIVIDUAL PARTS FOR PRINTING
// =============================================

// Uncomment part to export:
// armored_chassis();
// track_assembly();
// sensor_turret();
// front_armor_plate();