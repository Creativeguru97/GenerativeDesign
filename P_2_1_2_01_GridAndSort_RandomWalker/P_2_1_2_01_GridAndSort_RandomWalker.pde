//import generativedesign.*;//No longer available?
import processing.pdf.*;
//PDF library reference: https://processing.org/reference/libraries/pdf/index.html
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/

boolean savePDF = false;

int tileCount = 20;
float tileWidth;
float tileHeight;
  

color circleColor = color(0);
int circleAlpha = 180;

int actRandomSeed = 0;


void setup(){
  size(600, 600);
  tileWidth = width / tileCount;
  tileHeight = height / tileCount;
}

void draw(){
  if(savePDF){
    beginRecord(PDF, timestamp()+".pdf");
  }
  
  //colorMode(HSB, 360, 100, 100, 100);
  background(255);
  noFill();
  smooth();
  
  randomSeed(actRandomSeed);
  
  stroke(circleColor, circleAlpha);
  strokeWeight(1);
  
  for(int gridY = 0; gridY < tileCount; gridY++){
    for(int gridX = 0; gridX < tileCount; gridX++){
      
      float posX = width / tileCount * gridX + tileWidth/2;
      float posY = height / tileCount * gridY + tileHeight/2;
      
      float shiftX = random(-mouseX, mouseX) / 20;
      float shiftY = random(-mouseY, mouseY) / 20;
      
      //float randomValue = sq(dist(posX, posY, mouseX, mouseY))/300;
      //float shiftX = random(-randomValue, randomValue) / 20;
      //float shiftY = random(-randomValue, randomValue) / 20;
      
      ellipse(posX+shiftX, posY+shiftY, tileWidth/2, tileHeight/2);
    }
  }
  
}

void mousePressed() {
  actRandomSeed = (int) random(100000);
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
