// Complete 1:10 Scale Tennis Court Test Environment
// For plywood base with 3D printed components
// Full singles court: 23.77m x 8.23m → 2.377m x 0.823m at 1:10 scale

// =============================================
// GLOBAL PARAMETERS
// =============================================
$fn = 40;
scale_factor = 0.1; // 1:10 scale

// Full court dimensions in mm (1:10 scale)
court_length = 2377; // 23.77m scaled
court_width = 823;   // 8.23m scaled
service_box_length = 640; // 6.40m scaled
service_box_width = 411;  // 4.11m scaled
doubles_width = 1097; // 10.97m scaled

// Net dimensions (1:10 scale)
net_height_center = 91.4; // 0.914m scaled
net_height_posts = 107;   // 1.07m scaled
net_width = doubles_width;

// Fence dimensions (1:10 scale)
fence_height = 300; // 3m scaled
fence_distance = 100; // 1m from court edge

// Line width
line_width = 5; // 5cm scaled to 5mm

// Ball dimensions (1:10 scale)
ball_diameter = 6.7; // 67mm tennis ball scaled

// =============================================
// MINI TENNIS BALLS (PRINTABLE)
// =============================================
module mini_tennis_ball() {
    difference() {
        // Main ball body
        sphere(r=ball_diameter/2);
        
        // Tennis ball seam pattern
        for(a = [0, 120, 240]) {
            rotate([0, 0, a])
            rotate([90, 0, 0])
            translate([0, 0, ball_diameter/2])
            torus(ball_diameter/2 + 0.5, 0.3);
        }
    }
    
    // Add fuzzy texture representation (for visual only)
    // In reality, print with fuzzy filament or post-process
}

// Helper for tennis ball seam
module torus(R, r) {
    rotate_extrude(angle=360)
    translate([R, 0, 0])
    circle(r=r);
}

// Multiple balls for printing
module tennis_ball_set(count=20) {
    for(i = [0:count-1]) {
        x = (i % 5) * 15;
        y = floor(i / 5) * 15;
        translate([x, y, ball_diameter/2])
        mini_tennis_ball();
    }
}

// =============================================
// COURT LINE MARKERS
// =============================================
module court_lines() {
    // Baseline
    translate([0, -court_width/2, 0])
    cube([court_length, line_width, 2], center=true);
    translate([0, court_width/2, 0])
    cube([court_length, line_width, 2], center=true);
    
    // Sidelines (singles)
    translate([-court_length/2, 0, 0])
    cube([line_width, court_width, 2], center=true);
    translate([court_length/2, 0, 0])
    cube([line_width, court_width, 2], center=true);
    
    // Service lines
    translate([-service_box_length, 0, 0])
    cube([line_width, court_width, 2], center=true);
    translate([service_box_length, 0, 0])
    cube([line_width, court_width, 2], center=true);
    
    // Center service line
    cube([service_box_length * 2, line_width, 2], center=true);
    
    // Center mark
    translate([0, -court_width/2 - 2.5, 0])
    cube([line_width, 10, 2], center=true);
    translate([0, court_width/2 + 2.5, 0])
    cube([line_width, 10, 2], center=true);
    
    // Doubles sidelines
    translate([-court_length/2, -doubles_width/2, 0])
    cube([court_length, line_width, 2], center=true);
    translate([-court_length/2, doubles_width/2, 0])
    cube([court_length, line_width, 2], center=true);
}

// =============================================
// NET ASSEMBLY
// =============================================
module tennis_net() {
    // Net posts
    for(y = [-doubles_width/2, doubles_width/2]) {
        translate([0, y, 0])
        net_post();
    }
    
    // Net mesh (simplified for printing)
    color([1, 1, 1])
    translate([0, 0, net_height_center/2])
    difference() {
        // Main net body
        cube([3, doubles_width, net_height_center], center=true);
        
        // Mesh pattern
        for(x = [-2:10:2]) {
            for(y = [-doubles_width/2:20:doubles_width/2]) {
                for(z = [0:20:net_height_center]) {
                    translate([x, y, z - net_height_center/2])
                    cube([8, 15, 15], center=true);
                }
            }
        }
    }
    
    // Center strap
    translate([0, 0, net_height_center])
    cube([5, 20, 3], center=true);
}

module net_post() {
    difference() {
        union() {
            // Post
            cylinder(h=net_height_posts, r=5);
            
            // Base
            translate([0, 0, -2])
            cylinder(h=3, r=15);
            
            // Net attachment points
            for(z = [20, 50, 80, net_height_posts - 5]) {
                translate([0, 0, z])
                rotate([90, 0, 0])
                cylinder(h=10, r=2, center=true);
            }
        }
        
        // Screw holes for base
        for(a = [0, 90, 180, 270]) {
            rotate([0, 0, a])
            translate([10, 0, -3])
            cylinder(h=5, r=1.5);
        }
    }
}

