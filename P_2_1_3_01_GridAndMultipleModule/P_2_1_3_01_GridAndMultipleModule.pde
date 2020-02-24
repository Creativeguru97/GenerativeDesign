//import generativedesign.*;//No longer available?
import processing.pdf.*;
//PDF library reference: https://processing.org/reference/libraries/pdf/index.html
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/

boolean savePDF = false;

float tileCountX = 10;
float tileCountY = 10;
float tileWidth, tileHeight;

int count = 0;
int colorStep = 15;
int circleCount;
float endSize, endOffset;

int actRandomSeed = 0;

void setup(){
  size(800, 800);
  tileWidth = width / tileCountX;
  tileHeight = height / tileCountY;
}

void draw(){
  if(savePDF){
    beginRecord(PDF, timestamp()+".pdf");
  }
  
  //colorMode(HSB, 360, 100, 100, 100);
  background(255);
  noFill();
  stroke(0, 128);
  randomSeed(actRandomSeed);
  
  //Bring the coordinate origin to the upper left corner of the grid below
  translate((width/tileCountX)/2, (height/tileCountY)/2);
  
  circleCount = mouseX / 30 + 1;
  endSize = map(mouseX, 0, width, tileWidth/2, 0);
  endOffset = map(mouseY, 0, height, 0, (tileWidth - endSize)/2);
  
  for(int gridY = 0; gridY <= tileCountY; gridY++){
    for(int gridX = 0; gridX <= tileCountX; gridX++){
      
      pushMatrix();
      
      //Slide the origin to one by one.
      translate(tileWidth*gridX, tileHeight*gridY);
      //This scale function doesn't do anything at this sketch, isn't it?
      scale(1, tileHeight/tileWidth);
      
      int toggle = int(random(0, 4));
      if(toggle == 0) rotate(-HALF_PI);
      if(toggle == 1) rotate(0);
      if(toggle == 2) rotate(HALF_PI);
      if(toggle == 3) rotate(PI);
      
      //Draw module. We also cen do this with recusion.
      for(int i = 0; i < circleCount; i++){
        float diameter = map(i, 0, circleCount-1, tileWidth, endSize);
        float offset = map(i, 0, circleCount-1, 0, endOffset);
        ellipse(offset, 0, diameter, diameter);
      }
      
      popMatrix();
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
