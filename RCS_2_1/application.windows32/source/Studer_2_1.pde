import controlP5.*;
import processing.serial.*; //This allows us to use serial objects

Serial port; // Create object from Serial class
int stav; // Data received from the serial port
int value;
float wind = 5000;
String whex = "0100";

ControlP5 cp5;
RadioButton r;
RadioButton s;
ListBox l;
Bang b;
Textfield ss;
Textarea myTextarea;
Println console;



void setup() {
  // Serial
//  println(Serial.list());
//  String portName = Serial.list()[i]; 
//  port = new Serial(this, portName, 9600);
  // FIELD
  size(670, 300);
  // BUTTONY
  /// POSUNY
  cp5 = new ControlP5(this);
  PFont p = createFont("Andale Mono", 30); 
  cp5.setControlFont(p);
  r = cp5.addRadioButton("posun")
    .setPosition(10, 25)
      .setSize(100, 100)
        .setColorForeground(color(120))
          .setColorBackground(color(255))
            .setColorActive(color(255, 240, 170))
              .setColorLabel(color(0))
                .setItemsPerRow(6)
                  .setSpacingColumn(10)
                    .setValue(3)
                      .addItem("REWD", 1)
                        .addItem("FOWD", 2)
                          .addItem("STOP", 3)
                            .addItem("PLAY", 4)
                              .addItem("RECO", 5)
                                .addItem("EDIT", 6)
                                  ;

  for (Toggle t:r.getItems()) {
    t.captionLabel().style().moveMargin(0, 0, 0, -90);
  }
  // RYCHLOST POSUNU PRI PLAZY
  cp5 = new ControlP5(this);  
  PFont sp = createFont("Verdena", 20); 
  cp5.setControlFont(sp);
  s = cp5.addRadioButton("speed")
    .setPosition(10, 135)
      .setSize(63, 63)
        .setColorForeground(color(120))
          .setColorBackground(color(255))
            .setColorActive(color(125, 210, 255))
              .setColorLabel(color(0))
                .setItemsPerRow(4)
                  .setSpacingColumn(10)
                    .addItem("3.75", 1)
                    .addItem("7.5", 2)
                      .addItem(" 15", 3)
                        .addItem(" 30", 4)
                          ;

  for (Toggle t:s.getItems()) {
    t.captionLabel().style().moveMargin(0, 0, 0, -55);
  }
  // WIND SPEED
  cp5 = new ControlP5(this);  
  PFont spd = createFont("Verdena", 10); 
  cp5.setControlFont(spd); 
  cp5.addSlider("spd")
    .setPosition(450, 135)
      .setSize(210, 20)
        .setRange(0, 24575)
          .setValue(1024)
            .setDecimalPrecision(0) 
              .setColorCaptionLabel(0) 
                .setColorValueLabel(255) 
                  .setColorForeground(color(230, 120, 255))
                    .setColorBackground(color(255))
                      .setColorActive(color(230, 50, 255))
                        .setColorLabel(color(0))
                          .setCaptionLabel("Wind spd")  
                            .setSliderMode(Slider.FLEXIBLE)
                              .captionLabel().style().moveMargin(0, 0, 0, -60)
                                ;
// KONZOLE
  cp5.enableShortcuts();
  frameRate(12);
  myTextarea = cp5.addTextarea("txt")
                  .setPosition(450, 195)
                  .setSize(210, 100)
                  .setFont(createFont("Andale Mono", 9))
                  .setLineHeight(12)
                  .setColor(color(1))
                  .setColorBackground(color(0, 100))
                  .setColorForeground(color(255, 100));
  ;
console = cp5.addConsole(myTextarea);
// BANG SERIALY
 b = cp5.addBang("srl bng")
     .setPosition(450, 165)
     .setSize(20,20)
     .setLabel("show serials")
     .setColorForeground(color(120))
          .setColorBackground(color(255))
            .setColorActive(color(255, 240, 170))
              .setColorLabel(color(0))
          ;
  for (Toggle t:s.getItems()) {
    b.captionLabel().style().moveMargin(-5, 0, 0, 6);
  }

// SERIAL PORTY
ss = cp5.addTextfield("input")
     .setPosition(560,165)
     .setSize(30,20)
     .setFocus(false)
     .setColor(color(10,0,0))
     .setLabel("com select")
     .setColorForeground(color(120))
          .setColorBackground(color(255))
            .setColorActive(color(255, 0, 0))
              .setColorLabel(color(0))
     ;
      for (Toggle t:s.getItems()) {
    ss.captionLabel().style().moveMargin(-5, 0, 0, 9);
  }

}



