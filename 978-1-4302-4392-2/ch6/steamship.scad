// disable $fn and $fa, do not change these
$fn=0;
$fa=0.01;

// use $fs to control the number of facets globally
// fine ~ 0.1  coarse ~ 1.0
$fs=0.3;

filament_dia = 1.7; // used for cannon barrels

printbed_w = 100; // set to the width of your printbed
printbed_d = 100; // set to the depth of your printbed

printbed_max = sqrt(pow(printbed_w,2)+pow(printbed_d,2)); // calculates diagonal

shipscale=printbed_max-20; // shipscale should not exceed build platform size

echo(str("Hull length = ",shipscale,"mm"));
echo(str("Hull width = ",shipscale/4,"mm"));

* % translate([0,0,-5]) cube([printbed_w,printbed_d,0.5], center=true); // printbed

rotate([0,0,45]) 
warship();

module warship(size=shipscale) {
	main_deck(size);
	mid_ship(size);
	translate([size/5.5,0,0]) lower_tower(size);
	translate([-size/5.5,0,size/38*0.1]) lower_tower(size*0.9);
	translate([size/5.5,0,size/14]) bridge(size*0.6);
	translate([size/6.5,size/14,size/38]) rotate([0,0,0]) side_sponson(size/16);
	translate([-size/6.5,size/14,size/38]) rotate([0,0,90]) side_sponson(size/16);
	translate([size/6.5,-size/14,size/38]) rotate([0,0,-90]) side_sponson(size/16);
	translate([-size/6.5,-size/14,size/38]) rotate([0,0,180]) side_sponson(size/16);
	translate([size/3.5,0,0]) rotate([0,0,0]) main_turret(size);
	translate([-size/3.5,0,0]) rotate([0,0,180]) main_turret(size);
	translate([size/14,0,0]) stack(size);
	translate([-size/32,0,0]) stack(size);
	translate([size/28,size/22,size/14]) rotate([0,0,30]) vent(size);
	translate([-size/15,size/22,size/14]) rotate([0,0,30]) vent(size);
	translate([-size/9,size/22,size/14]) rotate([0,0,30]) vent(size);
	translate([size/28,-size/22,size/14]) rotate([0,0,-30]) vent(size);
	translate([-size/15,-size/22,size/14]) rotate([0,0,-30]) vent(size);
	translate([-size/9,-size/22,size/14]) rotate([0,0,-30]) vent(size);
}

module main_deck(hl) {
	difference() {
		union() {
			// main deck basic form
			scale([1.5,1,1])
			intersection() {
				translate([0,hl*0.375,hl/100]) cylinder(h=hl/16,r=hl/2,center=true);
				translate([0,-hl*0.375,hl/100]) cylinder(h=hl/16,r=hl/2,center=true);
			}
			// side sponsons
			translate([hl/6.5,hl/12,hl/100]) rotate([0,0,-10])  scale([1.5,1,1]) 
				cylinder(h=hl/16,r1=hl/38,r2=hl/18,center=true);
			translate([-hl/6.5,hl/12,hl/100]) rotate([0,0,10]) scale([1.5,1,1])
				cylinder(h=hl/16,r1=hl/38,r2=hl/18,center=true);
			translate([hl/6.5,-hl/12,hl/100]) rotate([0,0,10]) scale([1.5,1,1])
				cylinder(h=hl/16,r1=hl/38,r2=hl/18,center=true);
			translate([-hl/6.5,-hl/12,hl/100]) rotate([0,0,-10]) scale([1.5,1,1])
				cylinder(h=hl/16,r1=hl/38,r2=hl/18,center=true);
		}
		union() {
			// upper deck indention for side rail
			scale([1.425,0.925,1])
			intersection() {
				translate([0,hl/2-hl/8,hl/14]) cylinder(h=hl/12,r=hl/2,center=true);
				translate([0,-(hl/2-hl/8),hl/14]) cylinder(h=hl/12,r=hl/2,center=true);
			}
			// indention for side sponsons
			translate([hl/6.5,hl/12,hl/14]) rotate([0,0,-10]) scale([1.3,0.8,1])
				cylinder(h=hl/12,r=hl/18,center=true);
			translate([-hl/6.5,hl/12,hl/14]) rotate([0,0,10]) scale([1.3,0.8,1])
				cylinder(h=hl/12,r=hl/18,center=true);
			translate([hl/6.5,-hl/12,hl/14]) rotate([0,0,10]) scale([1.3,0.8,1])
				cylinder(h=hl/12,r=hl/18,center=true);
			translate([-hl/6.5,-hl/12,hl/14]) rotate([0,0,-10]) scale([1.3,0.8,1])
				cylinder(h=hl/12,r=hl/18,center=true);
		}
		// filament pins
		translate([hl/3.5,0,0]) cylinder(h=hl/2,r=filament_dia*0.55);
		translate([-hl/3.5,0,0]) cylinder(h=hl/2,r=filament_dia*0.55);
		translate([hl/8,0,0]) cylinder(h=hl/3.5,r=filament_dia*0.55);
		translate([-hl/8,0,0]) cylinder(h=hl/3.5,r=filament_dia*0.55);
	}
}

