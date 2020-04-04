//import generativedesign.*;//No longer available?
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/
    
int pointCount;

int freq = 2;
float phi = 0;
float modFreq = 12;

boolean drawFrequency = true;
boolean drawModulation = true;
boolean drawCombination = true;

float angle;
float y;

void setup(){
  size(800, 400);
  smooth();
  
  pointCount = width;
}

void draw(){
  background(255);
  strokeWeight(1);
  noFill();
  
  translate(0, height/2);
  
  //Draw oscillator with freq and phi
  if(drawFrequency){
    stroke(0, 130, 164);
    beginShape();
    for(int i=0; i<=pointCount; i++){
      angle = map(i, 0, pointCount, 0, TWO_PI);
      y = sin(angle * freq + radians(phi));
      y = y * (height / 4);
      vertex(i, y);
    }
    endShape();
  }
  
  //Draw oscillator with modFreq
  if(drawModulation){
    stroke(0, 130, 164, 128);
    beginShape();
    for(int i=0; i<=pointCount; i++){
      angle = map(i, 0, pointCount, 0, TWO_PI);
      y = cos(angle * modFreq);
      y = y * (height / 4);
      vertex(i, y);
    }
    endShape();
  }
  
  //Draw both combined
  stroke(0);
  strokeWeight(2);
  beginShape();
  for(int i=0; i<=pointCount; i++){
      angle = map(i, 0, pointCount, 0, TWO_PI);
      
      float info = sin(angle * freq + radians(phi));
      float carrier = cos(angle * modFreq);
      
      y = info * carrier;
      y = y * (height / 4);
      vertex(i, y);
  }
  endShape();
}

void drawAnimation(){
 
}

void keyPressed(){
  if(key == 's') saveFrame(timestamp()+"_##.png");
  
  if (key == 'f' || key == 'F') drawFrequency = !drawFrequency;
  if (key == 'm' || key == 'M') drawModulation = !drawModulation;
  
  if (key == '1') freq--;
  if (key == '2') freq++;
  if (key == '3') modFreq--;
  if (key == '4') modFreq++;
  freq = max(freq, 1);//To not to down below 1;
  
  if (keyCode == LEFT) phi -= 15;
  if (keyCode == RIGHT) phi += 15;
}


String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
