// The Tennis Rover - 3D Printable Parts
// Each part is designed to fit on a standard 220x220mm print bed
// Export each module separately as STL for printing

// Print settings recommendations:
// - Layer height: 0.2mm
// - Infill: 20% honeycomb/gyroid for chassis, 15% for non-structural
// - Support: Only where noted
// - Material: PETG for outdoor durability

// Global parameters
$fn = 50;
wall_thickness = 3;
tolerance = 0.2; // Clearance for moving parts

// ============================================
// PART 1: FRONT CHASSIS SECTION
// Print time: ~8 hours
// Material: PETG, 20% infill
// ============================================
module part_front_chassis() {
    difference() {
        // Main body
        cube([200, 200, 100], center=true);
        
        // Hollow interior
        translate([0, 0, wall_thickness])
        cube([194, 194, 100], center=true);
        
        // Motor mount holes
        for(x = [-60, 60]) {
            for(y = [-60, 60]) {
                translate([x, y, -50])
                cylinder(h=20, r=3);
            }
        }
        
        // Scoop attachment points
        translate([100, 0, 0])
        for(y = [-80, 0, 80]) {
            translate([0, y, 0])
            rotate([0, 90, 0])
            cylinder(h=20, r=2);
        }
        
        // Cable management channels
        for(y = [-50, 50]) {
            translate([0, y, -45])
            cube([150, 10, 10], center=true);
        }
        
        // Honeycomb weight reduction
        honeycomb_cutout(150, 150, wall_thickness);
    }
    
    // Snap-fit connectors for rear section
    for(y = [-80, 80]) {
        translate([-100, y, 0])
        snap_connector_male();
    }
}

// ============================================
// PART 2: REAR CHASSIS SECTION
// Print time: ~8 hours
// Material: PETG, 20% infill
// ============================================
module part_rear_chassis() {
    difference() {
        // Main body
        cube([200, 200, 100], center=true);
        
        // Hollow interior for hopper
        translate([0, 0, wall_thickness])
        cube([194, 194, 100], center=true);
        
        // Ball entry port
        translate([100, 0, 30])
        rotate([0, 90, 0])
        cylinder(h=20, r=25);
        
        // Basket mounting rails
        for(y = [-60, 60]) {
            translate([-50, y, 40])
            cube([100, 5, 5], center=true);
        }
        
        // Battery slot 1
        translate([0, -60, 0])
        battery_slot();
        
        // Battery slot 2
        translate([0, 60, 0])
        battery_slot();
    }
    
    // Snap-fit connectors for front section
    for(y = [-80, 80]) {
        translate([100, y, 0])
        snap_connector_female();
    }
}

// ============================================
// PART 3: BALL SCOOP
// Print time: ~3 hours
// Material: TPU 95A, 15% infill
// Support: Yes
// ============================================
module part_ball_scoop() {
    difference() {
        union() {
            // Funnel body
            hull() {
                // Wide opening
                translate([0, 0, 0])
                rounded_box(20, 200, 80, 5);
                
                // Narrow exit
                translate([-80, 0, 0])
                rounded_box(20, 60, 60, 5);
            }
            
            // Mounting tabs
            for(y = [-80, 0, 80]) {
                translate([0, y, 0])
                mounting_tab();
            }
        }
        
        // Hollow interior
        hull() {
            translate([0, 0, 0])
            rounded_box(17, 194, 74, 5);
            
            translate([-80, 0, 0])
            rounded_box(17, 54, 54, 5);
        }
        
        // Flex slots for TPU
        for(i = [0:5]) {
            translate([-70 + i*12, 0, 0])
            cube([2, 210, 85], center=true);
        }
    }
    
    // Roller holder
    translate([10, 0, -30])
    roller_mount();
}

// ============================================
// PART 4: WHEELS (PRINT 4)
// Print time: ~3 hours each
// Material: PETG hub + TPU tire
// ============================================
module part_wheel_hub() {
    difference() {
        union() {
            // Hub center
            cylinder(h=30, r=25);
            
            // Spokes
            for(a = [0:60:300]) {
                rotate([0, 0, a])
                translate([0, 0, 15])
                cube([50, 8, 25], center=true);
            }
            
            // Outer rim
            difference() {
                cylinder(h=30, r=45);
                translate([0, 0, -1])
                cylinder(h=32, r=40);
            }
        }
        
        // Motor shaft hole (D-shaped)
        difference() {
            cylinder(h=31, r=6);
            translate([5, -10, -1])
            cube([10, 20, 33]);
        }
        
        // Set screw hole
        translate([10, 0, 15])
        rotate([0, 90, 0])
        cylinder(h=20, r=1.5);
    }
}

