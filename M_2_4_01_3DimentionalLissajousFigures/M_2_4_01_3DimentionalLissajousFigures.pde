//import generativedesign.*;//No longer available?
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/
    
//import processing.opengl.*;

import peasy.*;

PeasyCam cam;
    
int pointCount = 600;

int freqX = 1;
int freqY = 4;
int freqZ = 2;
float phiX = 0;
float phiY = 0;

PVector lissajousPoints[];

void setup(){
  size(600, 600, P3D);
  
  cam = new PeasyCam(this, 800);
  cam.setMinimumDistance(-200);
  cam.setMaximumDistance(1500);
  
  calculateLissajousPoints();
}

void draw(){
  background(255);
  
  //Draw triangles
  noStroke();
  beginShape(TRIANGLE_FAN);
  for(int i=0; i<pointCount-2; i++){
    if(i%3 == 0){
      //gradient for every trinangle to lissajou path
      fill(50);
      vertex(0, 0, 0);
      fill(200);
      vertex(lissajousPoints[i].x, lissajousPoints[i].y, lissajousPoints[i].z);
      vertex(lissajousPoints[i+2].x, lissajousPoints[i+2].y, lissajousPoints[i+2].z);
    }
  }
  endShape();
  
  //Draw lissajous path
  stroke(0);
  strokeWeight(1);
  noFill();
  beginShape();
  for(int i=0; i<=pointCount; i++){
    vertex(lissajousPoints[i].x, lissajousPoints[i].y, lissajousPoints[i].z);
  }
  endShape();
}

void calculateLissajousPoints(){
 lissajousPoints = new PVector[pointCount+1];
 float f = width/2;
 
 for(int i=0; i<=pointCount; i++){
   float angle = map(i, 0, pointCount, 0, TWO_PI);
   
   float x = sin(angle * freqX + radians(phiX)) * cos(angle * 2) * f;
   float y = sin(angle * freqY + radians(phiY)) * sin(angle * 2) * f;
   float z = cos(angle * freqZ) * f;
   lissajousPoints[i] = new PVector(x, y, z);
 }
}

void keyPressed(){
  if(key == 's') saveFrame(timestamp()+"_##.png");
  
  
  if (key == '3') freqX--;
  if (key == '4') freqX++;
  freqX = max(freqX, 1);//To not to down below 1;
  
  if (key == '5') freqY--;
  if (key == '6') freqY++;
  freqY = max(freqY, 1);//To not to down below 1;
  
  
  if (keyCode == LEFT) phiX -= 15;
  if (keyCode == RIGHT) phiX += 15;
  if (keyCode == DOWN) phiY -= 15;
  if (keyCode == UP) phiY += 15;
  
  calculateLissajousPoints();//Calculate with new values above
}


String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
