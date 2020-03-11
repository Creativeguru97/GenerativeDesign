//import generativedesign.*;//No longer available?
import processing.pdf.*;
//PDF library reference: https://processing.org/reference/libraries/pdf/index.html
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/

boolean savePDF = false;
int hue = floor(random(0, 360));
float lineLength = 200;
float angle = 0;
float angleSpeed = 1.0;
int dHue = 2;

color col;

void setup(){
  size(displayWidth, displayHeight);
  //size(500, 500);
  colorMode(HSB, 360, 100, 100, 100);
  background(0, 0, 100, 100);
  smooth();
  noFill();
  cursor(CROSS);
  
  println(hue);
}

void draw(){
  if(mousePressed){
    pushMatrix();
    strokeWeight(1.0);
    noFill();
    translate(mouseX, mouseY);
    rotate(radians(angle));
    
    if(hue >= 360) dHue = dHue * -1;
    else if(hue <= 0) dHue = dHue * -1;
    hue += dHue;
    
    col = color(hue, 50, 100, 65);
    stroke(col);
    line(0, 0, lineLength, 0);
    popMatrix();
    
    angle += angleSpeed;
  }
}


void keyReleased(){
  //No longer available?
  //if(key == 'c') GenerativeDesign.saveASE(this, colors, timestamp()+".ase");
  if(key == 's') saveFrame(timestamp()+"_##.png");
  if(key == 'p') savePDF = true;
  
  if (key == DELETE || key == BACKSPACE) background(255);
  
}



String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
