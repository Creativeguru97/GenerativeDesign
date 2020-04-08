//import generativedesign.*;//No longer available?
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/
    
int pointCount;

int freqX = 1;
int freqY = 4;
float phi = 60;

int modFreqX = 12;
int modFreqY = 1;
float modulationPhi = 0;

float angle;
float x, y;
float w, maxDist;
float oldX, oldY;

int drawMode = 2;


void setup(){
  size(600, 600);
  smooth();
  strokeCap(ROUND);
  
  maxDist = sqrt(sq(width/2-50) + sq(height/2-50));
}

void draw(){
  background(255);
  
  translate(width/2, height/2);
  pointCount = mouseX * 2 + 200;
  
  if(drawMode == 1){
    stroke(0);
    strokeWeight(1);
    
    beginShape();
    for(int i=0; i<=pointCount; i++){
      angle = map(i, 0, pointCount, 0, TWO_PI);
      
      x = sin(angle * freqX + radians(phi)) * cos(angle * modFreqX);
      y = sin(angle * freqY) * cos(angle * modFreqY);
      
      x = x * (width / 2 - 50);
      y = y * (height / 2 - 50);
      
      vertex(x, y);
    }
    endShape();
  }else if(drawMode == 2){
    strokeWeight(8);
    
    for(int i=0; i<=pointCount; i++){
      angle = map(i, 0, pointCount, 0, TWO_PI);
      
      x = sin(angle * freqX + radians(phi)) * cos(angle * modFreqX);
      y = sin(angle * freqY) * cos(angle * modFreqY);
      
      x = x * (width / 2 - 50);
      y = y * (height / 2 - 50);
      
      if(i > 0){
        w = dist(x, y, 0, 0);
        float lineAlpha = map(w, 0, maxDist, 255, 0);
        stroke(i%2*2, lineAlpha);
        line(oldX, oldY, x, y);
      }
      
      oldX = x;//store the previous value;
      oldY = y;
    }
  }
  
}

void drawAnimation(){
 
}

void keyPressed(){
  if(key == 's') saveFrame(timestamp()+"_##.png");
  
  if (key == '1') drawMode = 1;
  if (key == '2') drawMode = 2;
  
  if (key == '3') freqX--;
  if (key == '4') freqX++;
  freqX = max(freqX, 1);//To not to down below 1;
  
  if (key == '5') freqY--;
  if (key == '6') freqY++;
  freqY = max(freqY, 1);//To not to down below 1;
  
  if(key == '7') modFreqX--;
  if(key == '8') modFreqX++;
  modFreqX = max(modFreqX, 1);
  
  if(key == '9') modFreqY--;
  if(key == '0') modFreqY++;
  modFreqY = max(modFreqY, 1);
  
  if (keyCode == LEFT) phi -= 15;
  if (keyCode == RIGHT) phi += 15;
}


String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
