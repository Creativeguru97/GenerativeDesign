//import generativedesign.*;//No longer available?
import processing.pdf.*;
//PDF library reference: https://processing.org/reference/libraries/pdf/index.html
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/

boolean savePDF = false;

int maxCount = 5000;
int currentCount = 1;

float[] x = new float[maxCount];//x coordinate
float[] y = new float[maxCount];//y coordinate
float[] r = new float[maxCount];//Radius


void setup(){
  size(600, 600);
  smooth();
  //frameRate(2);//To see the prosess easily.
  
  //First circle
  x[0] = width/2;
  y[0] = height/2;
  r[0] = 1;
}

void draw(){
  if(savePDF){
      beginRecord(PDF, timestamp()+".pdf");
  }
  background(255);
  
  strokeWeight(0.5);
  
  //Create a random set of parameters
  float newR = random(1, 3); //New radius
  float newX = random(0+newR, width-newR);//New x coordinate at somewhere in the Canvas
  float newY = random(0+newR, height-newR);//New y coordinate at somewhere in the Canvas
  
  float closestDist = 100000000;
  int closestIndex = 0;
  
  //Calculate which circle is the closest.
  for(int i=0; i<currentCount; i++){
    float newDist = dist(newX, newY, x[i], y[i]);
    if(newDist < closestDist){
      closestDist = newDist;
      closestIndex = i;
    }
  }
  
  //Show random position and line
  fill(230);
  ellipse(newX, newY, newR*2, newR*2);
  line(newX, newY, x[closestIndex], y[closestIndex]);
  
  float angle = atan2(newY - y[closestIndex], newX - x[closestIndex]);
  //atan2(): https://processing.org/reference/atan2_.html
  
  /*
  Polor coordinate system
    x = r * cos(theta)
    r = r * sin(theta)
  */
  x[currentCount] = x[closestIndex] + cos(angle) * (r[closestIndex]+newR);
  y[currentCount] = y[closestIndex] + sin(angle) * (r[closestIndex]+newR);
  r[currentCount] = newR;
  currentCount++;
  
  //Draw them
  for(int i=0; i<currentCount; i++){
    fill(50);
    ellipse(x[i], y[i], r[i]*2, r[i]*2);
  }
  
  if(currentCount >= maxCount) noLoop();
  
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
