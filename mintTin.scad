epaisseur = 1.5;
radius=12.5;

difference() {
translate([0,0,10])
roundCornersCube(92+2*epaisseur,57.5+2*epaisseur,20,radius+epaisseur);
translate([0,0,13.5])
roundCornersCube(92,57.5,24,radius);
}



module createMeniscus(h,radius) // This module creates the shape that needs to be substracted from a cube to make its corners rounded.
difference(){        //This shape is basicly the difference between a quarter of cylinder and a cube
   translate([radius/2+0.1,radius/2+0.1,0]){
      cube([radius+0.2,radius+0.1,h+0.2],center=true);         // All that 0.x numbers are to avoid "ghost boundaries" when substracting
   }

   cylinder(h=h+0.2,r=radius,$fn = 25,center=true);
}


module roundCornersCube(x,y,z,r)  // Now we just substract the shape we have created in the four corners
difference(){
   cube([x,y,z], center=true);

translate([x/2-r,y/2-r]){  // We move to the first corner (x,y)
      rotate(0){  
         createMeniscus(z,r); // And substract the meniscus
      }
   }
   translate([-x/2+r,y/2-r]){ // To the second corner (-x,y)
      rotate(90){
         createMeniscus(z,r); // But this time we have to rotate the meniscus 90 deg
      }
   }
      translate([-x/2+r,-y/2+r]){ // ... 
      rotate(180){
         createMeniscus(z,r);
      }
   }
      translate([x/2-r,-y/2+r]){
      rotate(270){
         createMeniscus(z,r);
      }
   }
}