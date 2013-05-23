import controlP5.*;
import processing.serial.*; //This allows us to use serial objects

Serial port; // Create object from Serial class
int stav; // Data received from the serial port
int value;
int i;
float wind = 5000;
float windv = 0;
String whex = "0100";
boolean rxon = false;
int lf = 13; 
String serialR = null;
int chx = 10;
int chy = 245;
int spcRow = 10;

ControlP5 cp5;
RadioButton r;
RadioButton s;
ListBox l;
Bang b;
Textfield ss;
Toggle bb;
Textarea myTextarea;
Println console;



void setup() {
  // Serial
   //  println(Serial.list());
  //String portName = Serial.list()[8]; 
  //port = new Serial(this,Serial.list()[i], 9600);
  // FIELD
  size(670, 520);
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
  // RYCHLOST POSUNU PRI PLAY
  cp5 = new ControlP5(this);  
  PFont sp = createFont("Verdena", 16); 
  cp5.setControlFont(sp);
  s = cp5.addRadioButton("speed")
    .setPosition(10, 135)
      .setSize(45, 45)
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
    t.captionLabel().style().moveMargin(0, 0, 0, -42);
  }
  
 // EQUALISATION
  cp5 = new ControlP5(this);  
  PFont eq = createFont("Andale Mono", 16); 
  cp5.setControlFont(eq);
  s = cp5.addRadioButton("equalisation")
    .setPosition(10, 190)
      .setSize(45, 45)
        .setColorForeground(color(120))
          .setColorBackground(color(255))
            .setColorActive(color(255, 190, 70))
              .setColorLabel(color(0))
                .setItemsPerRow(2)
                  .setSpacingColumn(10)
                    .addItem("ICE", 1)
                      .addItem("NAB", 2)
                            ;
  for (Toggle t:s.getItems()) {
    t.captionLabel().style().moveMargin(2, 0, 0, -41);
  }

  // WIND SPEED
  cp5 = new ControlP5(this);  
  PFont spd = createFont("Andale Mono", 10); 
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
  // VARI SPEED
  cp5 = new ControlP5(this);  
  PFont svp = createFont("Andale Mono", 10); 
  cp5.setControlFont(svp); 
  cp5.addSlider("svp")
    .setPosition(450, 160)
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
                          .setCaptionLabel("vari spd")  
                            .setSliderMode(Slider.FLEXIBLE)
                              .captionLabel().style().moveMargin(0, 0, 0, -60)
                                ;

  // ZLO
  cp5 = new ControlP5(this);  
  PFont zlo = createFont("Andale Mono", 16); 
  cp5.setControlFont(zlo);
  cp5.addBang("zloc")
    .setPosition(230, 135)
      .setSize(45, 45)
        .setColorForeground(color(255))
          .setColorActive(color(255, 140, 140))
            .setColorLabel(color(0))
              .captionLabel().style().moveMargin(-35, 0, 0, 3)
                ;
  // RESET TIMER
  cp5 = new ControlP5(this);  
  PFont rti = createFont("Andale Mono", 10); 
  cp5.setControlFont(rti);
  cp5.addBang("rti")
    .setPosition(285, 135)
      .setSize(45, 45)
        .setLabel("resett")
          .setColorForeground(color(255))
            .setColorActive(color(255, 140, 140))
              .setColorLabel(color(0))
                .captionLabel().style().moveMargin(-33, 0, 0, 4)
                  ;

  //DISPLAY TIME
  cp5 = new ControlP5(this);  
  PFont dst = createFont("Andale Mono", 14); 
  cp5.setControlFont(dst);
  cp5.addBang("dst")
    .setPosition(450, 245)
      .setSize(20, 20)
        .setLabel("timecode?")
          .setColorForeground(color(255))
            .setColorActive(color(255, 140, 140))
              .setColorLabel(color(0))
                .captionLabel().style().moveMargin(-22, 0, 0, 25)
                  ;
 // EQ NORM
  cp5 = new ControlP5(this);  
  PFont eqn = createFont("Andale Mono", 14); 
  cp5.setControlFont(eqn);
  cp5.addBang("eqn")
    .setPosition(570, 245)
      .setSize(20, 20)
        .setLabel("eqnorm?")
          .setColorForeground(color(255))
            .setColorActive(color(255, 140, 140))
              .setColorLabel(color(0))
                .captionLabel().style().moveMargin(-22, 0, 0, 25)
                  ;                  
