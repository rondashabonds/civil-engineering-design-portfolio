
// ---------- CAMERA ANIMATION ----------
$vpr = [58, 0, 360*$t];
$vpt = [95, 95, 0];
$vpd = 235;


/*
ROADWAY / INTERSECTION DESIGN
Pure OpenSCAD Conceptual Transportation Design
Portfolio / Educational Project — Not for Construction
*/

$fn = 32;

// ---------- COLORS ----------
grass    = [0.34,0.58,0.31];
asphalt  = [0.15,0.15,0.16];
concrete = [0.76,0.76,0.73];
white    = [0.96,0.96,0.96];
yellow   = [0.96,0.79,0.10];
dark     = [0.12,0.12,0.13];
red      = [0.80,0.12,0.10];
green    = [0.08,0.55,0.20];
amber    = [0.95,0.65,0.08];

base_h = 1.0;
site_w = 190;
site_d = 190;

module road(x,y,w,d){
    color(asphalt) translate([x,y,base_h]) cube([w,d,0.44]);
}

module slab(x,y,w,d,h=0.24){
    color(concrete) translate([x,y,base_h+0.44]) cube([w,d,h]);
}

module stripe(x,y,w,d,c=white){
    color(c) translate([x,y,base_h+0.49]) cube([w,d,0.06]);
}

module inlet(x,y,rot=0){
    color([0.04,0.04,0.04])
        translate([x,y,base_h+0.51])
        rotate([0,0,rot]) cube([2.4,1.0,0.10],center=true);
}

module tree(x,y,s=1){
    color([0.34,0.22,0.12])
        translate([x,y,base_h]) cylinder(h=3.6*s,r=0.30*s);
    color([0.17,0.47,0.20])
        translate([x,y,base_h+4.0*s]) sphere(r=1.6*s);
}

module car(x,y,rot=0,c=[0.68,0.18,0.15]){
    translate([x,y,base_h+0.80]) rotate([0,0,rot]){
        color(c) cube([4.2,1.8,0.95],center=true);
        color([0.22,0.29,0.34])
            translate([0,0,0.62]) cube([2.3,1.35,0.48],center=true);
    }
}

module signal_pole(x,y,rot=0){
    translate([x,y,base_h]){
        color(dark) cylinder(h=8,r=0.16);

        rotate([0,0,rot])
        translate([0,0,7.3]){
            color(dark) cube([6,0.18,0.18]);

            translate([5.2,0,0]){
                color(dark) cube([0.9,0.55,2.6],center=true);
                color(red)   translate([0,-0.29,0.75]) rotate([90,0,0]) cylinder(h=0.08,r=0.18);
                color(amber) translate([0,-0.29,0.00]) rotate([90,0,0]) cylinder(h=0.08,r=0.18);
                color(green) translate([0,-0.29,-0.75]) rotate([90,0,0]) cylinder(h=0.08,r=0.18);
            }
        }
    }
}

module signpost(x,y,txt="STOP",rot=0){
    color(dark)
        translate([x,y,base_h]) cylinder(h=3.5,r=0.09);

    color([0.90,0.90,0.90])
        translate([x,y,base_h+3.1])
        rotate([0,0,rot]) cube([1.7,0.12,1.0],center=true);
}

// base
color(grass) cube([site_w,site_d,base_h]);

// main east-west roadway
road(0,73,190,44);

// north-south roadway
road(73,0,44,190);

// sidewalks around corridors
slab(0,68,190,4);
slab(0,118,190,4);
slab(68,0,4,190);
slab(118,0,4,190);

// centerlines
stripe(0,94.0,73,0.18,yellow);
stripe(117,94.0,73,0.18,yellow);
stripe(0,95.0,73,0.18,yellow);
stripe(117,95.0,73,0.18,yellow);

stripe(94.0,0,0.18,73,yellow);
stripe(94.0,117,0.18,73,yellow);
stripe(95.0,0,0.18,73,yellow);
stripe(95.0,117,0.18,73,yellow);

// outer lane separators
stripe(0,83,73,0.15);
stripe(117,83,73,0.15);
stripe(0,106,73,0.15);
stripe(117,106,73,0.15);

stripe(83,0,0.15,73);
stripe(83,117,0.15,73);
stripe(106,0,0.15,73);
stripe(106,117,0.15,73);

// dedicated left-turn lane guides
stripe(54,88,19,0.18,white);
stripe(117,101,19,0.18,white);
stripe(88,54,0.18,19,white);
stripe(101,117,0.18,19,white);

// stop bars
stripe(68,86,5,0.55);
stripe(117,103,5,0.55);
stripe(86,68,0.55,5);
stripe(103,117,0.55,5);

// crosswalks - west/east
for(i=[0:6]){
    stripe(68+i*1.0,74,0.55,8);
    stripe(117+i*1.0,108,0.55,8);
}

// crosswalks - south/north
for(i=[0:6]){
    stripe(74,68+i*1.0,8,0.55);
    stripe(108,117+i*1.0,8,0.55);
}

// curb ramps
module ramp(x,y,rot=0){
    color(concrete)
        translate([x,y,base_h+0.46])
        rotate([0,0,rot])
        linear_extrude(height=0.18)
        polygon(points=[[0,0],[4,0],[4,3],[0,2.1]]);
}

ramp(66,66,0);
ramp(120,66,90);
ramp(66,120,270);
ramp(120,120,180);

// traffic signals
signal_pole(64,64,0);
signal_pole(126,64,90);
signal_pole(126,126,180);
signal_pole(64,126,270);

// drainage inlets
for(p=[[66,78,0],[66,112,0],[124,78,0],[124,112,0],
       [78,66,90],[112,66,90],[78,124,90],[112,124,90]])
    inlet(p[0],p[1],p[2]);

// street signs / stop signs at corners
signpost(60,70,"STOP",0);
signpost(130,70,"STOP",90);
signpost(130,120,"STOP",180);
signpost(60,120,"STOP",270);

// landscaped corner areas
for(p=[[35,35],[155,35],[35,155],[155,155],
       [20,50],[170,50],[20,140],[170,140],
       [50,20],[140,20],[50,170],[140,170]])
    tree(p[0],p[1],0.9);

// sample vehicles
car(42,84,0,[0.70,0.18,0.15]);
car(145,106,180,[0.20,0.35,0.72]);
car(84,40,90,[0.24,0.52,0.29]);
car(106,145,270,[0.72,0.72,0.75]);
car(58,101,0,[0.55,0.25,0.64]);
car(101,58,90,[0.80,0.48,0.12]);

// north arrow
translate([172,160,base_h+0.55]){
    color(dark)
        linear_extrude(height=0.16)
        polygon(points=[[0,12],[-2.5,4.2],[0,5.7],[2.5,4.2]]);
}

// labels
module label(txt,x,y,size=3.0,rot=0){
    color([0.03,0.03,0.03])
        translate([x,y,base_h+0.58])
        rotate([0,0,rot])
        linear_extrude(height=0.12)
        text(txt,size=size,halign="center",valign="center");
}

label("ROADWAY / INTERSECTION DESIGN",95,184,5.0);
label("LEFT TURN LANE",48,90,2.2);
label("LEFT TURN LANE",142,100,2.2);
label("LEFT TURN LANE",90,47,2.2,90);
label("LEFT TURN LANE",100,142,2.2,90);
