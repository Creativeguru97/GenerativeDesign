//import generativedesign.*;//No longer available?
import processing.pdf.*;
//PDF library reference: https://processing.org/reference/libraries/pdf/index.html
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/

boolean savePDF = false;

float tileCountX;
float tileCountY;
float tileWidth, tileHeight;

int count = 20;
int colorStep = 20;
int lineWeight;
int strokeColor;

color backgroundColor = 360;

int drawMode = 1;

void setup(){
  size(600, 600);
}

void draw(){
  if(savePDF){
    beginRecord(PDF, timestamp()+".pdf");
  }
  
  colorMode(HSB, 360, 100, 100, 100);
  background(backgroundColor);
  
  strokeWeight(0.5);
  strokeCap(ROUND);
  
  tileCountX = mouseX / 30 + 1;
  tileCountY = mouseY / 30 + 1;
  
  for(int gridY = 0; gridY <= tileCountY; gridY++){
    for(int gridX = 0; gridX <= tileCountX; gridX++){
      
      tileWidth = width / tileCountX;
      tileHeight = height / tileCountY;
      float posX = tileWidth * gridX;
      float posY = tileHeight * gridY;
      
      float x1 = tileWidth/2;
      float y1 = tileHeight/2;
      float x2 = 0;
      float y2 = 0;
      
      pushMatrix();
      translate(posX, posY);
      
      for(int side = 0; side < 4; side++){
        for(int i = 0; i < count; i++){
          //Move end point around the four sides of tile
          if(side == 0){
            /*In this case, slide x value of the end point
            +tileWidth / count*/
            x2 += tileWidth / count;
            y2 = 0;
          }
          if(side == 1){
            x2 = tileWidth;
            y2 += tileHeight / count;
          }
          if(side == 2){
            x2 -= tileWidth / count;
            y2 = tileHeight;
          }
          if(side == 3){
            x2 = 0;
            y2 -= tileHeight / count;
          }
          
          //Set colors depending on draw mode
          if(drawMode == 1){
            backgroundColor = 360;
            strokeColor = 0;
            lineWeight = 1;
          }else if(drawMode == 2){
            backgroundColor = 0;
            strokeColor = 360;
            lineWeight = 1;
          }else if(drawMode == 3){
            
            backgroundColor = 360;
            strokeColor = 0;
            
            if(i == count/2-1){
              lineWeight = 2;
            } else {
              lineWeight = 1;
            }
 
          }else if(drawMode == 4){
            
            backgroundColor = 0;
            strokeColor = 360;
            
            if(i == count/2-1){
              lineWeight = 2;
            } else {
              lineWeight = 1;
            }
 
          }else if(drawMode == 5){
            
            backgroundColor = 360;
            strokeColor = 0;
            
            if(i == count-1){
              lineWeight = 2;
            } else {
              lineWeight = 1;
            }
 
          }else if(drawMode == 6){
            
            backgroundColor = 0;
            strokeColor = 360;
            
            if(i == count-1){
              lineWeight = 2;
            } else {
              lineWeight = 1;
            }
 
          }
          stroke(strokeColor);
          strokeWeight(lineWeight);
          line(x1, y1, x2, y2); //Draw the line
        }
      }
      
      popMatrix();
    }
  }
  
}


void keyReleased(){
  //No longer available?
  //if(key == 'c') GenerativeDesign.saveASE(this, colors, timestamp()+".ase");
  if(key == 's') saveFrame(timestamp()+"_##.png");
  if(key == 'p') savePDF = true;
  
  if (key == '1') drawMode = 1;
  if (key == '2') drawMode = 2;
  if (key == '3') drawMode = 3;
  if (key == '4') drawMode = 4;
  if (key == '5') drawMode = 5;
  if (key == '6') drawMode = 6;
  
}



String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
