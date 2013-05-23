import controlP5.*;
import processing.serial.*; //This allows us to use serial objects

Serial port; // Create object from Serial class
int val; // Data received from the serial port

ControlP5 cp5;
boolean PLY = false;
boolean STP = false;



void setup() {
// Serial
  println(Serial.list()); //This shows the various serial port options
  String portName = Serial.list()[10]; //The serial port should match the one the Arduino is hooked to
  port = new Serial(this, portName, 9600); //Establish the connection rate
// FIELD
  size(850, 175);
  background(0);
  textSize(18);
  text("STUDER A820MCH serial remote controller", 15, 26);
// BUTTONY
  cp5 = new ControlP5(this);
  
  PImage[] imgsPLY = {loadImage("ply_a.png"),loadImage("ply_b.png"),loadImage("ply_c.png")};
  cp5.addToggle("PLY")
     .setPosition(10,40)
     .setImages(imgsPLY)
     .setValue(false)
     .updateSize()
     ;
  PImage[] imgsSTP = {loadImage("stp_a.png"),loadImage("stp_b.png"), loadImage("stp_c.png")};   
  cp5.addToggle("STP")
     .setPosition(120,40)
     .setImages(imgsSTP)
     .setValue(false)
     .updateSize()
     ;

}

void draw() {
  if(PLY=false) {
    STP = true;
  }
  if(STP=false) {
    PLY = true;
  }
}

  

void mousePressed() {
  if (PLY) {
    port.write('P');
    port.write('L'); 
    port.write('Y'); 
    port.write(13);
    }
  if (STP) {
    port.write('S');
    port.write('T'); 
    port.write('P'); 
    port.write(13);
    }
}



