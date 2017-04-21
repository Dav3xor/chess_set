include <revoloids.scad>
include <maths.scad>
include <rcube.scad>

module solid_rotated_bezier(control_points, bezier_steps=50, rotational_steps=20) {
  curve = [ for(step=[0:bezier_steps]) 
    PtOnBez2D(control_points[0],control_points[1],
                control_points[2],control_points[3],
                step/bezier_steps) ];
  curve2 = [ for(step=[0:bezier_steps]) [curve[step][1], curve[step][0] ]];
  curve3 = concat([[0,0]],curve2,[[0,curve[bezier_steps][0]]]);
  rotate([0,90,0])
    rotate_extrude($fn=rotational_steps) 
      polygon(curve3);  
  echo(curve3);
}

beziersteps = 20;
numsteps = 70;
numcrenels = 7;
translate([0,0,0]) {
    // Rook
    difference() {
      union() {
      
          translate([0,0,-2])
            rcylinder(30,30,4,1, $fn=numsteps);
          rotate([0,-90,0]) {
        
            solid_rotated_bezier([[0,28,0],  [10,32,0], 
                                  [15, 16,0], [20,23,0]],
                                 rotational_steps=numsteps, 
                                 bezier_steps=beziersteps);
            translate([20,0,0])
              solid_rotated_bezier([[0,23,0], [1,24,0], 
                                    [15, 14,0], [38,12.5,0]],
                                   rotational_steps=numsteps, 
                                   bezier_steps=beziersteps);
            translate([58,0,0])
              solid_rotated_bezier([[0,15,0], [5,15.5,0], 
                                    [5.5,21,0], [8,17,0]],
                                   rotational_steps=numsteps, 
                                   bezier_steps=beziersteps);
            rotate([0,-90,0]) {
              translate([0,0,-55.5])
                rcylinder(15,15,4,1.5, $fn=numsteps);
              translate([0,0,-75])
                difference() {
                  rcylinder(22,22,18,2, $fn=numsteps);
                  translate([0,0,-6])
                    rcylinder(18,18,20,2, $fn=numsteps);
                  for (i = [0:numcrenels]) {
                    rotate([0,0,i*(360/numcrenels)])
                      translate([-2,0,-10])
                        cube([5.5,25,6]);
                  }
                }
            }
          }

      }
      
      union() {
        translate([0,0,-4.1]) {
          cylinder(10,20,20);
        }
        translate([0,0,5.9])
          cylinder(60,20,0);
      }
  }
}