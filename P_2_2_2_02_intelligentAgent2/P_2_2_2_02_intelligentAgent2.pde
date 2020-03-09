//import generativedesign.*;//No longer available?
import processing.pdf.*;
//PDF library reference: https://processing.org/reference/libraries/pdf/index.html
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/

boolean savePDF = false;

int NORTH = 0;
int EAST = 1;
int SOUTH = 2;
int WEST = 3;

int direction = SOUTH;
float posX, posY;
float posXcross, posYcross;

float stepSize = 2;
float angleCount = 2;
float angle = getRandomAngle(direction);
int minLength = 10;

//Width and brightness of the stroke depend on line length
int dWeight =  50;
int dStroke = 4;
int drawMode = 2;

void setup(){
  size(600, 600);
  colorMode(HSB, 360, 100, 100, 100);
  background(360);
  smooth();

  posX = int(random(0, width));
  posY = height/2;
  posXcross = posX;
  posXcross = posY;
}

void draw(){
  
  for(int i=0; i <= mouseX; i++){
    if(savePDF){
      beginRecord(PDF, timestamp()+".pdf");
    }else{
      
      //Draw dot at current position.
      strokeWeight(1);
      stroke(180);
      point(posX, posY);
    }
    
    //Make step
    posX += cos(radians(angle))*stepSize;
    posY += sin(radians(angle))*stepSize;
    
    //Check if agent is near one of the display borders
    boolean reachedBorder = false;
    
    if(posY <= 5){
      direction = SOUTH;
      reachedBorder = true;
    }else if(posY >= height-5){
      direction = NORTH;
      reachedBorder = true;
    }else if(posX <= 5){
      direction = EAST;
      reachedBorder = true;
    }else if(posX >= height-5){
      direction = WEST;
      reachedBorder = true;
    }
    
    int px = int(posX);
    int py = int(posY);
    if(get(px, py) != color(360) || reachedBorder){
      angle = getRandomAngle(direction);
      float distance = dist(posX, posY, posXcross, posYcross);
      if(distance >= minLength){
        strokeWeight(distance/dWeight);
        if(drawMode == 1) stroke(0);
        if(drawMode == 2) stroke(52, 100, distance/dStroke);
        if(drawMode == 3) stroke(192, 100, 64, distance/dStroke);
        line(posX, posY, posXcross, posYcross);
      }
      
      //Store the end of the coordinate until it's renewwd.
      posXcross = posX;
      posYcross = posY;
    }
  } 
}

float getRandomAngle(int theDirection){
  float a = (floor(random(-angleCount, angleCount)) + 0.5) * 90.0 / angleCount;
  if(theDirection == NORTH) return (a-90);
  if(theDirection == EAST) return (a);
  if(theDirection == SOUTH) return (a+90);
  if(theDirection == WEST) return (a+180);
  return 0;
}



void keyReleased(){
  //No longer available?
  //if(key == 'c') GenerativeDesign.saveASE(this, colors, timestamp()+".ase");
  if(key == 's') saveFrame(timestamp()+"_##.png");
  if(key == 'p') savePDF = true;

  if (key == '1') {
    background(360);
    drawMode = 1;
  }
  if (key == '2') {
    background(360);
    drawMode = 2;
  }
  if (key == '3') {
    background(360);
    drawMode = 3;
  }
}



String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
