/* 

Customizable labels for card collections. These are meant to be attached to the sides of boxes to easily view what cards/sets are inside of the box.

Made by fellowapeman

https://www.printables.com/social/221869-fellowapeman/about


If you want to use MTG Set or Mana/Card Symbols:
    
    - Install MTG Set/Keyrune Fonts: https://keyrune.andrewgioia.com/
    - Install MTG Mana Symbol Fonts: https://mana.andrewgioia.com/
    
    ***IMPORTANT*** In Windows, OpenSCAD requires you to install fonts for ALL USERS in order to use them. Ensure you do this! Search google if you need help!

    After the font packs are installed for all users, input either "mana" or "keyrune" into the fontL or fontR parameters depending on which font you'd like to use. Then use andrewgioia's cheat sheets (see links below) to copy/paste the desired symbol into the textL or textR parameters.
    If everything was installed and configured properly, you should see the set symbols rendered in OpenSCAD!
    
    Cheat sheets can be found here:
    https://keyrune.andrewgioia.com/cheatsheet.html
    https://mana.andrewgioia.com/cheatsheet.html

*/

/* [Label Properties] */

// Width of cardboard box's sidewall. BCW boxes are ~10.5
width = 10.5;
// Width of faces
faceWidth = 12.1;
// Height of faces
faceHeight = 44.1;
// Thickness of label
thickness = 1.6;
// Text emboss thickness
textEmboss = 0.5;

/* [Text 1 Config] */
// Text1 field. If using "mana" or "keyrune" fonts, copy/paste the icon from the appropriate andrewgioia cheatsheet
text1 = "";
// Text1 font
font1 = "keyrune";
// Text1 font size
fontSize1 = 7.1;
// Text1 padding-left
paddingLeft1 = 2.1;
// Text1 padding-bottom
paddingBottom1 = 1.5;

/* [Text 2 Config] */
// Text2 field. If using "mana" or "keyrune" fonts, copy/paste the icon from the appropriate andrewgioia cheatsheet
text2 = "MIR";
// Text2 font
font2 = "Liberation Sans";
// Text2 font size
fontSize2 = 7.1;
// Text2 padding-left
paddingLeft2 = 14.1;
// Text2 padding-bottom
paddingBottom2 = 2.5;

// Fillet function
module fillet(r=1.0,steps=3,include=true) {
  if(include) for (k=[0:$children-1]) {
	children(k);
  }
  for (i=[0:$children-2] ) {
    for(j=[i+1:$children-1] ) {
	fillet_two(r=r,steps=steps) {
	  children(i);
	  children(j);
	  intersection() {
		children(i);
		children(j);
	  }
	}
    }
  }
}

module fillet_two(r=1.0,steps=3) {
  for(step=[1:steps]) {
	hull() {
	  render() intersection() {
		children(0);
		offset_3d(r=r*step/steps) children(2);
	  }
	  render() intersection() {
		children(1);
		offset_3d(r=r*(steps-step+1)/steps) children(2);
	  }
	}
  }
}

module offset_3d(r=1.0) {
  for(k=[0:$children-1]) minkowski() {
	children(k);
	sphere(r=r,$fn=8);
  }
}

module tabWidth() {
    cube([width,faceWidth,thickness]);
}

module tabBack() {
    translate([width,0,0]){
        cube([thickness,faceWidth,faceHeight]);
    }
}

module tabFront() {
    translate([-thickness,0,0]){                
        cube([thickness,faceWidth,faceHeight]);   
    }
}

module text1() {
    rotate([0,270,0]) {
        translate([paddingLeft1,paddingBottom1,thickness]){    
            linear_extrude(textEmboss) {
                text(text = str(text1), font = font1, size = fontSize1);
            }
        }
    }
}

module text2 () {
    rotate([0,270,0]) {
        translate([paddingLeft2,paddingBottom2,thickness]){
            linear_extrude(textEmboss) {
                text(text = str(text2), font = font2, size = fontSize2);
            }
        }
    }
}

fillet(r=thickness,steps=5) {
	tabWidth();
    tabFront();
}

fillet(r=thickness,steps=5) {
	tabWidth();
    tabBack();
}

text1();
text2();