module part_wheel_tire() {
    // Separate TPU tire for better grip
    difference() {
        cylinder(h=35, r=52);
        translate([0, 0, -1])
        cylinder(h=37, r=45);
        
        // Tread pattern
        for(a = [0:15:345]) {
            rotate([0, 0, a])
            translate([50, 0, 17.5])
            rotate([0, 0, 45])
            cube([8, 8, 35], center=true);
        }
    }
}

// ============================================
// PART 5: BASKET (MODULAR SIZES)
// Print time: ~12 hours
// Material: PETG, 15% infill
// ============================================
module part_basket_small() {
    basket_base(150, 150, 120);
}

module part_basket_medium() {
    basket_base(200, 180, 150);
}

module part_basket_large() {
    basket_base(250, 200, 180);
}

module basket_base(length, width, height) {
    // Bottom
    difference() {
        cube([length, width, 3], center=true);
        
        // Drainage holes
        for(x = [-3:3]) {
            for(y = [-3:3]) {
                translate([x*20, y*20, 0])
                cylinder(h=4, r=3, center=true);
            }
        }
    }
    
    // Walls (mesh pattern)
    for(i = [0:3]) {
        rotate([0, 0, i*90])
        translate([length/2 - 2, 0, height/2])
        mesh_wall(i < 2 ? width : length, height);
    }
    
    // Handle
    translate([0, 0, height])
    basket_handle();
    
    // Mounting rails
    for(y = [-width/3, width/3]) {
        translate([0, y, 3])
        cube([length, 5, 5], center=true);
    }
}

// ============================================
// PART 6: SOLAR PANEL MOUNT
// Print time: ~4 hours
// Material: ASA, 25% infill (UV resistant)
// ============================================
module part_solar_mount() {
    difference() {
        // Frame
        rounded_box(220, 200, 15, 5);
        
        // Solar panel recess
        translate([0, 0, 5])
        rounded_box(200, 180, 15, 3);
        
        // Plexiglass grooves
        translate([0, 0, 10])
        difference() {
            rounded_box(210, 190, 3, 3);
            rounded_box(190, 170, 5, 3);
        }
        
        // Mounting holes
        for(x = [-90, 90]) {
            for(y = [-80, 80]) {
                translate([x, y, -1])
                cylinder(h=17, r=2);
            }
        }
        
        // Cable pass-through
        translate([0, -95, 0])
        cylinder(h=16, r=10);
    }
    
    // Mounting posts
    for(x = [-90, 90]) {
        for(y = [-80, 80]) {
            translate([x, y, -7])
            mounting_post();
        }
    }
}

// ============================================
// PART 7: BATTERY PACK HOUSING
// Print time: ~5 hours
// Material: PETG, 20% infill
// ============================================
module part_battery_housing() {
    difference() {
        rounded_box(160, 90, 45, 5);
        
        // Battery compartment
        translate([0, 0, 2])
        rounded_box(154, 84, 45, 3);
        
        // Cell holders (8x 18650)
        for(x = [-52.5, -17.5, 17.5, 52.5]) {
            for(y = [-20, 20]) {
                translate([x, y, -1])
                cylinder(h=47, r=9.3);
            }
        }
        
        // BMS compartment
        translate([0, 0, 35])
        cube([140, 30, 10], center=true);
        
        // Ventilation slots
        for(x = [-60, -40, -20, 0, 20, 40, 60]) {
            translate([x, 42, 20])
            cube([5, 10, 30], center=true);
        }
        
        // Contact terminals
        for(x = [-30, 30]) {
            translate([x, -42, 20])
            cube([10, 10, 10], center=true);
        }
    }
    
    // Handle
    translate([0, 0, 40])
    battery_handle();
    
    // Spring contacts mounting
    for(x = [-30, 30]) {
        translate([x, -38, 20])
        contact_mount();
    }
}

// ============================================
// PART 8: ELECTRONICS MOUNTING PLATE
// Print time: ~2 hours
// Material: PLA+, 30% infill
// ============================================
module part_electronics_mount() {
    difference() {
        // Base plate
        rounded_box(180, 150, 5, 5);
        
        // Raspberry Pi mounting holes
        translate([-30, 20, 0])
        rpi_mount_holes();
        
        // Motor driver mounting
        translate([40, 20, 0])
        driver_mount_holes();
        
        // Arduino mounting
        translate([-30, -40, 0])
        arduino_mount_holes();
        
        // Cable management slots
        for(y = [-50, 0, 50]) {
            translate([0, y, 0])
            cube([150, 5, 6], center=true);
        }
    }
    
