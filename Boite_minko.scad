
hrenfort = 2;
hauteur = 12.;
epaisseur = 1.4;

union () {
    
    translate([0,0,-0.4-hrenfort])
    rotate(a=[0,180,0])
    import("gqt.stl");

difference() {

hull () {

minkowski () {
translate([0,0,hauteur/2])
cube([101.5,50.5,hauteur], center = true);
sphere(epaisseur, center = true);
}

minkowski () {
translate([0,0,-hrenfort-epaisseur])
cube([60,35,hrenfort], center = true);
cylinder(h = hrenfort, r=4);
}

}

// on enleve l'interieur
translate([0,0,50/2])
cube([101.5, 50.5, 50], center = true);
}

// en haut a gauche
translate([-101.5/2+6/2,-50.5/2+6/2,9/2])
*cube([6,6,9], center = true);

// en haut a droite
translate([-101.5/2+6/2,+50.5/2-6/2,9/2])
*cube([6,6,9], center = true);

// en bas
translate([101.5/2-6/2,0,9/2])
*cube([6,6,9], center = true);

}