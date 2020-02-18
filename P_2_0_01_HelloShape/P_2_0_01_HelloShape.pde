//import generativedesign.*;//No longer available?
import processing.pdf.*;
//PDF library reference: https://processing.org/reference/libraries/pdf/index.html
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/

boolean savePDF = false;

int tileCountX = 50;
int tileCountY = 10;
int [] hueValues = new int[tileCountX];
int [] saturationValues = new int[tileCountX];
int [] brightnessValues = new int[tileCountX];

void setup(){
  size(800, 800);
}

void draw(){
  if(savePDF){
    beginRecord(PDF, timestamp()+".pdf");
    colorMode(HSB, 360, 100, 100, 100);
    noStroke();
  }
  
  strokeCap(ROUND);
  /*Sets the style for rendering line endings 
  with the corresponding parameters: 
  SQUARE, PROJECT, and ROUND. The default cap is ROUND*/
  smooth();
  noFill();
  
  background(255);
  translate(width/2,height/2);//Move the origin to center.
  
  int circleResolution = int(map(mouseY, 0, height, 2, 80));
  float radius = mouseX - width / 2 + 0.5;
  float angle = TWO_PI / circleResolution;
  
  strokeWeight(mouseY / 20);
  
  beginShape();
  for(int i = 0; i < circleResolution; i++){
    float x = cos(angle * i) * radius;
    float y = sin(angle * i) * radius;
    line(0, 0, x, y);
  }
  endShape();
  
  if(savePDF){
    savePDF = false;
    endRecord();
  }
  
}


void keyReleased(){
  //No longer available?
  //if(key == 'c') GenerativeDesign.saveASE(this, colors, timestamp()+".ase");
  if(key == 's') saveFrame(timestamp()+"_##.png");
  if(key == 'p') savePDF = true;
  
}



String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