//DISPLAY NOMINAL SPEED
  cp5 = new ControlP5(this);  
  PFont nspd = createFont("Andale Mono", 14); 
  cp5.setControlFont(nspd);
  cp5.addBang("nspd")
    .setPosition(450, 270)
      .setSize(20, 20)
        .setLabel("nspeed?")
          .setColorForeground(color(255))
            .setColorActive(color(255, 140, 140))
              .setColorLabel(color(0))
                .captionLabel().style().moveMargin(-22, 0, 0, 25)
                  ;   
//DISPLAY VARI SPEED
  cp5 = new ControlP5(this);  
  PFont vspd = createFont("Andale Mono", 14); 
  cp5.setControlFont(nspd);
  cp5.addBang("vspd")
    .setPosition(570, 270)
      .setSize(20, 20)
        .setLabel("vspeed?")
          .setColorForeground(color(255))
            .setColorActive(color(255, 140, 140))
              .setColorLabel(color(0))
                .captionLabel().style().moveMargin(-22, 0, 0, 25)
                  ;   
                  
  // REVERSE PLAY
  cp5 = new ControlP5(this);  
  PFont rpl = createFont("Andale Mono", 16); 
  cp5.setControlFont(rpl);
  cp5.addBang("rpl")
    .setPosition(340, 135)
      .setSize(100, 45)
        .setLabel("rvrs play")
          .setColorForeground(color(255))
            .setColorActive(color(255, 140, 140))
              .setColorLabel(color(0))
                .captionLabel().style().moveMargin(-35, 0, 0, 5)
                  ;

 // KONZOLE
  cp5.enableShortcuts();
  frameRate(12);
  myTextarea = cp5.addTextarea("txt")
    .setPosition(450, 380)
      .setSize(210, 130)
        .setFont(createFont("Andale Mono", 9))
          .setLineHeight(12)
            .setColor(color(1))
              .setColorBackground(color(0, 100))
                .setColorForeground(color(255, 100))
                  ;
  console = cp5.addConsole(myTextarea);

  // PRINT COMS
  cp5 = new ControlP5(this);  
  cp5.addBang("srl bng")
    .setPosition(450, 355)
      .setSize(10, 10)
        .setLabel("print coms")
          .setColorForeground(color(120))
            .setColorBackground(color(255))
              .setColorActive(color(255, 240, 170))
                .setColorLabel(color(0))
                  .captionLabel().style().moveMargin(-13, 0, 0, 13)
                    ;

  // COM SELECT
  cp5.addTextfield("input")
    .setPosition(525, 355)
      .setSize(25, 20)
        .setFocus(false)
          .setColor(color(10, 0, 0))
            .setLabel("com select")
              .setColorForeground(color(120))
                .setColorBackground(color(255))
                  .setColorActive(color(255, 0, 0))
                    .setColorLabel(color(0))
                      .captionLabel().style().moveMargin(-18, 0, 0, 30)
                        ;

  // SERIAL READ RXON
  cp5.addToggle("rxon")
    .setValue(false)
      .setPosition(610, 355)
        .setSize(20, 20)
          .setColorForeground(color(120))
            .setColorBackground(color(255))
              .setColorActive(color(170, 0, 0))
                .setColorLabel(color(0))
                  .captionLabel().style().moveMargin(-18, 0, 0, 25)
                    ;
                    
  // CH STATUT
  cp5.addBang("CH statut")
      .setPosition(460, 365)
        .setSize(10, 10)
          .setColorForeground(color(20, 0, 120))
            .setColorBackground(color(20))
              .setColorActive(color(170, 0, 0))
                .setColorLabel(color(0))
                  .captionLabel().style().moveMargin(-13, 0, 0, 13)
                    ;


