
// ---------- CAMERA ANIMATION ----------
$vpr = [58, 0, 360*$t];
$vpt = [90, 68, 0];
$vpd = 220;


/*
SMALL SITE DEVELOPMENT PLAN
Pure OpenSCAD Conceptual Civil Engineering Model
Portfolio / Educational Project — Not for Construction
*/

$fn = 36;

// ---------- COLORS ----------
grass      = [0.34,0.58,0.31];
asphalt    = [0.16,0.16,0.17];
concrete   = [0.76,0.76,0.73];
building_c = [0.78,0.73,0.66];
accent     = [0.22,0.24,0.27];
glass      = [0.25,0.55,0.72,0.65];
white      = [0.96,0.96,0.96];
yellow     = [0.96,0.79,0.12];
blue       = [0.12,0.34,0.86];
mulch      = [0.35,0.23,0.14];
water      = [0.22,0.58,0.82,0.75];
green      = [0.18,0.48,0.21];

base_h = 1.0;
site_w = 180;
site_d = 135;

// ---------- HELPERS ----------
module road(x,y,w,d,h=0.42){
    color(asphalt) translate([x,y,base_h]) cube([w,d,h]);
}

module slab(x,y,w,d,h=0.24,c=concrete){
    color(c) translate([x,y,base_h+0.42]) cube([w,d,h]);
}

module stripe(x,y,w,d,c=white){
    color(c) translate([x,y,base_h+0.47]) cube([w,d,0.06]);
}

module planter(x,y,w,d){
    color(mulch) translate([x,y,base_h+0.43]) cube([w,d,0.16]);
}

module tree(x,y,s=1){
    color([0.34,0.22,0.12])
        translate([x,y,base_h]) cylinder(h=3.8*s,r=0.32*s);
    color(green)
        translate([x,y,base_h+4.2*s]) sphere(r=1.7*s);
}

module lightpole(x,y){
    color(accent)
        translate([x,y,base_h]) cylinder(h=7.0,r=0.13);
    color([0.88,0.86,0.72])
        translate([x+0.35,y,base_h+6.8]) cube([0.8,0.28,0.16],center=true);
}

module inlet(x,y,rot=0){
    color([0.05,0.05,0.05])
        translate([x,y,base_h+0.49]) rotate([0,0,rot])
        cube([2.5,1.0,0.10],center=true);
}

module car(x,y,rot=0,c=[0.70,0.20,0.15]){
    translate([x,y,base_h+0.78]) rotate([0,0,rot]){
        color(c) cube([4.2,1.85,0.95],center=true);
        color([0.20,0.28,0.34])
            translate([0,0,0.62]) cube([2.3,1.4,0.48],center=true);
    }
}

// ---------- BUILDING ----------
module commercial_building(x,y,w=55,d=28,h=10){
    translate([x,y,base_h]){
        color(building_c) cube([w,d,h]);

        // modern dark accent wall
        color(accent)
            translate([w*0.62,-0.15,0]) cube([w*0.18,0.35,h+0.4]);

        // glazed storefront
        color(glass)
            translate([5,-0.10,1.0]) cube([w-10,0.16,4.0]);

        // entrance canopy
        color(accent)
            translate([w/2-8,-2.5,4.4]) cube([16,2.5,0.35]);

        // roof parapet
        color(accent)
            translate([-0.4,-0.4,h]) cube([w+0.8,d+0.8,0.55]);
    }
}

// ---------- PARKING ----------
module parking_row(x,y,spaces=8,stall_w=3.4,stall_d=6.2){
    for(i=[0:spaces])
        stripe(x+i*stall_w,y,0.10,stall_d);
}

module ada_space(x,y){
    color(blue)
        translate([x,y,base_h+0.48]) cube([3.7,6.2,0.05]);
    stripe(x+3.65,y,0.10,6.2);
}

module curb_island(x,y,w=6,d=3){
    slab(x,y,w,d,0.38);
    planter(x+0.5,y+0.5,w-1,d-1);
}

