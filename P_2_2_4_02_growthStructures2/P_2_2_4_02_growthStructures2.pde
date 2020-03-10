//import generativedesign.*;//No longer available?
import processing.pdf.*;
//PDF library reference: https://processing.org/reference/libraries/pdf/index.html
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/

boolean savePDF = false;

int maxCount = 12000;
int currentCount = 1;

float[] newx = new float[maxCount];
float[] newy = new float[maxCount];

float[] x = new float[maxCount];//x coordinate
float[] y = new float[maxCount];//y coordinate
float[] r = new float[maxCount];//Radius

boolean drawGhosts = false;


void setup(){
  size(800, 800);
  smooth();
  //frameRate(2);//To see the prosess easily.
  
  //First circle
  x[0] = width/2;
  y[0] = height/2;
  r[0] = 360;
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
  
  float angle = atan2(newY - y[closestIndex], newX - x[closestIndex]);
  //atan2(): https://processing.org/reference/atan2_.html
  
  //Copy current newX and newY to show all later
  newx[currentCount] = newX;
  newy[currentCount] = newY;
  
  /*
  Polor coordinate system
    x = r * cos(theta)
    r = r * sin(theta)
  */
  x[currentCount] = x[closestIndex] + cos(angle) * (r[closestIndex]+newR);
  y[currentCount] = y[closestIndex] + sin(angle) * (r[closestIndex]+newR);
  r[currentCount] = newR;
  currentCount++;
  
  if(drawGhosts){
    for(int i=0; i<currentCount; i++){
      fill(230);
      ellipse(newx[i], newy[i], r[i]*2, r[i]*2);
      line(newx[i], newy[i], x[i], y[i]);
    }
  }
  
  //Draw them
  for(int i=0; i<currentCount; i++){
    if(i == 0){
      noFill();
      noStroke();
    }else{
      fill(50);
    };
    ellipse(x[i], y[i], r[i]*2, r[i]*2);
  }
  
  if(currentCount >= maxCount) noLoop();
  
}


void keyReleased(){
  //No longer available?
  //if(key == 'c') GenerativeDesign.saveASE(this, colors, timestamp()+".ase");
  if(key == 's') saveFrame(timestamp()+"_##.png");
  if(key == 'p') savePDF = true;
  
  if(key == '1') drawGhosts = !drawGhosts;
}



String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
