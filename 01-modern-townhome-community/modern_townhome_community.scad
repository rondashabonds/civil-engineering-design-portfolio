
// ---------- CAMERA ANIMATION ----------
$vpr = [58, 0, 360*$t];
$vpt = [125, 95, 0];
$vpd = 285;


/*
  MODERN TOWNHOME COMMUNITY
  Pure OpenSCAD Conceptual Civil / Site Design
  Portfolio / Educational Project — Not for Construction
*/

$fn = 40;

// ---------- SITE ----------
site_w = 250;
site_d = 190;
base_h = 1.0;

grass    = [0.35,0.58,0.33];
asphalt  = [0.16,0.16,0.17];
concrete = [0.74,0.74,0.72];
white    = [0.96,0.96,0.96];
yellow   = [0.95,0.78,0.10];
dark     = [0.18,0.19,0.21];
warm     = [0.76,0.69,0.60];
wood     = [0.52,0.34,0.20];
glass    = [0.22,0.52,0.68,0.70];
water    = [0.20,0.60,0.84,0.75];
mulch    = [0.33,0.22,0.14];
green    = [0.18,0.48,0.22];

module road(x,y,w,d){
    color(asphalt) translate([x,y,base_h]) cube([w,d,0.45]);
}

module slab(x,y,w,d,h=0.25){
    color(concrete) translate([x,y,base_h+0.45]) cube([w,d,h]);
}

module stripe(x,y,w,d,c=white){
    color(c) translate([x,y,base_h+0.50]) cube([w,d,0.07]);
}

module planter(x,y,w,d){
    color(mulch) translate([x,y,base_h+0.45]) cube([w,d,0.18]);
}

module tree(x,y,s=1){
    color([0.34,0.22,0.12])
        translate([x,y,base_h]) cylinder(h=4.0*s,r=0.35*s);
    color(green)
        translate([x,y,base_h+4.4*s]) sphere(r=1.9*s);
}

module lightpole(x,y){
    color(dark)
        translate([x,y,base_h]) cylinder(h=7.5,r=0.14);
    color([0.85,0.84,0.74])
        translate([x+0.45,y,base_h+7.25]) cube([0.9,0.35,0.18],center=true);
}

module car(x,y,rot=0,c=[0.65,0.20,0.16]){
    translate([x,y,base_h+0.85]) rotate([0,0,rot]){
        color(c) cube([4.3,1.9,1.0],center=true);
        color([0.22,0.28,0.34])
            translate([0,0,0.65]) cube([2.4,1.45,0.5],center=true);
    }
}

// ---------- MODERN TOWNHOME ----------
module townhome_unit(x,y,w=8,d=13,h=9.5,rot=0,mirror_front=false){
    translate([x,y,base_h]) rotate([0,0,rot]){
        // main body
        color(warm) cube([w,d,h]);

        // dark vertical accent
        color(dark)
            translate([w*0.58,-0.15,0]) cube([w*0.25,0.35,h+0.4]);

        // rooftop parapet
        color(dark)
            translate([-0.2,-0.2,h]) cube([w+0.4,d+0.4,0.45]);

        // large front glazing
        color(glass)
            translate([0.8,-0.08,1.2]) cube([2.3,0.15,2.5]);

        color(glass)
            translate([0.8,-0.08,5.1]) cube([2.8,0.15,2.2]);

        // garage
        color([0.48,0.49,0.50])
            translate([w-3.2,-0.10,0.5]) cube([2.5,0.16,2.3]);

        // entry canopy
        color(wood)
            translate([0.4,-1.4,3.2]) cube([3.2,1.4,0.28]);

        // projecting upper balcony
        color(concrete)
            translate([0.4,-1.5,4.7]) cube([3.8,1.5,0.22]);

        // balcony glass rail
        color(glass)
            translate([0.4,-1.53,4.9]) cube([3.8,0.10,1.0]);

        // rooftop terrace rail
        color(glass){
            translate([0.4,0.5,h+0.45]) cube([w-0.8,0.10,1.0]);
            translate([0.4,d-0.6,h+0.45]) cube([w-0.8,0.10,1.0]);
            translate([0.4,0.5,h+0.45]) cube([0.10,d-1.1,1.0]);
            translate([w-0.5,0.5,h+0.45]) cube([0.10,d-1.1,1.0]);
        }

        // rooftop pergola
        color(wood){
            for(px=[1.0,w-1.4])
                for(py=[2.0,d-2.4])
                    translate([px,py,h+0.45]) cube([0.35,0.35,2.2]);

            for(i=[0:3])
                translate([0.9+i*(w-1.8)/3,2.0,h+2.35])
                    cube([0.25,d-4.0,0.20]);
        }
    }
}

module townhome_row(x,y,units=5,gap=0.4,rot=0){
    for(i=[0:units-1])
        townhome_unit(x+i*(8+gap),y,8,13,9.5,rot);
}

