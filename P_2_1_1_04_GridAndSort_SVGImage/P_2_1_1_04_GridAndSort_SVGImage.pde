//import generativedesign.*;//No longer available?
import processing.pdf.*;
//PDF library reference: https://processing.org/reference/libraries/pdf/index.html
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/

boolean savePDF = false;

PShape currentShape;

int tileCount = 10;
float tileWidth, tileHeight;
float shapeSize = 50;
float newShapeSize = shapeSize;
float shapeAngle = 0;
float maxDist;

color shapeColor = color(0, 130, 164);
int fillMode = 0;
int sizeMode = 0;

void setup(){
  size(600, 600);
  background(255);
  smooth();
  
  tileWidth = width / float(tileCount);
  tileHeight = height / float(tileCount);
  maxDist = sqrt(sq(width)+sq(height));
  
  currentShape = loadShape("module_1.svg");
}

void draw(){
  if(savePDF){
    beginRecord(PDF, timestamp()+".pdf");
  }
  
  //colorMode(HSB, 360, 100, 100, 100);
  background(255);
  smooth();
  
  for(int gridY = 0; gridY < tileCount; gridY++){
    for(int gridX = 0; gridX < tileCount; gridX++){
      
      float posX = tileWidth*gridX + tileWidth/2;
      float posY = tileHeight*gridY + tileHeight/2;
      
      //Calculate angle between mouse position and actual position of the shape
      float angle = atan2(mouseY-posY, mouseX-posX) + radians(shapeAngle);
      /*Calculates the angle (in radians) from a specified point to the coordinate 
      origin as measured from the positive x-axis. Values are returned as a float 
      in the range from PI to -PI.
      
      : atan2(y, x) :
      
      */
      
      if(sizeMode == 0) newShapeSize = shapeSize;
      if(sizeMode == 1) newShapeSize = shapeSize * 1.5 - map(dist(mouseX, mouseY, posX, posY), 0, 500, 5, shapeSize);
      if(sizeMode == 2) newShapeSize = map(dist(mouseX, mouseY, posX, posY), 0, 500, 5, shapeSize);
      
      if(fillMode == 0) currentShape.enableStyle();
      if(fillMode == 1){
        currentShape.disableStyle();
        fill(shapeColor);
      }
      if (fillMode == 2) {
        currentShape.disableStyle();
        float a = map(dist(mouseX,mouseY,posX,posY), 0,maxDist, 255,0);
        fill(shapeColor, a);      
      }
      if (fillMode == 3) {
        currentShape.disableStyle();
        float a = map(dist(mouseX,mouseY,posX,posY), 0,maxDist, 0,255);
        fill(shapeColor, a);      
      }
      
      pushMatrix();
      translate(posX, posY);
      rotate (angle);
      shapeMode (CENTER);
      
      noStroke();
      shape(currentShape, 0,0, newShapeSize,newShapeSize);
      popMatrix();
    }
  }
  
}



void keyReleased(){
  //No longer available?
  //if(key == 'c') GenerativeDesign.saveASE(this, colors, timestamp()+".ase");
  if(key == 's') saveFrame(timestamp()+"_##.png");
  if(key == 'p') savePDF = true;
  
  if (key == 'c' || key == 'C') fillMode = (fillMode+1) % 4;
  if (key == 'd' || key == 'D') sizeMode = (sizeMode+1) % 3;
  
  if (key == '1') currentShape = loadShape("module_1.svg");
  if (key == '2') currentShape = loadShape("module_2.svg");
  if (key == '3') currentShape = loadShape("module_3.svg");
  if (key == '4') currentShape = loadShape("module_4.svg");
  if (key == '5') currentShape = loadShape("module_5.svg");
  if (key == '6') currentShape = loadShape("module_6.svg");
  if (key == '7') currentShape = loadShape("module_7.svg");
  if (key == '8') currentShape = loadShape("module_8.svg");
  

}



String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
