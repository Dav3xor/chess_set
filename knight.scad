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
numsteps = 60;
numcrenels = 7;


translate([0,0,0]) {
      // Knight
    difference() {
      union() {
      
          translate([0,0,-2])
            rcylinder(30,30,4,1, $fn=numsteps);
          rotate([0,-90,0]) {
        
            solid_rotated_bezier([[0,28,0],  [10,32,0], 
                                  [15, 16,0], [20,23,0]],
                                 rotational_steps=numsteps, 
                                 bezier_steps=beziersteps);
            solid_rotated_bezier([[20,23,0], [21,24,0], 
                                  [35, 14,0], [35,0,0]],
                                 rotational_steps=numsteps, 
                                 bezier_steps=beziersteps);
          }
          
          intersection() {
            difference() {
              intersection() {
                // head
                rotate([0,5,0])
                  translate([-3,0,50])
                    scale([1,1,1.55])
                      sphere(33, $fn=numsteps);
                // base of head
                translate([0,0,85.9])
               
                  sphere(65.0, $fn=numsteps);
              }
              // neck
              difference() {
                rotate([90,0,0])
                  translate([80,92,-40]) {
                    difference() {
                      cylinder(100,87,87, $fn=numsteps);
                      // bottom of chin
                      translate([-52,3,43])
                        rotate([0,0,40])
                          scale([1.3,1.0,.7])
                            sphere(42, $fn=numsteps);
                    }
                  }
                translate([-8.2,0,25.5])
                  scale([1,.71,1])
                    cylinder(55.8,45,3, $fn=numsteps);
              }
              // top of nose/snout
              rotate([90,0,0])
                translate([30,100,-40])
                  cylinder(80,25,25, $fn=numsteps);
              
              // side cut 1
              rotate([10,90,0])
                translate([-70,82,-32])
                  cylinder(80,75,65, $fn=numsteps*2);
                
              // side cut 2  
              rotate([-10,90,0])
                translate([-70,-82,-32])
                  cylinder(80,75,65, $fn=numsteps*2);
              
              // angle in front of ears
              translate([-3,-25,88])
                rotate([0,-5,0])
                  cube([16,50,15]);
              
              // cut between ears
              translate([15,0,18.3])
                rotate([90,0,0])
                  rotate_extrude(convexity=10, $fn=numsteps)
                    translate([80.1,0,0])
                      circle(8);    
            // mouth
            translate([23,-15,60.5])
              rotate([0,12,0])
                cube([20,30,3]);     
                
            // nostrils
            translate([31.2,2.8,69.5])
              rotate([0,90,0])
                cylinder(2,2,2,$fn=numsteps);
            translate([31.2,-2.8,69.5])
              rotate([0,90,0])
                cylinder(2,2,2,$fn=numsteps);
            
            // eyes
            translate([3,16,80])
              rotate([90,0,0])
                difference() {
                  cylinder(5,4,4, $fn=numsteps);
                  translate([0,0,-.5])
                  cylinder(6,2.2,2.2, $fn=numsteps);
                }
            translate([3,-10,80])
              rotate([90,0,0])
                difference() {
                  cylinder(5,4,4, $fn=numsteps);
                  translate([0,0,-.5])
                  cylinder(6,2.2,2.2, $fn=numsteps);
                }
          }
        // nip the tips off the nose, forehead and ears
        
        union() {

          translate([-29,0,25])
            scale([1,.32,1])
              sphere(80, $fn=numsteps); 
          translate([-33.5,-15,70])
            cube(30);
          }
          
        }
        
      // teeth
      translate([23,-8,60.0])
        rotate([0,10,0])
          cube([9,16,4]); 
      }
      
      union() {
        translate([0,0,-4.1]) {
          //cylinder(1,22,22);
          cylinder(10,20,20);
        }
        translate([0,0,5.89])
          cylinder(60,20,0);
      }
    }
}