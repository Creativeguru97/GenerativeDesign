//import generativedesign.*;//No longer available?
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/


float centerX, centerY;
float offsetX, offsetY;

void setup(){
  size(400, 300);
  
  centerX = width/2;
  centerY = height/2;
}


void draw(){
  background(255);
  smooth();
  
  if(mousePressed == true){//This is the way to implement mouse drag!!!!!
    centerX = mouseX - offsetX;
    centerY = mouseY - offsetY;
  }
  
  translate(centerX, centerY);
  
  noStroke();
  fill(255, 0, 0);
  ellipse(0, 0, 100, 100);
  
 
}

void mousePressed(){//This is the way to implement mouse drag!!!!!
  offsetX = mouseX-centerX;
  offsetY = mouseY-centerY;
}

void keyReleased(){
  if(key == 's') saveFrame(timestamp()+"_##.png");
}


String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
