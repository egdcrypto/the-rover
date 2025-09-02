// Simplified Tennis Robot for quick STL generation
$fn = 20; // Lower resolution for faster rendering

// Main body
difference() {
    // Chassis
    cube([200, 150, 80], center=true);
    
    // Hollow interior
    translate([0, 0, 3])
    cube([194, 144, 80], center=true);
}

// Wheels
for(x = [-80, 80]) {
    for(y = [-85, 85]) {
        translate([x, y, 0])
        rotate([90, 0, 0])
        cylinder(h=20, r=30, center=true);
    }
}

// Solar panel on top
translate([0, 0, 43])
color([0.2, 0.2, 0.5])
cube([180, 130, 3], center=true);

// Ball scoop
translate([105, 0, 0])
rotate([0, -20, 0])
cube([20, 100, 40], center=true);

// Basket
translate([-90, 0, 20])
difference() {
    cube([80, 100, 60], center=true);
    translate([0, 0, 3])
    cube([74, 94, 60], center=true);
}