// =============================================
// FENCE SECTIONS (MODULAR)
// =============================================
module fence_section(length=200) {
    difference() {
        union() {
            // Frame
            // Vertical posts
            for(x = [0, length]) {
                translate([x, 0, 0])
                cube([5, 5, fence_height], center=true);
            }
            
            // Horizontal rails
            for(z = [0, fence_height/3, 2*fence_height/3, fence_height]) {
                translate([length/2, 0, z - fence_height/2])
                cube([length, 3, 3], center=true);
            }
            
            // Mesh representation
            for(x = [10:20:length-10]) {
                translate([x, 0, 0])
                cube([1, 2, fence_height], center=true);
            }
            
            for(z = [10:20:fence_height-10]) {
                translate([length/2, 0, z - fence_height/2])
                cube([length, 1, 1], center=true);
            }
        }
        
        // Base mounting holes
        for(x = [10, length-10]) {
            translate([x, 0, -fence_height/2 - 1])
            cylinder(h=10, r=1.5);
        }
    }
    
    // Connector tabs
    translate([0, 0, -fence_height/2])
    fence_connector();
    translate([length, 0, -fence_height/2])
    fence_connector();
}

module fence_connector() {
    difference() {
        cylinder(h=10, r=8);
        translate([0, 0, -1])
        cylinder(h=12, r=2);
    }
}

// Corner fence section
module fence_corner() {
    rotate([0, 0, 90])
    fence_section(150);
    fence_section(150);
    
    // Corner post
    translate([0, 0, 0])
    cube([8, 8, fence_height], center=true);
}

// Gate section for access
module fence_gate() {
    // Gate frame
    difference() {
        union() {
            // Side posts
            for(x = [0, 100]) {
                translate([x, 0, 0])
                cube([5, 5, fence_height], center=true);
            }
            
            // Top rail
            translate([50, 0, fence_height/2 - 5])
            cube([100, 3, 5], center=true);
            
            // Gate door (hinged)
            translate([50, 2, 0])
            gate_door();
        }
    }
}

module gate_door() {
    color([0.8, 0.8, 0.8])
    difference() {
        cube([90, 2, fence_height - 20], center=true);
        
        // Handle hole
        translate([35, 0, 0])
        rotate([90, 0, 0])
        cylinder(h=5, r=3, center=true);
    }
    
    // Hinges
    for(z = [-fence_height/3, fence_height/3]) {
        translate([-45, 0, z])
        hinge();
    }
}

module hinge() {
    cylinder(h=10, r=2);
    translate([0, -3, 5])
    rotate([0, 90, 0])
    cylinder(h=5, r=1, center=true);
}

// =============================================
// COURT ACCESSORIES
// =============================================

// Ball hopper for testing
module ball_hopper() {
    difference() {
        union() {
            // Legs
            for(x = [-30, 30]) {
                for(y = [-20, 20]) {
                    translate([x, y, -40])
                    cylinder(h=40, r=2);
                }
            }
            
            // Basket
            difference() {
                cube([65, 45, 50], center=true);
                translate([0, 0, 3])
                cube([60, 40, 50], center=true);
            }
            
            // Handle
            translate([0, 0, 25])
            difference() {
                rounded_cube([40, 15, 10], 3);
                translate([0, 0, -2])
                rounded_cube([30, 8, 10], 2);
            }
        }
        
        // Mesh pattern
        for(x = [-25:10:25]) {
            for(z = [-20:10:20]) {
                translate([x, -25, z])
                rotate([90, 0, 0])
                cylinder(h=50, r=3);
            }
        }
    }
}

// Boundary markers (cones)
module boundary_cone() {
    color([1, 0.5, 0])
    difference() {
        cylinder(h=50, r1=15, r2=5);
        translate([0, 0, 5])
        cylinder(h=46, r1=13, r2=3);
    }
}

// Court sweeper lines (for ball detection training)
module court_zones() {
    for(x = [-court_length/2:200:court_length/2]) {
        for(y = [-court_width/2:200:court_width/2]) {
            translate([x, y, 0.5])
            color([0, 0, 1, 0.3])
            cube([190, 190, 0.1], center=true);
        }
    }
}

// =============================================
// PLYWOOD BASE TEMPLATE
// =============================================
module plywood_template() {
    // This shows the cutting template for plywood base
    color([0.8, 0.6, 0.3, 0.3])
    cube([3000, 1500, 18], center=true); // 3m x 1.5m plywood
    
    // Court area marking
    color([0, 0.5, 0])
    translate([0, 0, 9])
    cube([court_length, doubles_width, 0.1], center=true);
    
    // Fence line marking
    color([0.5, 0.5, 0.5, 0.5])
    translate([0, 0, 9.1])
    difference() {
        cube([court_length + 200, doubles_width + 200, 0.1], center=true);
        cube([court_length + 180, doubles_width + 180, 0.2], center=true);
    }
}

// =============================================
// ASSEMBLY HELPERS
// =============================================

module rounded_cube(size, radius) {
    hull() {
        for(x = [-1, 1]) {
            for(y = [-1, 1]) {
                for(z = [-1, 1]) {
                    translate([
                        x * (size[0]/2 - radius),
                        y * (size[1]/2 - radius),
                        z * (size[2]/2 - radius)
                    ])
                    sphere(r=radius);
                }
            }
        }
    }
}

