epaisseur1=1.4;
radius=epaisseur1;
marge = 0.3;
xc=101.5;
yc=50.5;
xb=xc+2*epaisseur1+2*marge;
yb=yc+2*epaisseur1+2*marge;
offset=4;
//voffset = .75;
rebord = 3.5;
epaisseur=1.1;
marge_ba=1.2;
hecran=57;



difference () {

// coque de base
minkowski () {
union () {
// cube de coque (ecran)
hull() {
    
// PCB ecran
translate([xc/2-(hecran+4.5+5.5)/2+0.5,0,-15/2])
cube([hecran+4.5+5.5, 41+2, 15], center = true);


// socle ecran
translate([(4.5+5.5)/2,0,rebord / 2])
roundCornersCube(xb-(4.5+5.5),yb,rebord,radius+epaisseur1);

}

hull () {

// GPS
translate([-xc/2+28/2,-yc/2+26/2,-(12)/2])
cube([28, 26, 12], center = true);
    
// boite ecran
translate([-60/2,-15/2,rebord / 2])
roundCornersCube(xb-60,yb-15,rebord,radius+epaisseur1);
    
}

hull () {
  // Inter
  translate([-xc/2+40/2+4.5/2-0.5,yc/2-20/2-1.7/2,-7/2])
  cube([40, 20, 7], center = true);
    
  translate([0,0,rebord / 2])
  roundCornersCube(xb,yb,rebord,radius+epaisseur1);

}
}
sphere(1.05, center = true);
}

// ceci est la box inferieure (exterieur)
translate([0,0,25])
roundCornersCube(xb,yb,50,radius+epaisseur1);

// ceci est l'ecran
translate([xc/2-57/2-offset,0,-2])
cube([57, 41, 100], center = true);
// PCB ecran
translate([xc/2-(hecran+4.5+5.5)/2+0.5,0,-15/2])
cube([hecran+4.5+5.5, 41+2, 15], center = true);

// ceci est la SD
translate([xc/2,-2.5,-11.5])
rotate([0,90,0]) 
roundCornersCube(3,15,20,2);

// chargeur
translate([-4.5,-25,-4])
rotate([0,90,90]) 
roundCornersCube(4,9,20,2);

// Inter
translate([-xc/2+5/2+4,yc/2-13/2-3/2,-15])
cube([5, 13, 30], center = true);


hull () {

// GPS
translate([-xc/2+28/2,-yc/2+26/2,-(12)/2])
cube([28, 26, 12], center = true);
    
// boite ecran
translate([-60/2,-15/2,rebord / 2])
roundCornersCube(xb-60,yb-15,rebord,radius+epaisseur1);
    
}

hull () {
  // Inter
  translate([-xc/2+40/2+4.5/2-0.5,yc/2-20/2-1.7/2,-7/2])
  cube([40, 20, 7], center = true);
    
  translate([0,0,rebord / 2])
  roundCornersCube(xb,yb,rebord,radius+epaisseur1);

}

hull() {
    
// PCB ecran
translate([xc/2-(hecran+4.5+5.5)/2+0.5,0,-15/2])
cube([hecran+4.5+5.5, 41+2, 15], center = true);


// socle ecran
translate([10/2,0,rebord / 2])
roundCornersCube(xb-10,yb,rebord,radius+epaisseur1);

}

}

/////////////////////////////////
/////////////////////////////////
/////////////////////////////////
/////////////////////////////////

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