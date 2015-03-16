boite_y = 48.5;
boite_x = 97.6;
hrenfort = 1;
hauteur = 8.5;
epaisseur = 1.4;
pilotis = 7.5;

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
translate([0,-15,-hrenfort-epaisseur+1])
cube([60,8,hrenfort], center = true);
cylinder(h = hrenfort, r=4);
}

scale([4/15, 1/15, 1/15]) sphere(r=15); 
}
minkowski () {
minkowski () {
translate([0,15,-hrenfort-epaisseur+1])
cube([60,8,hrenfort], center = true);
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

// chargeur
translate([boite_x/2,-boite_y/2+5.6,pilotis - 1.5])
rotate([0,90,0]) 
roundCornersCube(10,9,20,2);


}


// tout en haut
translate([-boite_x/2,-boite_y/2+15,0])
cube([1.5, 5, pilotis], center = false);

// en haut a gauche
translate([-boite_x/2+33,-boite_y/2+0.5,0])
cylinder(h = pilotis, r=2);

// en haut a droite
translate([-boite_x/2+33,boite_y/2-0.5,0])
cylinder(h = pilotis, r=2);

// en bas a gauche
translate([boite_x/2-1.5,-boite_y/2+0.5,0])
cylinder(h = pilotis, r=2);

// en bas a droite
translate([boite_x/2-1.5,,boite_y/2-0.5,0])
cylinder(h = pilotis, r=2);


}


// trous de vis
// en haut a gauche
translate([-boite_x/2+33,-boite_y/2,0])
cylinder(h = 20, r=0.5, center = true);

// en haut a droite
translate([-boite_x/2+33,boite_y/2,0])
cylinder(h = 20, r=0.5, center = true);

// en bas a gauche
translate([boite_x/2-1.5,-boite_y/2,0])
cylinder(h = 20, r=0.5, center = true);

// en bas a droite
translate([boite_x/2-1.5,,boite_y/2,0])
cylinder(h = 20, r=0.5, center = true);

// tetes de vis
// en haut a gauche
translate([-boite_x/2+33,-boite_y/2,-2])
cylinder(h = 2, r=2, center = true);

// en haut a droite
translate([-boite_x/2+33,boite_y/2,-2])
cylinder(h = 2, r=2, center = true);

// en bas a gauche
translate([boite_x/2-1.5,-boite_y/2,-2])
cylinder(h = 2, r=2, center = true);

// en bas a droite
translate([boite_x/2-1.5,,boite_y/2,-2])
cylinder(h = 2, r=2, center = true);

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