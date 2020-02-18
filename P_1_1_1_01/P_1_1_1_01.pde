import processing.pdf.*;
//PDF library reference: https://processing.org/reference/libraries/pdf/index.html
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/

boolean savePDF = false;

int stepX;
int stepY;

void setup(){
  size(800, 400);
  background(0);
}

void draw(){
  // this line will start pdf export, if the variable savePDF was set to true 
  //If statement is only one code, we can write like this below.
  if (savePDF) beginRecord(PDF, timestamp()+".pdf");
  
  noStroke();
  colorMode(HSB, width, height, 100);//colorMode(Hue, Saturation, Brightness, Alpha)
  
  stepX = mouseX+2;
  stepY = mouseY+2;
  
  for(int gridY = 0; gridY<height; gridY += stepY){
    for(int gridX = 0; gridX<width; gridX += stepX){
      fill(gridX, height-gridY, 100);
        //H:x value, S:y value, B:100
      rect(gridX, gridY, stepX, stepY);
    }
  }
  
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