    // Standoffs
    translate([-30, 20, -5])
    rpi_standoffs();
    
    translate([40, 20, -5])
    driver_standoffs();
    
    translate([-30, -40, -5])
    arduino_standoffs();
}

// ============================================
// PART 9: CAMERA/SENSOR MOUNT
// Print time: ~1 hour
// Material: PETG, 20% infill
// ============================================
module part_camera_mount() {
    difference() {
        union() {
            // Main housing
            rounded_box(50, 40, 30, 3);
            
            // Mounting bracket
            translate([0, -20, -10])
            cube([50, 5, 20], center=true);
        }
        
        // Camera cavity
        translate([0, 0, 5])
        cube([35, 30, 25], center=true);
        
        // Lens opening
        translate([0, 20, 5])
        rotate([90, 0, 0])
        cylinder(h=15, r=10);
        
        // Cable slot
        translate([0, -15, 5])
        cube([20, 10, 20], center=true);
        
        // Mounting holes
        for(x = [-20, 20]) {
            translate([x, -20, -10])
            rotate([90, 0, 0])
            cylinder(h=10, r=1.5, center=true);
        }
    }
    
    // Tilt adjustment
    translate([0, 15, -10])
    pivot_joint();
}

// ============================================
// PART 10: PROTECTIVE BUMPERS (PRINT 4)
// Print time: ~1 hour each
// Material: TPU 95A, 20% infill
// ============================================
module part_bumper_corner() {
    difference() {
        union() {
            // Main bumper body
            sphere(r=25);
            
            // Mounting plate
            translate([0, 0, -20])
            cylinder(h=5, r=30);
        }
        
        // Cut bottom half
        translate([0, 0, -50])
        cube([100, 100, 50], center=true);
        
        // Mounting holes
        for(a = [0, 90, 180, 270]) {
            rotate([0, 0, a])
            translate([20, 0, -20])
            cylinder(h=10, r=2, center=true);
        }
        
        // Flex grooves for impact absorption
        for(a = [0:45:315]) {
            rotate([0, 0, a])
            translate([0, 0, 10])
            cube([50, 2, 20], center=true);
        }
    }
}

// ============================================
// HELPER MODULES
// ============================================

module honeycomb_cutout(length, width, thickness) {
    cell_size = 12;
    
    for(x = [-10:10]) {
        for(y = [-10:10]) {
            translate([
                x * cell_size * 1.5,
                y * cell_size * 0.866 + (x % 2) * cell_size * 0.433,
                0
            ])
            rotate([0, 0, 30])
            cylinder(h=thickness + 2, r=cell_size/2 - 1, $fn=6, center=true);
        }
    }
}

module snap_connector_male() {
    cylinder(h=10, r=4);
    translate([0, 0, 10])
    cylinder(h=2, r1=5, r2=3);
}

module snap_connector_female() {
    difference() {
        cylinder(h=12, r=8);
        translate([0, 0, -1])
        cylinder(h=11, r=4.2);
        translate([0, 0, 10])
        cylinder(h=3, r1=5.2, r2=3.2);
    }
}

module battery_slot() {
    cube([155, 85, 42], center=true);
    
    // Guide rails
    for(x = [-75, 75]) {
        translate([x, 0, 21])
        rotate([90, 0, 0])
        cylinder(h=85, r=2, center=true);
    }
}

module mounting_tab() {
    difference() {
        cube([10, 20, 15], center=true);
        rotate([0, 90, 0])
        cylinder(h=11, r=2, center=true);
    }
}

module roller_mount() {
    difference() {
        cube([20, 80, 20], center=true);
        rotate([90, 0, 0])
        cylinder(h=81, r=8, center=true);
        
        // Bearing seats
        for(y = [-35, 35]) {
            translate([0, y, 0])
            rotate([90, 0, 0])
            cylinder(h=10, r=11, center=true);
        }
    }
}

module mesh_wall(width, height) {
    // Vertical bars
    for(x = [-width/2:20:width/2]) {
        translate([0, x, 0])
        cube([3, 3, height], center=true);
    }
    
