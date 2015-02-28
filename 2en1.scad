
import("test.stl", convexity=3);

module example003()
{
translate([0,0,-9.5])
rotate(180, [1, 0, 0]) {
difference() {

	
		
       cube([113, 54, 20], center = true);

       translate([0,0,1])
	    cube([110, 51, 19], center = true);
		
	}
}
}

example003();