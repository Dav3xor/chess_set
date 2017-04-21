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


translate([00,0,0]) {
    // Queen
    difference() {
      union() {
      
          translate([0,0,-3])
            rcylinder(33,33,6,1, $fn=numsteps);
          rotate([0,-90,0]) {
        
            solid_rotated_bezier([[0,31,0],  [10,35,0], 
                                  [15, 19,0], [25,25,0]],
                                 rotational_steps=numsteps, 
                                 bezier_steps=beziersteps);
            translate([25,0,0])
            solid_rotated_bezier([[0,25,0], [2,24,0], 
                                  [10, 13,0], [25,13,0]],
                                 rotational_steps=numsteps, 
                                 bezier_steps=beziersteps);
            translate([50,0,0])
              solid_rotated_bezier([[0,13,0], [14,13,0], 
                                    [24.5,20,0], [25,20,0]],
                                   rotational_steps=numsteps, 
                                   bezier_steps=beziersteps);
            translate([52,0,0])
              rotate([0,90,0])
              rcylinder(14.5,14.5,6,3,$fn=numsteps);
            translate([75,0,0])
              solid_rotated_bezier([[0,20,0], [10,25,0], 
                                    [12.5,14,0], [13,14,0]],
                                   rotational_steps=numsteps, 
                                   bezier_steps=beziersteps);

            translate([89,0,0])
              rotate([0,90,0])
              rcylinder(18,18,6,2,$fn=numsteps);
            
            difference() {
              union() {
                translate([92,0,0])
                  solid_rotated_bezier([[0,15,0], [8,15,0], 
                                        [22,25,0], [23,25,0]],
                                       rotational_steps=numsteps, 
                                       bezier_steps=beziersteps);
                translate([115,0,0])
                  rotate([0,90,0])
                    cylinder(5,25,21,$fn=numsteps);
              }

              translate([165,0,0])
                sphere(50,$fn=numsteps*2);

            }
          translate([115,0,0]) 
            scale([.6,1,1])
              sphere(15, $fn=numsteps);
          translate([126,0,0])
            sphere(6, $fn=numsteps);
          }

      }
      
      translate([0,0,141]) {
        for (i = [0:10]) {
          rotate([130,0,i*(360/10)])
          translate([0,0,10])
          cylinder(50,5,8);
        }
      }
    
      union() {
        translate([0,0,-7]) {
          //cylinder(1,22,22);
          cylinder(10,20,20);
        }
        translate([0,0,2.9])
          cylinder(40,20,0);
      }
    

    }  
    
}