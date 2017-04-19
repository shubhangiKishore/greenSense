import processing.serial.*;
import controlP5.*;

ControlP5 cp5;
Serial myPort; 
String val; 
float tempc=0,tempf=0,humidity=0,rain=0,mois=0,motor=0,redalert=0,light=1,waterlevel=0,tresspass=1,water=0;
String date="";
//PImage bg;
PFont f;
int cx, cy;
float secondsRadius;
float minutesRadius;
float hoursRadius;
float clockDiameter;
//RadioButton r1;

void setup() {
  size(500, 600);
  String portName = "/dev/rfcomm0"; 
  myPort = new Serial(this, portName, 38400);
  myPort.bufferUntil('\n');
  //f = createFont("Arial",16,true); 
  //bg = loadImage("download.jpg");
  
     // CLOCK
  int radius = min(width, height) / 20;
  secondsRadius = radius * 0.72;
  minutesRadius = radius * 0.60;
  hoursRadius = radius * 0.50;
  clockDiameter = radius * 1.8;
  
  cx = width / 9;
  cy = height / 9;
 
       
}

//void serialEvent (Serial myPort){ // Checks for available data in the Serial Port
//ledStatus = myPort.readStringUntil('\n'); //Reads the data sent from the Arduino (the String "LED: OFF/ON) and it puts into the "ledStatus" variable
//}


/*void setup()
{
size(400,300);
String portName = "/dev/rfcomm0";
myPort = new Serial(this, portName, 34800);
//bg = loadImage("download.jpg");
*/
   // Checks for available data in the Serial Port
 // ledStatus = myPort.readStringUntil('\n'); //Reads the data sent from the Arduino (the String "LED: OFF/ON) and it puts into the "ledStatus" variable

/*

void loop(){
  
     
     
     delay(200);
  
  
  
  
}
*/
  