// ---------- AMENITIES ----------
module clubhouse(x,y){
    translate([x,y,base_h]){
        color([0.82,0.80,0.75]) cube([34,18,5.5]);
        color(dark) translate([0,0,5.5]) cube([34,18,0.5]);
        color(glass) translate([4,-0.10,1]) cube([26,0.18,3.4]);
        color(wood) translate([8,-2.2,3.8]) cube([18,2.2,0.3]);
    }
}

module pool_area(x,y){
    color([0.82,0.78,0.70])
        translate([x,y,base_h+0.45]) cube([38,24,0.25]);

    color(water)
        translate([x+6,y+5,base_h+0.72]) cube([26,12,0.35]);

    for(i=[0:3])
        color(white)
            translate([x+5+i*8,y+19,base_h+0.78]) cube([4.5,1.1,0.18]);
}

module dog_park(x,y,w=26,d=18){
    color([0.28,0.56,0.25])
        translate([x,y,base_h+0.47]) cube([w,d,0.12]);

    color(dark){
        translate([x,y,base_h+0.5]) cube([w,0.12,1.3]);
        translate([x,y+d,base_h+0.5]) cube([w,0.12,1.3]);
        translate([x,y,base_h+0.5]) cube([0.12,d,1.3]);
        translate([x+w,y,base_h+0.5]) cube([0.12,d,1.3]);
    }
}

module monument(x,y){
    color(dark)
        translate([x,y,base_h]) cube([15,1.8,4.2]);
    color(wood)
        translate([x+1.0,y-0.10,base_h+0.8]) cube([13,0.16,2.2]);
}

// ---------- BASE ----------
color(grass) cube([site_w,site_d,base_h]);

// public road
road(0,0,site_w,22);
stripe(0,10.2,site_w,0.22,yellow);
stripe(0,11.0,site_w,0.22,yellow);

// entrance
road(104,22,42,50);
stripe(124.5,22,0.20,50,yellow);
stripe(125.3,22,0.20,50,yellow);

// entry sidewalks
slab(98,22,4,50);
slab(148,22,4,50);

// landscaped median
planter(121,28,8,34);
for(y=[33:9:58]) tree(125,y,0.8);

// internal streets
road(24,70,202,18);
road(24,88,18,66);
road(208,88,18,66);
road(24,154,202,18);

road(85,88,18,66);
road(147,88,18,66);

// sidewalks
slab(24,66,202,3);
slab(24,89,202,3);
slab(20,88,3,66);
slab(43,88,3,66);
slab(81,88,3,66);
slab(104,88,3,66);
slab(143,88,3,66);
slab(166,88,3,66);
slab(204,88,3,66);
slab(227,88,3,66);

// ---------- TOWNHOME ROWS ----------
townhome_row(6,103,5);
townhome_row(48,103,4);
townhome_row(110,103,4);
townhome_row(172,103,5);

townhome_row(6,35,5);
townhome_row(172,35,5);

// private driveways
for(x=[8:8.4:42])
    slab(x,92,4.8,10);

for(x=[50:8.4:75])
    slab(x,92,4.8,10);

for(x=[112:8.4:137])
    slab(x,92,4.8,10);

for(x=[174:8.4:208])
    slab(x,92,4.8,10);

// ---------- CENTRAL AMENITY ----------
clubhouse(108,95);
pool_area(106,122);
dog_park(53,123,24,17);

// ---------- GUEST PARKING ----------
road(76,73,98,12);
for(i=[0:20])
    stripe(78+i*4.5,74,0.10,10);

car(82,79,0,[0.70,0.18,0.16]);
car(96,79,0,[0.20,0.35,0.72]);
car(118,79,0,[0.22,0.55,0.30]);
car(141,79,0,[0.70,0.70,0.74]);
car(161,79,0,[0.55,0.25,0.65]);

// ---------- LANDSCAPING ----------
for(p=[
    [8,28],[30,28],[55,28],[78,28],[170,28],[193,28],[218,28],[240,28],
    [12,63],[57,63],[190,63],[236,63],
    [12,178],[47,178],[82,178],[120,178],[160,178],[198,178],[235,178]
]) tree(p[0],p[1]);

for(p=[
    [33,80],[63,80],[95,80],[126,80],[157,80],[190,80],[217,80],
    [33,163],[63,163],[95,163],[126,163],[157,163],[190,163],[217,163]
]) lightpole(p[0],p[1]);

// ---------- ENTRY MONUMENT ----------
monument(155,29);

// ---------- LABELS ----------
module label(txt,x,y,size=4,rot=0){
    color([0.04,0.04,0.04])
        translate([x,y,base_h+0.57])
        rotate([0,0,rot])
        linear_extrude(height=0.12)
        text(txt,size=size,halign="center",valign="center");
}

label("MODERN TOWNHOME COMMUNITY",125,184,6);
label("CLUBHOUSE",125,104,3);
label("POOL",125,135,3);
label("DOG PARK",65,132,3);
label("PUBLIC ROAD",125,7,4);
label("MAIN ENTRY",125,41,3,90);

// north arrow
translate([233,165,base_h+0.5]){
    color(dark)
        linear_extrude(height=0.18)
        polygon(points=[[0,13],[-2.8,4.5],[0,6],[2.8,4.5]]);
}
