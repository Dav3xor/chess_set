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

translate([0,0,0]) {
    // Pawn
    difference() {
      union() {
      
          translate([0,0,-2])
            rcylinder(26,26,4,1, $fn=numsteps);
          rotate([0,-90,0]) {
        
            solid_rotated_bezier([[0,24,0],[10,30,0], 
                                  [15, 10,0], [20,15,0]],
                                 rotational_steps=numsteps, 
                                 bezier_steps=beziersteps);
            translate([20,0,0])
              solid_rotated_bezier([[0,15,0],[2,16,0], 
                                    [5, 8,0], [15,8,0]],
                                   rotational_steps=numsteps, 
                                   bezier_steps=beziersteps);
            translate([35,0,0])
              solid_rotated_bezier([[0,8,0],[7,8,0], 
                                    [10, 18,0], [10,0,0]],
                                   rotational_steps=numsteps, 
                                   bezier_steps=beziersteps);
          }
        translate([0,0,56])
          sphere(15, $fn=numsteps);
      }
      
      union() {
        translate([0,0,-4.1]) {
          //cylinder(1,22,22);
          cylinder(10,20,20);
        }
        translate([0,0,5.89])
          cylinder(25,20,0);
      }
  }
}