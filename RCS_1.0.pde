// SERIAL
import processing.serial.*; //This allows us to use serial objects

Serial port; // Create object from Serial class
int val; // Data received from the serial port

// BUTTONZ 
int rectSTPX, rectSTPY;      // Position of square button
int rectPLYX, rectPLYY; 
int rectRECX, rectRECY; 
int rectFWDX, rectFWDY;
int rectRWDX, rectRWDY; 
int rectEDIX, rectEDIY; 
int zhora;

int rectSize = 130;     // Diameter of rect
color rectSTPColor, rectPLYColor, rectRECColor, rectFWDColor, rectRWDColor, rectEDIColor, baseColor;
color rectSTPli, rectPLYli, rectRECli, rectFWDli, rectRWDli, rectEDIli;
boolean rectSTPov = false;
boolean rectPLYov = false;
boolean rectRECov = false;
boolean rectFWDov = false;
boolean rectRWDov = false;
boolean rectEDIov = false;

void setup() {
  // Serial
  println(Serial.list()); //This shows the various serial port options
  String portName = Serial.list()[10]; //The serial port should match the one the Arduino is hooked to
  port = new Serial(this, portName, 9600); //Establish the connection rate
  // BUTT
  size(850, 175);
  background(0);
  textSize(24);
  text("STUDER A820MCH serial remote controller", 15, 26);
  zhora = 35;
     
  rectSTPColor = color(150, 150, 150, 200);
  rectPLYColor = color(0, 150, 90);
  rectRECColor = color(180, 0, 0);
  rectFWDColor = color(50);
  rectRWDColor = color(50);
  rectEDIColor = color(50);
 
  rectSTPli = color(90, 90, 90, 200);
  rectPLYli = color(0, 70, 30);
  rectRECli = color(100, 0, 0);
  rectFWDli = color(50);
  rectRWDli = color(50);
  rectEDIli = color(50);
 
  rectSTPX = 10;
  rectSTPY = zhora;
  
  rectPLYX = 2*10+130;
  rectPLYY = zhora;
  
  rectRECX = 3*10+2*130;
  rectRECY = zhora; 
  
  rectFWDX = 4*10+3*130;
  rectFWDY = zhora; 

  rectRWDX = 5*10+4*130;
  rectRWDY = zhora; 

  rectEDIX = 6*10+5*130;
  rectEDIY = zhora; 
 
  rectMode(CORNER); 
}


void draw() {
  update(mouseX, mouseY);
// STOP button state
  if (rectSTPov) {
    fill(rectSTPli);
  } 
  else {
    fill(rectSTPColor);
}
  stroke(255);
  rect(rectSTPX, rectSTPY, rectSize, rectSize);

// PLAY button state
  if (rectPLYov) {
    fill(rectPLYli);
  } 
  else {
    fill(rectPLYColor);
  }
  stroke(255);
  rect(rectPLYX, rectPLYY, rectSize, rectSize);

// RECORD button state
   if (rectRECov) {
    fill(rectRECli);
  } 
  else {
    fill(rectRECColor);
  }
  stroke(255);
  rect(rectRECX, rectRECY, rectSize, rectSize);
  
// FWD button state
   if (rectFWDov) {
    fill(rectFWDli);
  } 
  else {
    fill(rectFWDColor);
  }
  stroke(255);
  rect(rectFWDX, rectFWDY, rectSize, rectSize);
  
// RWD button state
   if (rectRWDov) {
    fill(rectRWDli);
  } 
  else {
    fill(rectRWDColor);
  }
  stroke(255);
  rect(rectRWDX, rectRWDY, rectSize, rectSize);
  
// EDI button state
   if (rectEDIov) {
    fill(rectEDIli);
  } 
  else {
    fill(rectEDIColor);
  }
  stroke(255);
  rect(rectEDIX, rectEDIY, rectSize, rectSize);
  
}

  
void update(int x, int y) {
 if( overRect(rectSTPX, rectSTPY, rectSize, rectSize) ) {
    rectSTPov = true;
    rectPLYov = false;
    rectRECov = false;
  } else if ( overRect(rectPLYX, rectPLYY, rectSize, rectSize) ) {
    rectPLYov = true;
    rectSTPov = false;
    rectRECov = false;
  } else if ( overRect(rectRECX, rectRECY, rectSize, rectSize) ) {
    rectRECov = true;
    rectSTPov = false;
    rectPLYov = false;
  } else {
    rectPLYov = rectSTPov = rectRECov = false;
  }
}

void mousePressed() {
  if (rectSTPov) {
    port.write('S');
    port.write('T'); 
    port.write('P'); 
    port.write(13); 
  }
  if (rectPLYov) {
    port.write("STP" + 13);
  }
   if (rectRECov) {
    port.write("REC" + 13);
  }
}

boolean overRect(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && 
    mouseY >= y && mouseY <= y+height) {
    return true;
  } 
  else {
    return false;
  }
}