module ada_ramp(x,y,rot=0){
    color(concrete)
        translate([x,y,base_h+0.43])
        rotate([0,0,rot])
        linear_extrude(height=0.18)
        polygon(points=[[0,0],[4,0],[4,3],[0,2.1]]);
}

// ---------- DETENTION ----------
module detention_area(x,y,w=42,d=20){
    color([0.24,0.48,0.22])
        translate([x-2,y-2,base_h+0.02]) cube([w+4,d+4,0.14]);

    color(water)
        translate([x,y,base_h+0.18]) cube([w,d,0.26]);
}

// ---------- SITE BASE ----------
color(grass) cube([site_w,site_d,base_h]);

// public road
road(0,0,site_w,20);
stripe(0,9.3,site_w,0.20,yellow);
stripe(0,10.1,site_w,0.20,yellow);

// driveway entrance
road(75,20,30,31);

// internal drive aisle / parking
road(18,51,144,20);
road(18,71,144,32);

// sidewalks
slab(18,47,144,3);
slab(18,104,144,3);
slab(71,20,3,30);
slab(106,20,3,30);

// building pad + building
slab(62,103,58,29,0.28);
commercial_building(64,104,54,25,9);

// parking rows
parking_row(23,54,12);
parking_row(23,76,12);
parking_row(117,54,11);
parking_row(117,76,11);

// ADA stalls and route
ada_space(79,76);
ada_space(83,76);
slab(77,82.2,12,21);
ada_ramp(80,100,0);

// curb islands
curb_island(18,50,7,5);
curb_island(59,50,7,5);
curb_island(112,50,7,5);
curb_island(155,50,7,5);

curb_island(18,98,7,5);
curb_island(59,98,7,5);
curb_island(112,98,7,5);
curb_island(155,98,7,5);

// landscape islands trees
for(p=[[21.5,52.5],[62.5,52.5],[115.5,52.5],[158.5,52.5],
       [21.5,100.5],[62.5,100.5],[115.5,100.5],[158.5,100.5]])
    tree(p[0],p[1],0.72);

// storm drainage
for(p=[[27,68],[69,68],[111,68],[153,68],
       [27,100],[69,100],[111,100],[153,100]])
    inlet(p[0],p[1]);

// detention pond
detention_area(8,110,42,16);

// conceptual outlet pipe to detention pond
color([0.18,0.18,0.18])
    translate([46,108,base_h+0.22])
    rotate([0,90,0]) cylinder(h=18,r=0.35);

// sample cars
car(31,60,0,[0.66,0.17,0.14]);
car(48,60,0,[0.20,0.36,0.72]);
car(130,60,0,[0.24,0.52,0.29]);
car(145,83,0,[0.74,0.74,0.76]);
car(96,83,0,[0.55,0.24,0.64]);

// lighting
for(p=[[26,48],[56,48],[91,48],[126,48],[157,48],
       [26,106],[56,106],[126,106],[157,106]])
    lightpole(p[0],p[1]);

// entrance monument
color(accent)
    translate([112,29,base_h]) cube([14,1.5,3.8]);
color([0.54,0.36,0.22])
    translate([113,28.9,base_h+0.8]) cube([12,0.14,1.8]);

// north arrow
translate([166,117,base_h+0.5]){
    color(accent)
        linear_extrude(height=0.16)
        polygon(points=[[0,12],[-2.5,4.2],[0,5.7],[2.5,4.2]]);
}

// labels
module label(txt,x,y,size=3.2,rot=0){
    color([0.04,0.04,0.04])
        translate([x,y,base_h+0.55])
        rotate([0,0,rot])
        linear_extrude(height=0.12)
        text(txt,size=size,halign="center",valign="center");
}

label("SMALL SITE DEVELOPMENT",90,131,5.2);
label("COMMERCIAL BUILDING",91,117,3.2);
label("ADA ROUTE",84,93,2.2,90);
label("DETENTION AREA",29,118,2.4);
label("PUBLIC ROAD",90,6.5,3.5);
