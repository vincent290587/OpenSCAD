epaisseur1=1.4;
radius=epaisseur1;
marge = 0.3;
xc=97.6;
yc=48.5;
xb=xc+2*epaisseur1+2*marge;
yb=yc+2*epaisseur1+2*marge;
offset=7;

rebord = 3.1;
epaisseur=1.1;
hecran=48;
lecran=36;
zecran=8;
d_screw = 1.27;

difference () {
    
union () {

translate([-xc/2+15,-9,-12.1])
minkowski () {
linear_extrude(height = 0.5, center = true, convexity = 10, twist = 0)
resize([20,20,0])
rotate([0, 0, -90])
union () {
resize([27.5,27.5,0])
polygon(points=[[0,0],[36,0],[18,36],[11,0],[36-11,0],[18,14]],
paths=[[0,2,1],[5,4,3]]);

translate([36-26+9,0,0])
rotate([0, 0, 180])
polygon(points=[[0,0],[36,0],[18,36],[11,0],[36-11,0],[18,14]],
paths=[[0,2,1],[5,4,3]]); 
}
sphere(r=0.2);
}

difference () {

// coque de base
minkowski () {

union () {
    
// cube de coque (ecran)
hull () {
translate([-xb/2+4*offset,yb/2-(yb-lecran)/2,0])
resize(newsize=[8*offset,(yb-lecran),zecran*2])
sphere(r=120);
    
translate([xb/2-1*offset,yb/2-(yb-lecran)/2,0])
resize(newsize=[2*offset,(yb-lecran),zecran*2])
sphere(r=120);
    
translate([-xb/2+4*offset,-yb/2+(yb-lecran)/2,0])
resize(newsize=[8*offset,(yb-lecran),zecran*2])
sphere(r=120);
    
translate([xb/2-1*offset,-yb/2+(yb-lecran)/2,0])
resize(newsize=[2*offset,(yb-lecran),zecran*2])
sphere(r=120);

translate([0,0,(rebord+2) / 2-3])
roundCornersCube(xb,yb,(rebord+2),radius+epaisseur1);
}

    
hull () {

// GPS
translate([-xc/2+28/2,-yc/2+26/2,-(11)/2])
cube([28, 26, 11], center = true);
    
// boite ecran
translate([-60/2,-15/2,rebord / 2])
roundCornersCube(xb-60,yb-15,rebord,radius+epaisseur1);
    
}

translate([0,0,rebord / 2])
roundCornersCube(xb,yb,rebord,radius+epaisseur1);
}
sphere(epaisseur, center = true);
}

// ceci est la box inferieure (exterieur)
translate([0,0,25])
roundCornersCube(xb,yb,50,radius+epaisseur1);

// nettoyage base
translate([0,0,rebord+epaisseur+50/2-0.3])
cube([300,300,50], center = true);

// ceci est l'ecran
translate([xc/2-offset-hecran/2,0,-2])
cube([hecran, lecran, 100], center = true);
translate([xc/2-0.7-66/2,0,-5/2])
cube([66, lecran, 5], center = true);

// ceci est la SD
translate([xc/2,-2.5,-2])
rotate([0,90,0]) 
roundCornersCube(3,15,20,2);

// ceci est la molette
translate([-xc/2+21.5,yc/2,-1.5+1])
rotate([0,90,90]) 
roundCornersCube(3,14,20,1);


hull () {

// GPS
translate([-xc/2+28/2,-yc/2+26/2,-(11)/2])
cube([28, 26, 11], center = true);
    
// boite GPS
translate([-60/2,-15/2,rebord / 2])
roundCornersCube(xb-60,yb-15,rebord,radius+epaisseur1);
    
}

// cube de coque (ecran)
hull () {
translate([-xb/2+4*offset,yb/2-(yb-lecran)/2,0])
resize(newsize=[8*offset,(yb-lecran),zecran*2])
sphere(r=120);
    
translate([xb/2-1*offset,yb/2-(yb-lecran)/2,0])
resize(newsize=[2*offset,(yb-lecran),zecran*2])
sphere(r=120);
    
translate([-xb/2+4*offset,-yb/2+(yb-lecran)/2,0])
resize(newsize=[8*offset,(yb-lecran),zecran*2])
sphere(r=120);
    
translate([xb/2-1*offset,-yb/2+(yb-lecran)/2,0])
resize(newsize=[2*offset,(yb-lecran),zecran*2])
sphere(r=120);

translate([0,0,(rebord+2) / 2-3])
roundCornersCube(xb,yb,(rebord+2),radius+epaisseur1);
}

}

intersection () {
// cube de coque (ecran)
    union () {
hull () {
translate([-xb/2+4*offset,yb/2-(yb-lecran)/2,0])
resize(newsize=[8*offset,(yb-lecran),zecran*2])
sphere(r=120);
    
translate([xb/2-1*offset,yb/2-(yb-lecran)/2,0])
resize(newsize=[2*offset,(yb-lecran),zecran*2])
sphere(r=120);
    
translate([-xb/2+4*offset,-yb/2+(yb-lecran)/2,0])
resize(newsize=[8*offset,(yb-lecran),zecran*2])
sphere(r=120);
    
translate([xb/2-1*offset,-yb/2+(yb-lecran)/2,0])
resize(newsize=[2*offset,(yb-lecran),zecran*2])
sphere(r=120);

translate([0,0,(rebord+2) / 2-3])
roundCornersCube(xb,yb,(rebord+2),radius+epaisseur1);
}
hull () {

// GPS
translate([-xc/2+28/2,-yc/2+26/2,-(11)/2])
cube([28, 26, 11], center = true);
    
// boite ecran
translate([-60/2,-15/2,rebord / 2])
roundCornersCube(xb-60,yb-15,rebord,radius+epaisseur1);
    
}
}
union () {
// en haut
translate([-xc/2+33,-yc/2-0.4,-8/2])
cylinder(h = 8, r=2.5, center = true);

translate([-xc/2+33,yc/2+0.4,-8/2])
cylinder(h = 8, r=2.5, center = true);

//en bas
translate([xc/2-1.5,-yc/2-0.4,-7/2])
cylinder(h = 7, r=2.5, center = true);

translate([xc/2-1.5,yc/2+0.4,-7/2])
cylinder(h = 7, r=2.5, center = true);
}
}

}

// en haut
translate([-xc/2+33,-yc/2,-5/2])
cylinder(h = 5, r=d_screw/2, center = true);

translate([-xc/2+33,yc/2,-4.7/2])
cylinder(h = 4.7, r=d_screw/2, center = true);

//en bas
translate([xc/2-1.5,-yc/2,-4.5/2])
cylinder(h = 4.5, r=d_screw/2, center = true);

translate([xc/2-1.5,yc/2,-4.5/2])
cylinder(h = 4.5, r=d_screw/2, center = true);


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