//import generativedesign.*;//No longer available?
import processing.pdf.*;
//PDF library reference: https://processing.org/reference/libraries/pdf/index.html
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/

boolean savePDF = false;

int formResolution = 15;
int stepSize = 2;
float distortionFactor = 1;
float initRadius = 150;
float centerX, centerY;
float[] x = new float [formResolution];
float[] y = new float [formResolution];

boolean filled = false;
boolean freeze = false;

int drawMode = 1;

void setup(){
  size(displayWidth, displayHeight);
  smooth();
  
  //Init form
  centerX = width/2;
  centerY = height/2;
  
  //Detamine each angle of point on polor coordinate
  float angle = radians(360/float(formResolution));
  for(int i=0; i<formResolution; i++){
    x[i] = cos(angle*i)*initRadius;
    y[i] = sin(angle*i)*initRadius;
  }
  
  stroke(0, 50);
  background(255);
}

void draw(){
  
  //Calculate new point
  for(int i=0; i<formResolution; i++){
    x[i] += random(-stepSize, stepSize);
    y[i] += random(-stepSize, stepSize); 
  }
  
  strokeWeight(0.75);
  if(filled) fill(random(255));
  else noFill();
  
  //Floating towards mouse position
  if(mouseX != 0 || mouseY != 0){
    centerX += (mouseX-centerX) * 0.01;
    centerY += (mouseY-centerY) * 0.01;
  }
  
  if(drawMode == 1){
    beginShape();
    //start control point
    curveVertex(x[formResolution-1]+centerX, y[formResolution-1]+centerY);
    //About curveVertex(): https://processing.org/reference/curveVertex_.html
    
    for(int i=0; i<formResolution; i++){
      curveVertex(x[i]+centerX, y[i]+centerY);
      //ellipse(x[i]+centerX, y[i]+centerY, 5, 5);
    }
    
    curveVertex(x[0]+centerX, y[0]+centerY);
    
    //end controlpoint
    curveVertex(x[1]+centerX, y[1]+centerY);
    endShape();
  }else if(drawMode == 2){
    beginShape();
    //start control point
    curveVertex(x[0]+centerX, y[0]+centerY);
    
    //Only these points are drawn
    for(int i=0; i<formResolution; i++){
      curveVertex(x[i]+centerX, y[i]+centerY);
    }
    
    //end point control
    curveVertex(x[formResolution-1]+centerX, y[formResolution-1]+centerY);
    endShape();
  }
}

//Events
void mousePressed(){
  
  if(drawMode == 1){
    // init forms on mouse position
    centerX = mouseX;
    centerY = mouseY;
  
    float angle = radians(360/float(formResolution));
    float radius = initRadius * random(0.5, 1.0);
    for(int i=0; i<formResolution; i++){
      x[i] = cos(angle*i)*radius;
      y[i] = sin(angle*i)*radius;
    }
  }else if(drawMode == 2){
    // init forms on mouse position
    centerX = mouseX;
    centerY = mouseY;
    
    float radius = initRadius * random(0.5, 5.0);
    float angle = random(PI);
    radius = initRadius * 4;
    angle = 0;
    
    float x1 = cos(angle) * radius;
    float y1 = sin(angle) * radius;
    float x2 = cos(angle-PI) * radius;
    float y2 = sin(angle-PI) * radius;
    
    for(int i=0; i<formResolution; i++){
      x[i] = lerp(x1, x2, i/float(formResolution));
      y[i] = lerp(y1, y2, i/float(formResolution));
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
  if (key == '3') filled = false;
  if (key == '4') filled = true;
}



String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
