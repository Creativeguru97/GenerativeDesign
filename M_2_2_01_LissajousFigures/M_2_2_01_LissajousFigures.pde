//import generativedesign.*;//No longer available?
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/
    
int pointCount = 600;
int freqX = 13;
int freqY = 23;

float phi = 90;

float angle;
float x, y;
float factorX, factorY;

boolean doDrawAnimation = true;

int margin = 25;

void setup(){
  size(600, 600);
  smooth();
}

void draw(){
  background(255);
  stroke(0);
  strokeWeight(1);
  
  if(doDrawAnimation){
    translate(width * 3/4.0, height * 3/4.0);
    factorX = width / 4 - margin;
    factorY = height / 4 - margin;
  }else{
    translate(width/2, height/2);
    factorX = width / 2 - margin;
    factorY = height / 2 - margin;
  }
  
  //Draw oscillator curve
  beginShape();
  for (int i=0; i<=pointCount; i++){
    angle = map(i, 0, pointCount, 0, TWO_PI);
    
    x = sin(angle * freqX + radians(phi));
    y = sin(angle * freqY);
    
    x = x * factorX;
    y = y * factorY;
    
    vertex(x, y);
  }
  
  endShape();
  
  if(doDrawAnimation){
    drawAnimation();
  }
}

void drawAnimation(){
  pushStyle();
  noFill();
  
  //Draw x oscillator
  stroke(0);
  beginShape();
  for(int i = 0; i <= pointCount; i++){
    angle = map(i, 0, pointCount, 0, TWO_PI);
    x = sin(angle * freqX + radians(phi));
    x = x * (width/4 - margin);
    y = -height * 2/3.0 - margin + float(i) / pointCount * (height / 2 - 2 * margin);
    
    vertex(x, y);
  }
  endShape();
  
  //Draw y oscillator
  stroke(0);
  beginShape();
  for(int i = 0; i <= pointCount; i++){
    angle = map(i, 0, pointCount, 0, TWO_PI);
    y = sin(angle * freqY);
    y = y * (height/4 - margin);
    x = - width * 2/3.0 - margin + float(i) / pointCount * (width / 2 - 2 * margin);
    
    vertex(x, y);
  }
  endShape();
  
  angle = map(frameCount, 0, pointCount, 0, TWO_PI);
  x = sin(angle * freqX + radians(phi));
  y = sin(angle * freqY);
  
  x = x * (width / 4 - margin);
  y = y * (height / 4 - margin);
  
  float oscYx = -width*2/3.0 - margin + (angle/TWO_PI)%1 * (width/2 - 2 * margin);
  float oscXy = -height*2/3.0 - margin + (angle/TWO_PI)%1 * (height/2 - 2 * margin);
  
  stroke(0, 80);
  line(x, oscXy, x, y);//horizontal line
  line(oscYx, y, x, y);//vertical line
  
  fill(0);
  stroke(255);
  strokeWeight(2);
  
  ellipse(x, oscXy, 8, 8);
  ellipse(oscYx, y, 8, 8);
  
  ellipse(x, y, 10, 10);
  
  popStyle();
  
}

void keyPressed(){
  if(key == 's') saveFrame(timestamp()+"_##.png");
  if (key == 'a' || key == 'A') doDrawAnimation = !doDrawAnimation;
  
  if (key == '1') freqX--;
  if (key == '2') freqX++;
  freqX = max(freqX, 1);//To not to down below 1;
  
  if (keyCode == LEFT) phi -= 15;
  if (keyCode == RIGHT) phi += 15;
}


String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
