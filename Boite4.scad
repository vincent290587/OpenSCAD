boite_y = 46;
boite_x = 65;
hrenfort = 0.7;
hauteur = 11;
epaisseur = 1.4;
pilotis = 10;
d_screw = 2.5;
e_screw = 0.8;

xs1 = - boite_x / 2 + 1.45;
xs2 = - boite_x / 2 + 1.45;
xs3 = - boite_x / 2 + 40.05;
xs4 = - boite_x / 2 + 63.4;
xs5 = - boite_x / 2 + 29;

ys1 = - boite_y / 2 + 3.5;
ys2 = - boite_y / 2 + 43.6;
ys3 = - boite_y / 2 + 1.75;
ys4 = - boite_y / 2 + 29.15;
ys5 = - boite_y / 2 + 44;


difference () {
union () {
    
translate([0,0,-hrenfort])
rotate(a=[0,180,0])
import("gqt.stl");
    

difference() {

union () {

minkowski () {
translate([0,0,hauteur/2])
cube([boite_x,boite_y,hauteur], center = true);
sphere(epaisseur, center = true);
}


minkowski () {
minkowski () {
translate([0,-14.7,-hrenfort-epaisseur+1])
cube([35,7,hrenfort], center = true);
cylinder(h = hrenfort, r=4);
}

scale([4/15, 1/15, 1/15]) sphere(r=15); 
}
minkowski () {
minkowski () {
translate([0,14.7,-hrenfort-epaisseur+1])
cube([35,7,hrenfort], center = true);
cylinder(h = hrenfort, r=4);
}

scale([4/15, 1/15, 1/15]) sphere(r=15); 
}


}

// on enleve l'interieur
translate([0,0,50/2])
cube([boite_x, boite_y, 50], center = true);

// pour faciliter la visserie
translate([0,0,hauteur+10/2]) {
cube([300, 300, 10], center = true);
}

// teensy
translate([-boite_x/2,-boite_y/2+23,pilotis - 3])
rotate([0,90,0]) 
roundCornersCube(5,9,20,2);

// SD
translate([-boite_x/2 + 47.5,boite_y/2,pilotis-0.5])
rotate([90,90,0]) 
roundCornersCube(7.5,20,20,2);

}

// trous de vis
// en haut a gauche
translate([xs1,ys1,0])
cylinder(h = pilotis, r=d_screw/2 + e_screw, center = false);

translate([xs2,ys2,0])
cylinder(h = pilotis, r=d_screw/2 + e_screw, center = false);

translate([xs3,ys3,0])
cylinder(h = pilotis, r=d_screw/2 + e_screw, center = false);

translate([xs4,ys4,0])
cylinder(h = pilotis, r=d_screw/2 + e_screw, center = false);

translate([xs5,ys5,0])
cylinder(h = pilotis, r=d_screw/2 + e_screw, center = false);



}

translate([xs1,ys1,0])
cylinder(h = 40, r=d_screw/2, center = true);

translate([xs2,ys2,0])
cylinder(h = 40, r=d_screw/2, center = true);

translate([xs3,ys3,0])
cylinder(h = 40, r=d_screw/2, center = true);

translate([xs4,ys4,0])
cylinder(h = 40, r=d_screw/2, center = true);

translate([xs5,ys5,0])
cylinder(h = 40, r=d_screw/2, center = true);


// tetes de vis
// en haut a gauche
translate([xs3,ys3,-2])
cylinder(h = 2, r=4, center = true);

// en haut a droite
translate([xs5,ys5,-2])
cylinder(h = 2, r=4, center = true);

// en bas a gauche
//translate([boite_x/2-1.5,-boite_y/2,-2])
//cylinder(h = 2, r=2, center = true);

// en bas a droite
//translate([boite_x/2-1.5,,boite_y/2,-2])
//cylinder(h = 2, r=2, center = true);

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