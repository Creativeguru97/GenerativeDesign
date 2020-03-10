//import generativedesign.*;//No longer available?
import processing.pdf.*;
//PDF library reference: https://processing.org/reference/libraries/pdf/index.html
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/

boolean savePDF = false;

int maxCount = 10000;
int currentCount = 1;

float[] x = new float[maxCount];//x coordinate
float[] y = new float[maxCount];//y coordinate
float[] r = new float[maxCount];//Radius

int[] closestIndex = new int[maxCount];

float minRadius = 3;
float maxRadius = 50;

//for mouse and arrow up/down interaction
float mouseRect = 30;

void setup(){
  size(800, 800);
  smooth();
  noFill();
  cursor(CROSS);
  //frameRate(2);//To see the prosess easily.
  
  //First circle
  x[0] = random(0+maxRadius, width-maxRadius);;
  y[0] = random(0+maxRadius, height-maxRadius);
  r[0] = random(minRadius, maxRadius);
}

void draw(){
  if(savePDF){
      beginRecord(PDF, timestamp()+".pdf");
  }
  background(255);
  
  strokeWeight(0.5);
  
  //Create a random set of parameters
  float newR = minRadius; //New radius
  float newX = random(0+maxRadius, width-maxRadius);//New x coordinate at somewhere in the Canvas
  float newY = random(0+maxRadius, height-maxRadius);//New y coordinate at somewhere in the Canvas

  //Create a random position according to mouse position
  if(mousePressed){
    newX = random(mouseX - mouseRect/2, mouseX + mouseRect/2);
    newY = random(mouseY - mouseRect/2, mouseY + mouseRect/2);
    newR = 1;
  }
  
  boolean intersection = false;
  
  //Calculate, if new circle intersects with one of the others
  for(int i=0; i<currentCount; i++){
    float d = dist(newX, newY, x[i], y[i]);
    if(d < newR + r[i]){
      intersection = true;
      break; //If intersects, don't make new one at that position.
    }
  }
  
  //If no intersect, add a new circle
  if(intersection == false){
    //Get closest neighbour and find out possible biggest radius
    float newRadius = width;
    for(int i=0; i<currentCount; i++){
      float d = dist(newX, newY, x[i], y[i]);
      if(newRadius > d-r[i]){
        newRadius = d-r[i];
        closestIndex[currentCount] = i;
      }
    }
    
    if(newRadius > maxRadius) newRadius = maxRadius;
    x[currentCount] = newX;
    y[currentCount] = newY;
    r[currentCount] = newRadius;
    currentCount++;
  }
  
  //Draw them
  for(int i=0; i<currentCount; i++){
    stroke(0);
    strokeWeight(1.5);
    ellipse(x[i], y[i], r[i]*2, r[i]*2);
    
    stroke(226, 185, 0);
    strokeWeight(0.75);
    int c = closestIndex[i];
    line(x[i], y[i], x[c], y[c]);
  }
  
  if(mousePressed){
    stroke(255, 200, 0);
    strokeWeight(2);
    rect(mouseX-mouseRect/2, mouseY-mouseRect/2, mouseRect, mouseRect);
  }
  
  if(currentCount >= maxCount) noLoop();
  
}


void keyReleased(){
  //No longer available?
  //if(key == 'c') GenerativeDesign.saveASE(this, colors, timestamp()+".ase");
  if(key == 's') saveFrame(timestamp()+"_##.png");
  if(key == 'p') savePDF = true;
  
  // mouseRect ctrls arrowkeys up/down 
  if (keyCode == UP) mouseRect += 4;
  if (keyCode == DOWN) mouseRect -= 4; 
  
}



String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
