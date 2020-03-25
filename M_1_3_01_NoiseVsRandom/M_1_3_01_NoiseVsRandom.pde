//import generativedesign.*;//No longer available?
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/


void setup(){
  size(1024, 256);
  smooth();
}


void draw(){
  background(255);
  
  //line
  stroke(0, 130, 164);
  strokeWeight(1);
  strokeJoin(ROUND);
  noFill();
  
  int noiseXRange = mouseX/10;
  println("noiseXRange: 0-"+noiseXRange);
  
  beginShape();
  for(int x=0; x<width; x+=10){
    float noiseX = map(x, 0, width, 0, noiseXRange);
    float y = noise(noiseX) * height;
    vertex(x, y);
  }
  endShape();
  
  //Dots
  noStroke();
  fill(0);
  
  for(int x=0; x<width; x+=10){
    float noiseX = map(x, 0, width, 0, noiseXRange);
    float y = noise(noiseX) * height;
    ellipse(x, y, 3, 3);
  }
}

void mousePressed(){//This is the way to implement mouse drag!!!!!
  noiseSeed((int) random(100000));
}

void keyReleased(){
  if(key == 's') saveFrame(timestamp()+"_##.png");
}


String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