/// CH SELEKTORY                
  cp5 = new ControlP5(this);  
  PFont ch1 = createFont("Andale Mono", 20  ); 
  cp5.setControlFont(ch1);
  s = cp5.addRadioButton("chanel")
    .setPosition(chx,chy)
      .setSize(45, 45)
        .setColorForeground(color(100, 150, 100))
          .setColorBackground(color(220, 240, 220))
            .setColorActive(color(60, 240, 60))
              .setColorLabel(color(0))
                .setItemsPerRow(1)
                  .setSpacingRow(spcRow)
                    .addItem("RD1", 1)
                      .addItem("SF1", 2)
                            ;
                              for (Toggle t:s.getItems()) {
                              t.captionLabel().style().moveMargin(0, 0, 0, -44);
                              }
  cp5 = new ControlP5(this);  
  PFont ch2 = createFont("Andale Mono", 20  ); 
  cp5.setControlFont(ch2);
  s = cp5.addRadioButton("chanel")
    .setPosition(chx+55,chy)
      .setSize(45, 45)
        .setColorForeground(color(100, 150, 100))
          .setColorBackground(color(220, 240, 220))
            .setColorActive(color(60, 240, 60))
              .setColorLabel(color(0))
                .setItemsPerRow(1)
                  .setSpacingRow(spcRow)
                    .addItem("RD2", 1)
                      .addItem("SF2", 2)
                            ;                         
                             for (Toggle t:s.getItems()) {
                             t.captionLabel().style().moveMargin(0, 0, 0, -44);
                             }
 cp5 = new ControlP5(this);  
  PFont ch3 = createFont("Andale Mono", 20  ); 
  cp5.setControlFont(ch3);
  s = cp5.addRadioButton("chanel")
    .setPosition(chx+110,chy)
      .setSize(45, 45)
        .setColorForeground(color(100, 150, 100))
          .setColorBackground(color(220, 240, 220))
            .setColorActive(color(60, 240, 60))
              .setColorLabel(color(0))
                .setItemsPerRow(1)
                  .setSpacingRow(spcRow)
                    .addItem("RD3", 1)
                      .addItem("SF3", 2)
                            ;                         
                             for (Toggle t:s.getItems()) {
                             t.captionLabel().style().moveMargin(0, 0, 0, -44);
                             }                           
 cp5 = new ControlP5(this);  
  PFont ch4 = createFont("Andale Mono", 20  ); 
  cp5.setControlFont(ch4);
  s = cp5.addRadioButton("chanel")
    .setPosition(chx+165,chy)
      .setSize(45, 45)
        .setColorForeground(color(100, 150, 100))
          .setColorBackground(color(220, 240, 220))
            .setColorActive(color(60, 240, 60))
              .setColorLabel(color(0))
                .setItemsPerRow(1)
                  .setSpacingRow(spcRow)
                    .addItem("RD4", 1)
                      .addItem("SF4", 2)
                            ;                         
                             for (Toggle t:s.getItems()) {
                             t.captionLabel().style().moveMargin(0, 0, 0, -44);
                             }
 cp5 = new ControlP5(this);  
  PFont ch5 = createFont("Andale Mono", 20  ); 
  cp5.setControlFont(ch5);
  s = cp5.addRadioButton("chanel")
    .setPosition(chx+220,chy)
      .setSize(45, 45)
        .setColorForeground(color(100, 150, 100))
          .setColorBackground(color(220, 240, 220))
            .setColorActive(color(60, 240, 60))
              .setColorLabel(color(0))
                .setItemsPerRow(1)
                  .setSpacingRow(spcRow)
                    .addItem("RD5", 1)
                      .addItem("SF5", 2)
                            ;                         
                             for (Toggle t:s.getItems()) {
                             t.captionLabel().style().moveMargin(0, 0, 0, -44);
                             }
                             
 cp5 = new ControlP5(this);  
  PFont ch6 = createFont("Andale Mono", 20  ); 
  cp5.setControlFont(ch6);
  s = cp5.addRadioButton("chanel")
    .setPosition(chx+275,chy)
      .setSize(45, 45)
        .setColorForeground(color(100, 150, 100))
          .setColorBackground(color(220, 240, 220))
            .setColorActive(color(60, 240, 60))
              .setColorLabel(color(0))
                .setItemsPerRow(1)
                  .setSpacingRow(spcRow)
                    .addItem("RD6", 1)
                      .addItem("SF6", 2)
                            ;                         
                             for (Toggle t:s.getItems()) {
                             t.captionLabel().style().moveMargin(0, 0, 0, -44);
                             }
 cp5 = new ControlP5(this);  
  PFont ch7 = createFont("Andale Mono", 20  ); 
  cp5.setControlFont(ch7);
  s = cp5.addRadioButton("chanel")
    .setPosition(chx+330,chy)
      .setSize(45, 45)
        .setColorForeground(color(100, 150, 100))
          .setColorBackground(color(220, 240, 220))
            .setColorActive(color(60, 240, 60))
              .setColorLabel(color(0))
                .setItemsPerRow(1)
                  .setSpacingRow(spcRow)
                    .addItem("RD7", 1)
                      .addItem("SF7", 2)
                            ;                         
                             for (Toggle t:s.getItems()) {
                             t.captionLabel().style().moveMargin(0, 0, 0, -44);
                             }
 cp5 = new ControlP5(this);  
  PFont ch8 = createFont("Andale Mono", 20  ); 
  cp5.setControlFont(ch8);
  s = cp5.addRadioButton("chanel")
    .setPosition(chx+385,chy)
      .setSize(45, 45)
        .setColorForeground(color(100, 150, 100))
          .setColorBackground(color(220, 240, 220))
            .setColorActive(color(60, 240, 60))
              .setColorLabel(color(0))
                .setItemsPerRow(1)
                  .setSpacingRow(spcRow)
                    .addItem("RD8", 1)
                      .addItem("SF8", 2)
                            ;                         
                             for (Toggle t:s.getItems()) {
                             t.captionLabel().style().moveMargin(0, 0, 0, -44);
                             }
                             