module mid_ship(ms) {
	difference() {
		translate([-ms/6.5,-ms/14,ms/38]) cube([ms/3.25,ms/7,ms/22]);

		// gun slits for 1.75mm filament barrels
		translate([-ms/14,-ms/14,ms/18.5]) 
			cube([ms/24,ms/20,filament_dia],center=true);
		translate([0,-ms/14,ms/18.5]) 
			cube([ms/24,ms/20,filament_dia],center=true);
		translate([ms/14,-ms/14,ms/18.5]) 
			cube([ms/24,ms/20,filament_dia],center=true);
		translate([-ms/14,ms/14,ms/18.5]) 
			cube([ms/24,ms/20,filament_dia],center=true);
		translate([0,ms/14,ms/18.5]) 
			cube([ms/24,ms/20,filament_dia],center=true);
		translate([ms/14,ms/14,ms/18.5]) 
			cube([ms/24,ms/20,filament_dia],center=true);

		// mast mounting
		translate([ms/8,0,0]) cylinder(h=ms/3.5,r=filament_dia*0.55);
		translate([-ms/8,0,0]) cylinder(h=ms/3.5,r=filament_dia*0.55);
	}
}

module lower_tower(lt) {
	difference() {
		union() {
			translate([0,-lt/60,lt/38]) rotate([0,0,22.5])
				cylinder(h=lt/14,r=lt/20,$fn=8);
			translate([0,lt/60,lt/38]) rotate([0,0,22.5]) 
				cylinder(h=lt/14,r=lt/20,$fn=8);
		}
		scale([0.85,0.85,0.5]) translate([0,0,lt/6.5])
		union() {
			translate([0,-lt/60,lt/38]) rotate([0,0,22.5])
				cylinder(h=lt/14,r=lt/20,$fn=8);
			translate([0,lt/60,lt/38]) rotate([0,0,22.5]) 
				cylinder(h=lt/14,r=lt/20,$fn=8);
		}
	}
}

