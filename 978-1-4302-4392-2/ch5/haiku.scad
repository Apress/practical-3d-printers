
difference() {
	union() {
		// extrude inkscape vector drawing
		rotate(a=[-12,0,-4]) 
			translate(v=[-2,0,6])
				linear_extrude(height=12, convexity=30) 
					import(file="haiku.dxf", layer="Line1");
		rotate(a=[8,0,1]) 
			translate(v=[-2,-1,-4])
				linear_extrude(height=8, convexity=30) 
					import(file="haiku.dxf", layer="Line2");
		rotate(a=[10,0,6]) 
			translate(v=[-2,0,-5])
				linear_extrude(height=20, convexity=30) 
					import(file="haiku.dxf", layer="Line3");

		// add the lines across text
		rotate(a=[0,0,15])	
			translate(v=[0,2,0])
				cube(size=[115,4,4]);
		rotate(a=[0,0,-10])
			translate(v=[-6,40,0])
				cube(size=[110,4,4]);

		// connect the dots in the i's
		rotate(a=[-12,0,-4])
			translate(v=[24.625,38,+8])
				cube(size=[2.75,6,8]);
		rotate(a=[-12,0,-4])
			translate(v=[82.75,39,+8])
				cube(size=[2.75,6,8]);
	}
	// make a smooth bottom surface to print from
	translate(v=[50,50,-50])
		cube(size=[200,200,100], center=true);
}