/// INPUT SZYNC REPRO
cp5 = new ControlP5(this);  
  PFont rpr1 = createFont("Andale Mono", 15  ); 
  cp5.setControlFont(rpr1);
  s = cp5.addRadioButton("repro")
    .setPosition(chx,chy+110)
      .setSize(45, 45)
        .setColorForeground(color(160, 100, 100))
          .setColorBackground(color(230, 200, 200))
            .setColorActive(color(200, 60, 60))
              .setColorLabel(color(0))
                .setItemsPerRow(1)
                  .setSpacingRow(spcRow)
                    .addItem("INPT", 1)
                      .addItem("SYNC", 2)
                       .addItem("REPR", 3)
                            ;                         
                             for (Toggle t:s.getItems()) {
                             t.captionLabel().style().moveMargin(0, 0, 0, -44);
                             }
cp5 = new ControlP5(this);  
  PFont rpr2 = createFont("Andale Mono", 15  ); 
  cp5.setControlFont(rpr2);
  s = cp5.addRadioButton("repro")
    .setPosition(chx+55,chy+110)
      .setSize(45, 45)
        .setColorForeground(color(160, 100, 100))
          .setColorBackground(color(230, 200, 200))
            .setColorActive(color(200, 60, 60))
              .setColorLabel(color(0))
                .setItemsPerRow(1)
                  .setSpacingRow(spcRow)
                    .addItem("INPT", 1)
                      .addItem("SYNC", 2)
                       .addItem("REPR", 3)
                            ;                         
                             for (Toggle t:s.getItems()) {
                             t.captionLabel().style().moveMargin(0, 0, 0, -44);
                             }
