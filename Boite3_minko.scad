boite_x = 47;
boite_y = 98;
hrenfort = 1;
hauteur = 6.;
epaisseur = 1.4;

union () {
    
    translate([0,0,-hrenfort])
    rotate(a=[0,180,0])
    import("gqt.stl");

difference() {

union () {

minkowski () {
translate([0,0,hauteur/2])
cube([boite_y,boite_x,hauteur], center = true);
sphere(epaisseur, center = true);
}


minkowski () {
minkowski () {
translate([0,-14,-hrenfort-epaisseur+1])
cube([60,8,hrenfort], center = true);
cylinder(h = hrenfort, r=4);
}

scale([4/15, 1/15, 1/15]) sphere(r=15); 
}
minkowski () {
minkowski () {
translate([0,14,-hrenfort-epaisseur+1])
cube([60,8,hrenfort], center = true);
cylinder(h = hrenfort, r=4);
}

scale([4/15, 1/15, 1/15]) sphere(r=15); 
}
}

// on enleve l'interieur
translate([0,0,50/2])
cube([boite_y, boite_x, 50], center = true);
}

// en haut a gauche
translate([-boite_y/2+6/2,-boite_x/2+6/2,9/2])
*cube([6,6,9], center = true);

// en haut a droite
translate([-boite_y/2+6/2,+boite_x/2-6/2,9/2])
*cube([6,6,9], center = true);

// en bas
translate([boite_y/2-6/2,0,9/2])
*cube([6,6,9], center = true);

}