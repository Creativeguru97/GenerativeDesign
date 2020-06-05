//import generativedesign.*;//No longer available?
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/
    
int pointCount;
int freq = 6;
float phi = 0;

float angle;
float y;

boolean doDrawAnimation = true;

void setup(){
  size(800, 400);
  smooth();
}

void draw(){
  background(255);
  stroke(0);
  strokeWeight(1);
  noFill();
  
  if(doDrawAnimation){
    pointCount = width-250;
    translate(250, height/2);
  }else{
    pointCount = width;
    translate(0, height/2);
  }
  
  //Draw oscillator curve
  beginShape();
  for (int i=0; i<=pointCount; i++){
    angle = map(i, 0, pointCount, 0, TWO_PI);
    y = sin(angle * freq + radians(phi));
    vertex(i, y*100);
  }
  
  endShape();
  
  if(doDrawAnimation){
    drawAnimation();
  }
}

void drawAnimation(){
  //Draw circle, dots and lines
  float t = (float(frameCount)/pointCount) % 1;
  angle = map(t, 0, 1, 0, TWO_PI);
  
  float x = cos(angle * freq + radians(phi));
  y = sin(angle * freq + radians(phi));//Global variable
  x = x * 100 -125;
  y = y * 100;
  
  //Circle
  strokeWeight(1);
  ellipse(-125, 0, 200, 200);
  line(-225, 0, -25, 0); //x axis in circle
  line(-125, -100, -125, 100);//y axis in circle
  line(x, y, -125, 0);//Connecting Centre to moving point
  
  //Lines
  stroke(0, 128);
  line(0, -100, 0, 100); //y axis on sin curve
  line(0, 0, pointCount, 0); //x axis sin curve
  
  stroke(0, 130, 164);
  strokeWeight(2);
  line(t * pointCount, y, t * pointCount, 0);
  line(x, y, x, 0);
  
  float phiX = cos(radians(phi)) * 100-125;
  float phiY = sin(radians(phi)) * 100;
  
  //Phi line
  strokeWeight(1);
  stroke(0, 128);
  line(-125, 0, phiX, phiY);
  
  //phi dots
  fill(0);
  stroke(255);
  strokeWeight(2);
  ellipse(0, phiY, 8, 8);
  ellipse(phiX, phiY, 8, 8);
  
  //Dot on curve
  ellipse(t * pointCount, y, 10, 10);
  
  //Dot on circle
  ellipse(x, y, 10, 10);
}

void keyPressed(){
  if(key == 's') saveFrame(timestamp()+"_##.png");
  if (key == 'a' || key == 'A') doDrawAnimation = !doDrawAnimation;
  
  if (key == '1') freq--;
  if (key == '2') freq++;
  freq = max(freq, 1);//To not to down below 1;
  
  if (keyCode == LEFT) phi -= 15;
  if (keyCode == RIGHT) phi += 15;
}


String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
