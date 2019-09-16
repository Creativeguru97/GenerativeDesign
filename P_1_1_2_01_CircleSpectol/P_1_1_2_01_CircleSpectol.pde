import processing.pdf.*;
//PDF library reference: https://processing.org/reference/libraries/pdf/index.html
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/

boolean savePDF = false;

int segmentCount = 360;
int radius = 300;

void setup(){
  size(800, 800);
}

void draw(){
  // this line will start pdf export, if the variable savePDF was set to true 
  //If statement is only one code, we can write like this below.
  if (savePDF) beginRecord(PDF, timestamp()+".pdf");
  
  noStroke();
  colorMode(HSB, 360, width, height);
  background(360);
  
  float angleStep = 360/segmentCount;
  
  beginShape(TRIANGLE_FAN);
  /*more about shape in Processing
  https://processing.org/reference/beginShape_.html*/
  vertex(width/2, height/2);
  for(float angle = 0; angle <= 360; angle += angleStep){
    float vx = width/2 + cos(radians(angle))*radius; //-1 <= cos <= 1
    float vy = height/2 + sin(radians(angle))*radius; //-1 <= sin <= 1
    vertex(vx, vy);
    fill(angle, mouseX, mouseY);
  }
  endShape();
  
  //end of pdf recording
  if(savePDF){
    savePDF = false;
    endRecord();
  }
   
}



void keyPressed(){
  if(key == 's') saveFrame(timestamp()+"_##.png");
  if(key == 'p') savePDF = true;
  
  if(key == '1') segmentCount = 360;
  if(key == '2') segmentCount = 45;
  if(key == '3') segmentCount = 24;
  if(key == '4') segmentCount = 12;
  if(key == '5') segmentCount = 6;
}

String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