void draw()
{ 
  
  background(250);
  fill(20, 160, 133);
  try {
  if(myPort.available()>0)
  val = myPort.readStringUntil('\n');
  if (val!= null) {
  val = trim(val);
  println(val);
  float sensorVals[] = float(split(val, ','));
  humidity=sensorVals[0];
  tempc=sensorVals[1]/10+26;
  waterlevel=sensorVals[2];
rain=sensorVals[3];
light=sensorVals[4];
mois=sensorVals[5];
delay(500);}
}
catch(Exception ex) { }
  textSize(24);
    text("Green Sense",180,55);
    fill(20, 160, 133);
  //background(bg);
  //fill(0);
  textSize(14);
  text("Temprature  ",50,115);
  //fill(0);
  //text(tempc,130,50);
  //text("C",170,50);
  //text(tempf,220,50);
  //text("F",300,50);
  //fill(0);
  text("Humidity",325,115);
  text("Waterlevel",325,215);
  //text("%",200,100);
  //fill(0);
  //text(humidity,150,100);
  //fill(0);
  //text("Soil Moisture",50,80);
  //fill(0);
    cp5 = new ControlP5(this);
  cp5.addNumberbox("soilmoisture")
     .setPosition(50,225)
     .setSize(100,20)
     .setScrollSensitivity(1.1)
     .setValue(mois)
     ;
     
     cp5.addNumberbox("temp")
     .setPosition(50,125)
     .setSize(100,20)
     .setScrollSensitivity(1.1)
     .setValue(tempc)
     ;
     cp5.addNumberbox("humid")
     .setPosition(325,125)
     .setSize(100,20)
     .setScrollSensitivity(1.1)
     .setValue(humidity)
     ;
     cp5.addNumberbox("waterlevel")
     .setPosition(325,225)
     .setSize(100,20)
     .setScrollSensitivity(1.1)
     .setValue(waterlevel)
     ;
  if(rain<500){
    //fill(255,0,0);
    text("Rainfall: Yes",325,315);
    //text("It is raining.", 100,315 );
  }else{
    //fill(0,0,255);
    text("Rainfall: No",325,315);
    //text("The skies are clear.",350,315);
  }
  if(light==0){
    //fill(255,0,0);
    text("Light: No",325,330);
    //text("It is raining.", 100,315 );
  }else{
    //fill(0,0,255);
    text("Light: Yes",325,330);
    //text("The skies are clear.",350,315);
  }
 
  //fill(0);
  text("Soil Moisture",50,215);
  //text(mois,50,225);
  text("Motor",50,315);
  //text(mois,150,150);
  //text("%",200,150);
  //if(motor==0){
    //fill(255,0,0);
    //text("Motor is Off.",100,315);
 /// }else{
    //fill(0,0,255);
    //text("Motor is On.",100,315);
 // }
   if(tempc>36){
    fill(255,0,0);
    textSize(12);
    text("Alert. Temperature is high.\nKeep the plants inside.",50,375);
  }
  if(waterlevel>1000){
    fill(20);
    text("Water Level is low",300,375);
  }
  //else{
   // fill(255,0,0);
   // text("",300,375);
  //}
  
  //background(237, 240, 241);
  //textSize(32);
  //fill(20, 160, 133);
  //text("Green Sense", 120, 60);
  
  fill(20, 160, 133); // Green Color
  stroke(33);
  strokeWeight(1);
  rect(50, 323, 27, 15, 10);  // Turn ON Button
  rect(83, 323, 27, 15, 10); // Turn OFF Button
  //fill(255);
  fill(0);
  textSize(10);
  text("ON",55, 335);
  text("OFF",88, 335);
  //textSize(18);
  fill(33);
  ////text("Status:", 180, 200);
  //textSize(16);
  textSize(12);
 // text(ledStatus, 100, 315); // Prints the string comming from the Arduino
  
  fill(80);
  noStroke();
  ellipse(cx, cy, clockDiameter, clockDiameter);
  
  // Angles for sin() and cos() start at 3 o'clock;
  // subtract HALF_PI to make them start at the top
  float s = map(second(), 0, 60, 0, TWO_PI) - HALF_PI;
  float m = map(minute() + norm(second(), 0, 60), 0, 60, 0, TWO_PI) - HALF_PI; 
  float h = map(hour() + norm(minute(), 0, 60), 0, 24, 0, TWO_PI * 2) - HALF_PI;
  
  // Draw the hands of the clock
  stroke(255);
  strokeWeight(1);
  line(cx, cy, cx + cos(s) * secondsRadius, cy + sin(s) * secondsRadius);
  strokeWeight(2);
  line(cx, cy, cx + cos(m) * minutesRadius, cy + sin(m) * minutesRadius);
  strokeWeight(4);
  line(cx, cy, cx + cos(h) * hoursRadius, cy + sin(h) * hoursRadius);
  
  // Draw the minute ticks
  strokeWeight(2);
  beginShape(POINTS);
  for (int a = 0; a < 360; a+=6) {
    float angle = radians(a);
    float x = cx + cos(angle) * secondsRadius;
    float y = cy + sin(angle) * secondsRadius;
    vertex(x, y);
  }
  endShape();
  
  // If the button "Turn ON" is pressed
  if(mousePressed && mouseX>50 && mouseX<83 && mouseY>323 && mouseY<373){
   myPort.write('1'); // Sends the character '1' and that will turn on the LED
    // Highlighs the buttons in red color when pressed
    stroke(20,0,0);
    strokeWeight(2);
    noFill();
    rect(50, 323, 27, 15, 10);
   
  //textSize(16);
  //text("ON", 155, 240);
  }
  // If the button "Turn OFF" is pressed
  if(mousePressed && mouseX>82 && mouseX<323 && mouseY>323 && mouseY<335){
  myPort.write('0'); // Sends the character '0' and that will turn on the LED
stroke(20,0,0);
    strokeWeight(2);
    noFill();
    rect(83, 323, 27, 15, 10);



}
}