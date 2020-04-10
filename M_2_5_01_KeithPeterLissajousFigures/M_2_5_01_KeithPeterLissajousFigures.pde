//import generativedesign.*;//No longer available?
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/
    
//import processing.opengl.*;

import peasy.*;

PeasyCam cam;
    
int pointCount = 800;
PVector[] lissajousPoints = new PVector[0];

int freqX = 4;
int freqY = 7;
int phi = 15;

float modFreqX = 3;
float modFreqY = 2;

float lineWeight = 1;
color lineColor = color(0);
float lineAlpha = 50;

float connectionRadius = 100;
//float connectionRamp = 6;


void setup(){
  size(800, 800);
  smooth();
  
  calculateLissajousPoints();
  drawLissajous();
}

void draw(){
}

void calculateLissajousPoints(){
 lissajousPoints = new PVector[pointCount+1];
 
 for(int i=0; i<=pointCount; i++){
   float angle = map(i, 0, pointCount, 0, TWO_PI);
   
   float x = sin(angle * freqX + radians(phi)) * cos(angle * modFreqX);
   float y = sin(angle * freqY) * cos(angle * modFreqY);
   
   x = x * (width/2-30);
   y = y * (height/2-30);
   
   lissajousPoints[i] = new PVector(x, y);
 }
}

void drawLissajous(){
  float d, a;
  
  colorMode(RGB, 255, 255, 255, 100);
  background(255);
  strokeWeight(lineWeight);
  strokeCap(ROUND);
  noFill();
  
  pushMatrix();
  translate(width/2, height/2);
  
  for (int i1 = 0; i1 < pointCount; i1++){
    for (int i2 = 0; i2 < i1; i2++){
      PVector p1 = lissajousPoints[i1];
      PVector p2 = lissajousPoints[i2];
      
      //This exponential formula is the key to make that beautiful gradient alpha.
      d = PVector.dist(p1, p2);//Calculate distance between two points.
      a = pow(1/(d/connectionRadius+1), 6);
      
      if(d <= connectionRadius){
        stroke(lineColor, a * lineAlpha);
        line(p1.x, p1.y, p2.x, p2.y);
      }
    }
  }
  popMatrix();
}


void keyPressed(){
  if(key == 's') saveFrame(timestamp()+"_##.png");
  
  
  if (key == '1') freqX--;
  if (key == '2') freqX++;
  freqX = max(freqX, 1);//To not to down below 1;
  
  if (key == '3') freqY--;
  if (key == '4') freqY++;
  freqY = max(freqY, 1);//To not to down below 1;
  
  if (key == '5') modFreqX--;
  if (key == '6') modFreqX++;
  modFreqX = max(modFreqX, 1);//To not to down below 1;
  
  if (key == '7') modFreqY--;
  if (key == '8') modFreqY++;
  modFreqY = max(modFreqY, 1);//To not to down below 1;
  
  if (keyCode == LEFT) phi -= 15;
  if (keyCode == RIGHT) phi += 15;
  
  
  
  calculateLissajousPoints();//Calculate with new values above
  drawLissajous();
}


String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
