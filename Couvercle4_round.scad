epaisseur1=1.4;
radius=epaisseur1;
marge = 0.3;
xc=63;
yc=43;
zecran=6.0;
xb=xc+2*epaisseur1+2*marge;
yb=yc+2*epaisseur1+2*marge;
offset=0.2;
//voffset = .75;
rebord = 3.5;
epaisseur=1.1;
marge_ba=1.2;
hecran=64;
lecran=46;


difference () {

// coque de base
minkowski () {
    
//union () {
// cube de coque (ecran)
hull() {
    
// cube de coque (ecran)
hull () {
translate([-xc/2+offset,yc/2-offset,-zecran])
resize(newsize=[2,2,2])
sphere(r=120);
    
translate([xc/2-offset,yc/2-offset,-zecran])
resize(newsize=[2,2,2])
sphere(r=120);
    
translate([-xc/2+offset,-yc/2+offset,-zecran])
resize(newsize=[2,2,2])
sphere(r=120);
    
translate([xc/2-offset,-yc/2+offset,-zecran])
resize(newsize=[2,2,2])
sphere(r=120);

translate([0,0,(rebord+2) / 2-3])
roundCornersCube(xb,yb,(rebord+2),radius+epaisseur1);
}

// socle ecran
//translate([0,0,rebord / 2])
//roundCornersCube(xb,yb,rebord,radius+epaisseur1);

}



//}
sphere(epaisseur, center = true);
}

// ceci est la box inferieure (exterieur)
translate([0,0,25])
roundCornersCube(xb,yb,50,radius+epaisseur1);

// ceci est l'ecran
translate([0,0,-2])
cube([60, 38, 100], center = true);



union () {
hull() {
    
translate([-xc/2+offset,yc/2-offset,-zecran])
resize(newsize=[2,2,2])
sphere(r=120);
    
translate([xc/2-offset,yc/2-offset,-zecran])
resize(newsize=[2,2,2])
sphere(r=120);
    
translate([-xc/2+offset,-yc/2+offset,-zecran])
resize(newsize=[2,2,2])
sphere(r=120);
    
translate([xc/2-offset,-yc/2+offset,-zecran])
resize(newsize=[2,2,2])
sphere(r=120);

translate([0,0,(rebord+2) / 2-3])
roundCornersCube(xb,yb,(rebord+2),radius+epaisseur1);
    
}

translate([0,0,50])
cube([100, 100, 100], center = true);
}

}

difference () {
    
// ceci est l'ecran
translate([0,0,-zecran - epaisseur + 0.2])
cube([64, 44, 0.8], center = true);
    
    
// ceci est l'ecran
translate([0,0,0])
cube([58, 36, 100], center = true);
    
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