module bridge(bs) {
	difference() {
		union() {
			// bridge form
			scale([1.25,1.75,1]) translate([bs/120,0,0])
			union() {
				translate([-bs/120,0,bs/32.5]) rotate([0,0,22.5]) 
					cylinder(h=bs/12,r=bs/30,$fn=8);
				translate([-bs/53,0,bs/32.5]) scale([1,1.325,1]) rotate([0,0,45]) 
					cylinder(h=bs/12,r=bs/30.325,$fn=4);
			}
			// roof ridge
			scale([1.25,1.75,1]) translate([bs/120,0,bs/14])
			union() {
				translate([-bs/120,0,bs/32.5]) rotate([0,0,22.5]) 
					cylinder(h=bs/60,r1=bs/30,r2=bs/26,$fn=8);
				translate([-bs/53,0,bs/32.5]) scale([1,1.325,1]) rotate([0,0,45]) 
					cylinder(h=bs/60,r1=bs/30.325,r2=bs/26,$fn=4);
			}

		}
		// roof platform
		scale([1,1.5,1]) translate([bs/120,0,bs/12.5])
			union() {
				translate([-bs/120,0,bs/32.5]) rotate([0,0,22.5]) 
					cylinder(h=bs/12,r=bs/30,$fn=8);
				translate([-bs/53,0,bs/32.5]) scale([1,1.325,1]) rotate([0,0,45]) 
					cylinder(h=bs/12,r=bs/30.325,$fn=4);
			}
		// bridge windows
		translate([bs/26.5,0,bs/12]) cube([bs/60,bs/60,filament_dia],center=true);
		translate([bs/36,bs/28,bs/12]) rotate([0,0,36])
				cube([bs/60,bs/60,filament_dia],center=true);
		translate([bs/36,-bs/28,bs/12]) rotate([0,0,-36])
				cube([bs/60,bs/60,filament_dia],center=true);
	}
}

module side_sponson(ss) {
	difference() {
		// sponson
		cylinder(h=ss/1.25,r=ss/2);
		// gun slot
		translate([0,0,ss/2.75]) cube([ss/2,ss/2,filament_dia]);
	}
}

module main_turret(mt) {
	difference() {
		union() {
			// round base
			translate([0,0,mt/38])
				cylinder(h=mt/86,r=mt/18);
			difference() {
				// main turret body
				translate([0,0,mt/30]) rotate([0,0,22.5])
					cylinder(h=mt/22,r1=mt/19,r2=mt/24,$fn=8);
				// sloped front
				translate([mt/14,0,mt/22]) rotate([0,60,0])
					cube([mt/9,mt/9,mt/20],center=true);
				// cannon slots 1.75mm filament cannons
				translate([mt/38,mt/70,mt/12])
					cube([mt/32,filament_dia,mt/16],center=true);
				translate([mt/38,-mt/70,mt/12])
					cube([mt/32,filament_dia,mt/16],center=true);
			}
		}
		// filament axle
		cylinder(h=mt/18,r=filament_dia*0.55);
	}
}

module stack(ss) {
	difference() {
		union() {
			// main stack
			translate([0,0,ss/14]) cylinder(h=ss/7.5,r=ss/32);
			// base
			translate([0,0,ss/14]) cylinder(h=ss/64,r=ss/24);
			// rings
			translate([0,0,ss/5.325]) cylinder(h=ss/100,r=ss/29);
			translate([0,0,ss/6.75]) cylinder(h=ss/100,r=ss/29);
		}
		// inside
		translate([0,0,ss/14]) cylinder(h=ss/7,r=ss/60);
	}
}

module vent(vs) {
	scale([1.1,1.1,1.1])
	difference() {
		union() {
			cylinder(h=vs/40,r=vs/80);
			translate([0,0,vs/55.75]) tube_slice();
			translate([-vs/530,0,vs/40.1]) rotate([0,30,0]) tube_slice();
			translate([0,0,vs/31.325]) rotate([0,60,0]) tube_slice();
			translate([vs/195,0,vs/27]) rotate([0,90,0]) tube_slice();
		}
	translate([vs/200,0,vs/27]) rotate([0,90,0]) cylinder(h=vs/60,r=vs/150);	
	}
}

module tube_slice(vs=shipscale) {
	difference() {
		cylinder(h=vs/60,r=vs/80);
		translate([0,0,-vs/360]) rotate([0,-15,0]) cube([vs/30,vs/30,vs/80],center=true);
		translate([0,0,vs/60]) rotate([0,15,0]) cube([vs/30,vs/30,vs/80],center=true);

	}
}