cp5 = new ControlP5(this);  
  PFont rpr3 = createFont("Andale Mono", 15  ); 
  cp5.setControlFont(rpr3);
  s = cp5.addRadioButton("repro")
    .setPosition(chx+110,chy+110)
      .setSize(45, 45)
        .setColorForeground(color(160, 100, 100))
          .setColorBackground(color(230, 200, 200))
            .setColorActive(color(200, 60, 60))
              .setColorLabel(color(0))
                .setItemsPerRow(1)
                  .setSpacingRow(spcRow)
                    .addItem("INPT", 1)
                      .addItem("SYNC", 2)
                       .addItem("REPR", 3)
                            ;                         
                             for (Toggle t:s.getItems()) {
                             t.captionLabel().style().moveMargin(0, 0, 0, -44);
                             }                             
cp5 = new ControlP5(this);  
  PFont rpr4 = createFont("Andale Mono", 15  ); 
  cp5.setControlFont(rpr4);
  s = cp5.addRadioButton("repro")
    .setPosition(chx+165,chy+110)
      .setSize(45, 45)
        .setColorForeground(color(160, 100, 100))
          .setColorBackground(color(230, 200, 200))
            .setColorActive(color(200, 60, 60))
              .setColorLabel(color(0))
                .setItemsPerRow(1)
                  .setSpacingRow(spcRow)
                    .addItem("INPT", 1)
                      .addItem("SYNC", 2)
                       .addItem("REPR", 3)
                            ;                         
                             for (Toggle t:s.getItems()) {
                             t.captionLabel().style().moveMargin(0, 0, 0, -44);
                             }
cp5 = new ControlP5(this);  
  PFont rpr5 = createFont("Andale Mono", 15  ); 
  cp5.setControlFont(rpr5);
  s = cp5.addRadioButton("repro")
    .setPosition(chx+220,chy+110)
      .setSize(45, 45)
        .setColorForeground(color(160, 100, 100))
          .setColorBackground(color(230, 200, 200))
            .setColorActive(color(200, 60, 60))
              .setColorLabel(color(0))
                .setItemsPerRow(1)
                  .setSpacingRow(spcRow)
                    .addItem("INPT", 1)
                      .addItem("SYNC", 2)
                       .addItem("REPR", 3)
                            ;                         
                             for (Toggle t:s.getItems()) {
                             t.captionLabel().style().moveMargin(0, 0, 0, -44);
                             }
cp5 = new ControlP5(this);  
  PFont rpr6 = createFont("Andale Mono", 15  ); 
  cp5.setControlFont(rpr6);
  s = cp5.addRadioButton("repro")
    .setPosition(chx+275,chy+110)
      .setSize(45, 45)
        .setColorForeground(color(160, 100, 100))
          .setColorBackground(color(230, 200, 200))
            .setColorActive(color(200, 60, 60))
              .setColorLabel(color(0))
                .setItemsPerRow(1)
                  .setSpacingRow(spcRow)
                    .addItem("INPT", 1)
                      .addItem("SYNC", 2)
                       .addItem("REPR", 3)
                            ;                         
                             for (Toggle t:s.getItems()) {
                             t.captionLabel().style().moveMargin(0, 0, 0, -44);
                             }
cp5 = new ControlP5(this);  
  PFont rpr7 = createFont("Andale Mono", 15  ); 
  cp5.setControlFont(rpr7);
  s = cp5.addRadioButton("repro")
    .setPosition(chx+330,chy+110)
      .setSize(45, 45)
        .setColorForeground(color(160, 100, 100))
          .setColorBackground(color(230, 200, 200))
            .setColorActive(color(200, 60, 60))
              .setColorLabel(color(0))
                .setItemsPerRow(1)
                  .setSpacingRow(spcRow)
                    .addItem("INPT", 1)
                      .addItem("SYNC", 2)
                       .addItem("REPR", 3)
                            ;                         
                             for (Toggle t:s.getItems()) {
                             t.captionLabel().style().moveMargin(0, 0, 0, -44);
                             }
