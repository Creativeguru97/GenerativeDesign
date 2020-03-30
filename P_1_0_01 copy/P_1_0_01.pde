import processing.pdf.*;
//PDF library reference: https://processing.org/reference/libraries/pdf/index.html
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/

boolean savePDF = false;

void setup(){
  size(720, 720);
  noCursor();
}

void draw(){
  // this line will start pdf export, if the variable savePDF was set to true 
  //If statement is only one code, we can write like this below.
  if (savePDF) beginRecord(PDF, timestamp()+".pdf");
  
  //HSB, hue saturation, brightness
  colorMode(HSB, 360, 100, 100);
  noStroke();
  background(mouseY/2, 100, 100);
  
  rectMode(CENTER);
  fill(360-mouseY/2, 100, 100);
  rect(width/2, width/2, mouseX+1, mouseX+1);
  
  //end of pdf recording
  if(savePDF){
    savePDF = false;
    endRecord();
  }
}

void keyPressed(){
  if(key == 's') saveFrame(timestamp()+"_##.png");
  if(key == 'p') savePDF = true;
}

String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
