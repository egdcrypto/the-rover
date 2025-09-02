// Mini Tennis Ball - 1:10 Scale (6.7mm diameter)
// Print in TPU for bounce

$fn = 30;

module mini_tennis_ball() {
    difference() {
        sphere(r=3.35); // 6.7mm diameter
        
        // Tennis ball seam pattern
        for(a = [0, 120, 240]) {
            rotate([0, 0, a])
            rotate([90, 0, 0])
            translate([0, 0, 3.35])
            difference() {
                cylinder(h=0.5, r=4, center=true);
                cylinder(h=0.6, r=3.5, center=true);
            }
        }
    }
}

mini_tennis_ball();