// =============================================
// COMPLETE COURT ASSEMBLY
// =============================================
module complete_mini_court() {
    // Plywood base
    plywood_template();
    
    // Court lines
    translate([0, 0, 10])
    color([1, 1, 1])
    court_lines();
    
    // Net
    translate([0, 0, 10])
    tennis_net();
    
    // Fence sections
    // Back fence
    for(x = [-court_length/2 - 100:200:court_length/2 + 100]) {
        translate([x - 100, -doubles_width/2 - 100, 10])
        rotate([0, 0, 0])
        fence_section();
    }
    
    // Front fence
    for(x = [-court_length/2 - 100:200:court_length/2 + 100]) {
        translate([x - 100, doubles_width/2 + 100, 10])
        rotate([0, 0, 180])
        fence_section();
    }
    
    // Side fences
    for(y = [-doubles_width/2 - 100:200:doubles_width/2 + 100]) {
        translate([-court_length/2 - 100, y - 100, 10])
        rotate([0, 0, 90])
        fence_section();
        
        translate([court_length/2 + 100, y - 100, 10])
        rotate([0, 0, 90])
        fence_section();
    }
    
    // Corner sections
    translate([-court_length/2 - 100, -doubles_width/2 - 100, 10])
    fence_corner();
    translate([court_length/2 + 100, -doubles_width/2 - 100, 10])
    rotate([0, 0, 90])
    fence_corner();
    translate([-court_length/2 - 100, doubles_width/2 + 100, 10])
    rotate([0, 0, -90])
    fence_corner();
    translate([court_length/2 + 100, doubles_width/2 + 100, 10])
    rotate([0, 0, 180])
    fence_corner();
    
    // Gate
    translate([0, doubles_width/2 + 100, 10])
    fence_gate();
    
    // Ball hoppers
    translate([-court_length/2 - 50, 0, 35])
    ball_hopper();
    translate([court_length/2 + 50, 0, 35])
    ball_hopper();
    
    // Scatter some balls for testing
    for(i = [0:10]) {
        translate([
            -court_length/4 + (i % 3) * 100 + rands(-50, 50, 1)[0],
            -court_width/4 + floor(i / 3) * 100 + rands(-50, 50, 1)[0],
            10 + ball_diameter/2
        ])
        color([0.8, 0.8, 0])
        mini_tennis_ball();
    }
    
    // Boundary cones
    for(corner = [
        [-court_length/2, -court_width/2],
        [court_length/2, -court_width/2],
        [-court_length/2, court_width/2],
        [court_length/2, court_width/2]
    ]) {
        translate([corner[0], corner[1], 10])
        boundary_cone();
    }
}

// =============================================
// INDIVIDUAL PARTS FOR PRINTING
// =============================================

// Uncomment the part you want to export:

// mini_tennis_ball();
// tennis_ball_set(20); // Print 20 balls at once
// net_post();
// fence_section();
// fence_corner();
// fence_gate();
// ball_hopper();
// boundary_cone();
// court_lines(); // Print as stencil

// =============================================
// FULL ASSEMBLY VIEW
// =============================================

// complete_mini_court();

// =============================================
// TESTING BALL PATTERNS
// =============================================

module test_pattern_scattered() {
    // Random ball placement for collection testing
    for(i = [0:30]) {
        translate([
            rands(-court_length/2 + 50, court_length/2 - 50, 1)[0],
            rands(-court_width/2 + 50, court_width/2 - 50, 1)[0],
            10 + ball_diameter/2
        ])
        mini_tennis_ball();
    }
}

module test_pattern_lines() {
    // Balls along lines for path following
    for(x = [-court_length/2:100:court_length/2]) {
        translate([x, 0, 10 + ball_diameter/2])
        mini_tennis_ball();
    }
}

module test_pattern_service_box() {
    // Balls in service box for zone testing
    for(x = [-service_box_length:50:service_box_length]) {
        for(y = [-service_box_width/2:50:service_box_width/2]) {
            translate([x, y, 10 + ball_diameter/2])
            mini_tennis_ball();
        }
    }
}

// =============================================
// PRINT SETTINGS SUMMARY
// =============================================

/*
MINI TENNIS BALLS:
- Material: TPU 95A (flexible, bouncy)
- Infill: 10% (light weight)
- Layer: 0.15mm
- Print 20-50 for testing
- Color: Yellow/Green

NET POSTS:
- Material: PETG
- Infill: 30%
- Support: No
- Print: 2 posts

NET MESH:
- Material: White PLA
- Infill: 10%
- Support: Yes
- Very light for realism

FENCE SECTIONS:
- Material: PETG
- Infill: 20%
- Print: 15-20 sections
- Modular assembly

COURT LINES:
- Material: White PLA
- Height: 2mm
- Can be painted on plywood instead

BALL HOPPER:
- Material: PETG
- Infill: 15%
- Print: 2 units

PLYWOOD BASE:
- Size: 3m x 1.5m x 18mm
- Paint: Green court, white lines
- Seal: Polyurethane for durability
*/