void draw() { 
  background(180); 
  textSize(18);
  text("STUDER A820MCH serial remote controller", 12, 18);
  textSize(10);
  text("made by David Śmitmajer", 533, 18);
}

public void input(String theText) {
  println("COM selected: "+theText);
  int tty = int(theText);
  String portName = Serial.list()[tty]; 
  port = new Serial(this, portName, 9600);
}

void keyPressed() {
  switch(key) {
    case('q'): 
    r.deactivateAll(); 
    break;
    case('j'): 
    r.activate(0); 
    break;
    case('l'): 
    r.activate(1); 
    break;
    case('k'): 
    r.activate(2); 
    break;
    case('p'): 
    r.activate(3); 
    break;
    case('r'): 
    r.activate(4); 
    break;
    case('e'): 
    r.activate(5); 
    break;
  }
}

//println(hex(c, 6))

void controlEvent(ControlEvent theEvent) {
  if (theEvent.getName()=="spd") { 
    int windi  = int(wind);
    wind = theEvent.getValue();
    whex = (hex(windi, 4));
    println(whex);
  }
  
   if(theEvent.isGroup() && theEvent.name().equals("srl")){
    int test = (int)theEvent.group().value();
    println("serial COM"+test);
}

  if (theEvent.getValue()==1 && theEvent.getName()=="srl bng") { 
      println(Serial.list());
  } 

  if (theEvent.getValue()==-1 && theEvent.getName()=="posun") { 
    port.write('S');
    port.write('T'); 
    port.write('P'); 
    port.write(13);
    println("STOP");
  } 
  if (theEvent.getValue()==1 && theEvent.getName()=="posun") { 
    port.write('R');
    port.write('W'); 
    port.write('D'); 
    port.write(13);
    println("REWIND");
  }
  if (theEvent.getValue()==2 && theEvent.getName()=="posun") { 
    port.write('F');
    port.write('W'); 
    port.write('D'); 
    port.write(13);
    println("FOREWIND");
  }
  if (theEvent.getValue()==3 && theEvent.getName()=="posun") { 
    port.write('S');
    port.write('T'); 
    port.write('P'); 
    port.write(13);
    println("STOP");
  }
  if (theEvent.getValue()==4 && theEvent.getName()=="posun") { 
    port.write('P');
    port.write('L'); 
    port.write('Y'); 
    port.write(13);
    println("PLAY");
  }
  if (theEvent.getValue()==5 && theEvent.getName()=="posun") { 
    port.write('R');
    port.write('E'); 
    port.write('C'); 
    port.write(13);
    println("RECORD");
  }
  if (theEvent.getValue()==6 && theEvent.getName()=="posun") { 
    port.write('E');
    port.write('D'); 
    port.write('I'); 
    port.write(13);
    println("EDIT");
  }
  if (theEvent.getValue()==1 && theEvent.getName()=="speed") { 
    port.write('S');
    port.write('S'); 
    port.write('A'); 
    port.write(13);
    println("SPEED: 3.75 IPS");
  } 
  if (theEvent.getValue()==2 && theEvent.getName()=="speed") { 
    port.write('S');
    port.write('S'); 
    port.write('B'); 
    port.write(13);
    println("SPEED: 7.5 IPS");
  }
  if (theEvent.getValue()==3 && theEvent.getName()=="speed") { 
    port.write('S');
    port.write('S'); 
    port.write('C'); 
    port.write(13);
    println("SPEED: 15 IPS");
  }
  if (theEvent.getValue()==4 && theEvent.getName()=="speed") { 
    port.write('S');
    port.write('S'); 
    port.write('D'); 
    port.write(13);
    println("SPEED: 30 IPS");
  }
}

