//import generativedesign.*;//No longer available?
import processing.pdf.*;
//PDF library reference: https://processing.org/reference/libraries/pdf/index.html
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/

boolean savePDF = false;

int NORTH = 0;
int NORTHEAST = 1;
int EAST = 2;
int SOUTHEAST = 3;
int SOUTH = 4;
int SOUTHWEST = 5;
int WEST = 6;
int NORTHWEST = 7;

float stepSize = 1;
float diameter = 1;

float drawMode = 1;
int counter = 0;

int direction;
float posX, posY;

void setup(){
  size(800, 800);
  background(255);
  smooth();
  noStroke();
  posX = width/2;
  posY = height/2;
}

void draw(){
  if(savePDF){
    beginRecord(PDF, timestamp()+".pdf");
  }
  
  for(int i=0; i<=mouseX; i++){
    counter++;
    
    //Random number for the direction of the next step
    if(drawMode == 2){
      direction = int(random(0, 3));// only NORTH, NORTHEAST, EAST possible
    }else{
      direction = int(random(0, 7));// all directions without NORTHWEST
    }
    
    if(direction == NORTH){
      posY -= stepSize;
    }else if(direction == NORTHEAST){
      posX += stepSize;
      posY -= stepSize;
    }else if(direction == EAST){
      posX += stepSize;
    }else if(direction == SOUTHEAST){
      posX += stepSize;
      posY += stepSize;
    }else if(direction == SOUTH){
      posY += stepSize;
    }else if(direction == SOUTHWEST){
      posX -= stepSize;
      posY += stepSize;
    }else if(direction == WEST){
      posX -= stepSize;
    }else if(direction == NORTHWEST){
      posX -= stepSize;
      posY -= stepSize;
    }
    
    if (posX > width) posX = 0;
    if (posX < 0) posX = width;
    if (posY < 0) posY = height;
    if (posY > height) posY = 0;
    
    if(drawMode == 3){
      //Sometime(1 in 100 frames) bigger and colored dot appears
      if(counter >= 100){
        counter = 0;
        fill(192, 100, 64, 80);
        ellipse(posX+stepSize/2, posY+stepSize/2, diameter+7, diameter+7);
      }
    }
  
  fill(0, 40);
  ellipse(posX+stepSize/2, posY+stepSize/2, diameter, diameter);
 
  }
  
}



void keyReleased(){
  //No longer available?
  //if(key == 'c') GenerativeDesign.saveASE(this, colors, timestamp()+".ase");
  if(key == 's') saveFrame(timestamp()+"_##.png");
  if(key == 'p') savePDF = true;
  
  if (key == '1') {
    drawMode = 1;
    stepSize = 1;
    diameter = 1;
  }
  if (key == '2') {
    drawMode = 2;
    stepSize = 1;
    diameter = 1;
  }
  if (key == '3') {
    drawMode = 3;
    stepSize = 10;
    diameter = 5;
  }

}



String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
