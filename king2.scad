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
    // King
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
            
            translate([92,0,0])
              solid_rotated_bezier([[0,15,0],[20,15,0],
                                    [28,38,0],[29,0,0]],
                                    rotational_steps=numsteps,
                                    bezier_steps=beziersteps);


          }

      }
      

        union() {
          translate([0,0,-6]) {
            //cylinder(1,22,22);
            cylinder(10,20,20);
          }
          translate([0,0,3.99])
            cylinder(40,20,0);
        }
    

      
    }



translate([0,0,130.8])
scale([.7,.7,.7])
  intersection() {
    union() {
      translate([0,0,-1])
      scale([.32,1,1.2])
        sphere(15);
      difference() {
        translate([0,0,-15])
        cylinder(31,15,10);
        rotate_extrude(convexity=10, $fn=numsteps)
          translate([30.8,0,0])
            circle(25); 

      }

      rotate([90,0,0])
        translate([0,2.5,0])
          difference() {
            translate([0,0,-15])

            cylinder(30,10,10);
            rotate_extrude(convexity=10, $fn=numsteps)
              translate([30,0,0])
                circle(24.8); 

          }
    }
    translate([0,0,-5])
    scale([.37,5.35,1.2])
      sphere(20);
  }
}