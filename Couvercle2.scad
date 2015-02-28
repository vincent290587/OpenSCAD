epaisseur1=1.5;
radius=2;
xc=101.5;
yc=50.5;
xb=xc+2*epaisseur1;
yb=yc+2*epaisseur1;
offset=4.5;
voffset = .75;
rebord = 3;
epaisseur=1.2;
marge_ba=1.2;
hecran=57;

difference () {

// coque de base
hull () {
        
      // cube de coque (ecran
        translate([xc/2-(hecran+4.5+5.5)/2+0.5,0,-9])
        cube([hecran+4.5+5.5, 41, 18], center = true);

      // GPS
      translate([-xc/2+30/2,-yc/2+30/2,-(13+epaisseur1)/2])
        cube([30, 30, 13+epaisseur1], center = true);

      // Inter
      translate([-xc/2+20/2+4/2,yc/2-13/2-3/2,-4.5])
      cube([20, 13, 9], center = true);
        
        translate([0,0,rebord / 2])
        roundCornersCube(xb+epaisseur*2,yb+epaisseur*2,rebord,radius+epaisseur+epaisseur1);

    }

// ceci est la box inferieure (exterieur)
translate([0,0,25+marge_ba])
roundCornersCube(xb,yb,50,radius+epaisseur1);

// ceci est l'ecran
translate([xb/2-57/2-offset,0,-2])
cube([57, 41, 100], center = true);

// ceci est la SD
translate([xb/2,0,-1.5-13.5])
cube([20, 15, 3], center = true);

// Inter
translate([-xc/2+20/2+4/2,yc/2-13/2-3/2,-4.5-9])
#cube([20, 13, 9], center = true);

// Inter
translate([-xc/2+20/2+4/2,yc/2-13/2-3/2,-15])
cube([5, 13, 30], center = true);

// on evide l'interieur
hull() {
        
      // cube de coque
        translate([xc/2-(hecran+4.5+5.5)/2+0.5,0,-9+voffset])
        cube([hecran+4.5+5.5, 41, 18], center = true);

      // GPS
      translate([-xc/2+30/2,-yc/2+30/2,-6.5+voffset])
        cube([30, 30, 13], center = true);

      // Inter
      translate([-xc/2+30/2+3/2,-2/2,-4.5+voffset])
        cube([30-3, yc-2, 9], center = true);
        
        translate([0,0,2+voffset])
        roundCornersCube(xb,yb,4,radius+epaisseur1);
        
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