    // Horizontal bars
    for(z = [-height/2:30:height/2]) {
        translate([0, 0, z])
        cube([3, width, 3], center=true);
    }
}

module basket_handle() {
    difference() {
        rounded_box(100, 30, 25, 10);
        translate([0, 0, -5])
        rounded_box(80, 20, 25, 8);
    }
}

module mounting_post() {
    difference() {
        cylinder(h=15, r=5);
        translate([0, 0, 5])
        cylinder(h=11, r=1.8);
    }
}

module battery_handle() {
    difference() {
        rounded_box(70, 25, 12, 5);
        translate([0, 0, -2])
        rounded_box(55, 15, 12, 3);
    }
}

module contact_mount() {
    difference() {
        cube([12, 8, 5], center=true);
        cylinder(h=6, r=2, center=true);
    }
}

module rpi_mount_holes() {
    for(x = [0, 58]) {
        for(y = [0, 49]) {
            translate([x, y, 0])
            cylinder(h=6, r=1.5, center=true);
        }
    }
}

module driver_mount_holes() {
    for(x = [0, 43]) {
        for(y = [0, 43]) {
            translate([x, y, 0])
            cylinder(h=6, r=1.5, center=true);
        }
    }
}

module arduino_mount_holes() {
    hole_positions = [[0, 0], [50.8, 0], [50.8, 27.94], [0, 27.94]];
    for(pos = hole_positions) {
        translate([pos[0], pos[1], 0])
        cylinder(h=6, r=1.5, center=true);
    }
}

module rpi_standoffs() {
    for(x = [0, 58]) {
        for(y = [0, 49]) {
            translate([x, y, 0])
            standoff();
        }
    }
}

module driver_standoffs() {
    for(x = [0, 43]) {
        for(y = [0, 43]) {
            translate([x, y, 0])
            standoff();
        }
    }
}

module arduino_standoffs() {
    hole_positions = [[0, 0], [50.8, 0], [50.8, 27.94], [0, 27.94]];
    for(pos = hole_positions) {
        translate([pos[0], pos[1], 0])
        standoff();
    }
}

module standoff() {
    difference() {
        cylinder(h=8, r=3);
        translate([0, 0, 2])
        cylinder(h=7, r=1.3);
    }
}

module pivot_joint() {
    difference() {
        union() {
            cylinder(h=10, r=8);
            translate([0, 0, 5])
            sphere(r=7);
        }
        cylinder(h=11, r=2.5, center=true);
        
        // Adjustment slots
        for(a = [-30, 0, 30]) {
            rotate([a, 0, 0])
            translate([0, 8, 0])
            cylinder(h=3, r=1.5, center=true);
        }
    }
}

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

// ============================================
// EXPORT INDIVIDUAL PARTS
// Uncomment the part you want to export as STL
// ============================================

// part_front_chassis();
// part_rear_chassis();
// part_ball_scoop();
// part_wheel_hub();
// part_wheel_tire();
// part_basket_small();
// part_basket_medium();
// part_basket_large();
// part_solar_mount();
// part_battery_housing();
// part_electronics_mount();
// part_camera_mount();
// part_bumper_corner();

// ============================================
// ASSEMBLY PREVIEW
// Shows how all parts fit together
// ============================================
module assembly_preview() {
    // Front chassis
    color([0.2, 0.7, 0.3])
    translate([100, 0, 50])
    part_front_chassis();
    
    // Rear chassis
    color([0.2, 0.7, 0.3])
    translate([-100, 0, 50])
    part_rear_chassis();
    
    // Scoop
    color([1, 0.5, 0])
    translate([220, 0, 50])
    part_ball_scoop();
    
    // Wheels
    color([0.3, 0.3, 0.3])
    for(x = [-150, 150]) {
        for(y = [-120, 120]) {
            translate([x, y, 20])
            rotate([90, 0, 0]) {
                part_wheel_hub();
                color([0.1, 0.1, 0.1])
                part_wheel_tire();
            }
        }
    }
    
    // Solar mount
    color([0.1, 0.2, 0.5, 0.9])
    translate([0, 0, 110])
    part_solar_mount();
    
    // Basket
    color([0.8, 0.8, 0.8])
    translate([-200, 0, 80])
    part_basket_medium();
    
    // Bumpers
    color([0.9, 0.1, 0.1])
    for(x = [-180, 180]) {
        for(y = [-110, 110]) {
            translate([x, y, 20])
            part_bumper_corner();
        }
    }
}

// Uncomment to see full assembly
// assembly_preview();