cp5 = new ControlP5(this);  
  PFont rpr8 = createFont("Andale Mono", 15  ); 
  cp5.setControlFont(rpr8);
  s = cp5.addRadioButton("repro")
    .setPosition(chx+385,chy+110)
      .setSize(45, 45)
        .setColorForeground(color(160, 100, 100))
          .setColorBackground(color(230, 200, 200))
            .setColorActive(color(200, 60, 60))
              .setColorLabel(color(0))
                .setItemsPerRow(1)
                  .setSpacingRow(spcRow)
                    .addItem("INPT", 1)
                      .addItem("SYNC", 2)
                       .addItem("REPR", 3)
                            ;                         
                             for (Toggle t:s.getItems()) {
                             t.captionLabel().style().moveMargin(0, 0, 0, -44);
                             }                              
delay(1000);
println(Serial.list());
}


void draw() { 
  background(180); 
  textSize(18);
  text("STUDER A820MCH serial remote controller", 12, 18);
  textSize(10);
  text("made by David Śmitmajer", 533, 18);

  if (rxon==true) {
    while (port.available() > 0) {
    int inByte = port.read();
    println(inByte);
    }
    }
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


void controlEvent(ControlEvent theEvent) {
 if (theEvent.getValue()==1 && theEvent.getName()=="eqn") {
    port.write('E');
    port.write('Q'); 
    port.write('?'); 
    port.write(13);
    println("EQ NORM");
  }  
  
  if (theEvent.getValue()==1 && theEvent.getName()=="vspd") {
    port.write('V');
    port.write('S'); 
    port.write('?'); 
    port.write(13);
    println("YARI SPEED");
  }  
  if (theEvent.getValue()==1 && theEvent.getName()=="nspd") {
    port.write('N');
    port.write('S'); 
    port.write('?'); 
    port.write(13);
    println("NOMINAL SPEED");
  }  
  
  if (theEvent.getValue()==1 && theEvent.getName()=="dst") {
    port.write('T');
    port.write('M'); 
    port.write('?'); 
    port.write(13);
    println("DISPLAY TIME");
  }
    
  if (theEvent.getValue()==1 && theEvent.getName()=="rpl") {
    port.write('R');
    port.write('P'); 
    port.write('L'); 
    port.write(13);
    println("REVERSE PLAY");
  }

  if (theEvent.getValue()==1 && theEvent.getName()=="rti") {
    port.write('R');
    port.write('T'); 
    port.write('I'); 
    port.write(13);
    println("RESET TIMER");
  }

  if (theEvent.getValue()==1 && theEvent.getName()=="zloc") {
    port.write('Z');
    port.write('L'); 
    port.write('O'); 
    port.write(13);
    println("ZERO LOCATOR");
  }


  if (theEvent.getName()=="spd") { 
    int windi  = int(wind);
    wind = theEvent.getValue();
    whex = (hex(windi, 4));
    println(whex);
  }
  
   if (theEvent.getName()=="svp") { 
    int windvr  = int(windv);
    windv = theEvent.getValue();
    whex = (hex(windvr, 6));
    println(whex);
  }

  if (theEvent.isGroup() && theEvent.name().equals("srl")) {
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
   if (theEvent.getValue()==1 && theEvent.getName()=="eq") { 
    port.write('S');
    port.write('C'); 
    port.write('R'); 
    port.write(13);
    println("EQ: CCIR");
  }
    if (theEvent.getValue()==2 && theEvent.getName()=="eq") { 
    port.write('S');
    port.write('N'); 
    port.write('B'); 
    port.write(13);
    println("EQ: NAB");
  }
  
  
}

