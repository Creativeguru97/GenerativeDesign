//import generativedesign.*;//No longer available?
import processing.pdf.*;
//PDF library reference: https://processing.org/reference/libraries/pdf/index.html
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/

boolean savePDF = false;

float tileCountX = 5;
float tileCountY = 5;
float tileWidth, tileHeight;
float posX, posY;

int count;
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
  
  count = mouseX/20 + 5;
  float para = float(mouseY)/height-0.5;//Range of 0 ~ 0.5
  
  for(int gridY = 0; gridY <= tileCountY; gridY++){
    for(int gridX = 0; gridX <= tileCountX; gridX++){
      
      tileWidth = width / tileCountX;
      tileHeight = height / tileCountY;
      posX = tileWidth * gridX + tileWidth/2;
      posY = tileHeight * gridY + tileHeight/2;
      
      pushMatrix();
      translate(posX, posY);
      
      if(drawMode == 1){
        translate(-tileWidth/2, -tileHeight/2);
        for(int i=0; i<count; i++){
          line(0, (para+0.5)*tileHeight, tileWidth, i*tileHeight/count);
          line(0, i*tileHeight/count, tileWidth, tileHeight-(para+0.5)*tileHeight);
        }
      }
      if(drawMode == 2){
        for(float i=0; i<=count; i++) {
          line(para*tileWidth, para*tileHeight, tileWidth/2, (i/count-0.5)*tileHeight);
          line(para*tileWidth, para*tileHeight, -tileWidth/2, (i/count-0.5)*tileHeight);
          line(para*tileWidth, para*tileHeight, (i/count-0.5)*tileWidth, tileHeight/2);
          line(para*tileWidth, para*tileHeight, (i/count-0.5)*tileWidth, -tileHeight/2);
        }
      }
      if(drawMode == 3){
        for(float i=0; i<=count; i++) {
          line(0, para*tileHeight, tileWidth/2, (i/count-0.5)*tileHeight);
          line(0, para*tileHeight, -tileWidth/2, (i/count-0.5)*tileHeight);
          line(0, para*tileHeight, (i/count-0.5)*tileWidth, tileHeight/2);
          line(0, para*tileHeight, (i/count-0.5)*tileWidth, -tileHeight/2);
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
  
}



String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
