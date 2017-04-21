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
  
    
ear_remove=[[0,20],[50,50],[50,50],[0,20]];
beziersteps = 20;     // 20
numsteps    = 50;     // 50
numcrenels  = 7;


translate([0,0,0]) {
    // Bishop
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
                                  [3, 13,0], [17,13,0]],
                                 rotational_steps=numsteps, 
                                 bezier_steps=beziersteps);
            translate([35,0,0])
              solid_rotated_bezier([[0,13,0], [7,13,0], 
                                    [10,16.5,0], [12,16.5,0]],
                                   rotational_steps=numsteps, 
                                   bezier_steps=beziersteps);
            translate([47,0,0])
              solid_rotated_bezier([[0,16.5,0], [1.8,16.5,0], 
                                    [2.9,12,0], [3,12,0]],
                                   rotational_steps=numsteps, 
                                   bezier_steps=beziersteps);
            translate([51,0,0])
              rotate([0,90,0])
              rcylinder(14,14,3,1,$fn=numsteps);
            translate([55,0,0])
              rotate([0,90,0])
              rcylinder(12.5,12.5,8,3.5,$fn=numsteps);
          }
          // head/hat
          difference() {
            translate([0,0,75])
              scale([.7,.7,1.0])
                sphere(23, $fn=numsteps);
            translate([5,-20,75])
              rotate([0,-55,0])
                cube([20,40,4]);
          }
          translate([0,0,75])
            scale([.7,.7,1.0])
              sphere(18, $fn=numsteps);
          
          // top knob
          translate([0,0,99])
            scale([1,1,.7])
              sphere(8, $fn=numsteps);
      }
      
      union() {
        translate([0,0,-4.1]) {
          //cylinder(1,22,22);
          cylinder(10,20,20);
        }
        translate([0,0,5.89])
          cylinder(40,20,0);
      }
  }
}