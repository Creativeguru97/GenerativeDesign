//import generativedesign.*;//No longer available?
import processing.pdf.*;
//PDF library reference: https://processing.org/reference/libraries/pdf/index.html
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/

boolean savePDF = false;

PImage img;
color[] colors;

String sortMode = null;

void setup(){
  size(600, 600);
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
  noCursor();
  img = loadImage("data/pic1.jpg");
}

void draw(){
  if(savePDF){
    beginRecord(PDF, timestamp()+".pdf");
    colorMode(HSB, 360, 100, 100, 100);
    noStroke();
  }
  
  int tileCountX = width / max(mouseX, 1);
  int tileCountY = height / max(mouseY, 1);
  float rectSizeX = width / float(tileCountX);
  float rectSizeY = height / float(tileCountY);
  
  //Get colors from image
  int i = 0;
  colors = new color[tileCountX*tileCountY];
  for (int gridY = 0; gridY < tileCountY; gridY++){
    for (int gridX = 0; gridX < tileCountX; gridX++){
      int px = int(gridX * rectSizeX);
      int py = int(gridY * rectSizeY);
      colors[i] = img.get(px, py);
      i++;
    }
  }
  
  //draw grid
  i = 0;
  for(int gridY = 0; gridY < tileCountY; gridY++){
    for (int gridX = 0; gridX < tileCountX; gridX++){
      fill(colors[i]);
      rect(gridX*rectSizeX, gridY*rectSizeY, rectSizeX, rectSizeY);
      i++;
    }
  }
  
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
  
  if(key == '1') img = loadImage("pic1.jpg");
  if(key == '2') img = loadImage("pic2.jpg");
}

String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
