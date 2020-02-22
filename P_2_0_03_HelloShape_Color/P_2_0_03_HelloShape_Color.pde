//import generativedesign.*;//No longer available?
import processing.pdf.*;
//PDF library reference: https://processing.org/reference/libraries/pdf/index.html
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/

boolean savePDF = false;

color strokeColor = color(0, 20);

void setup(){
  size(800, 800);
  smooth();
  noFill();
  background(255);
}

void draw(){
  if(savePDF){
    beginRecord(PDF, timestamp()+".pdf");
    colorMode(HSB, 360, 100, 100, 100);
    noStroke();
  }
  
  
  if(mousePressed){
    
    pushMatrix();
    translate(width/2,height/2);//Move the origin to center.
    
    int circleResolution = int(map(mouseY+100, 0, height, 3, 12));
    float radius = mouseX - width / 2 + 0.5;
    float angle = TWO_PI / circleResolution;
    
    strokeWeight(2);
    stroke(strokeColor);
    
    noFill();
    beginShape();
    for(int i = 0; i <= circleResolution; i++){
      float x = cos(angle * i) * radius;
      float y = sin(angle * i) * radius;
      
      vertex(x, y);
    }
    endShape();
    
    if(savePDF){
      savePDF = false;
      endRecord();
    }
    
    popMatrix();
  }
  
}


void keyReleased(){
  //No longer available?
  //if(key == 'c') GenerativeDesign.saveASE(this, colors, timestamp()+".ase");
  if(key == 's') saveFrame(timestamp()+"_##.png");
  if(key == 'p') savePDF = true;
  
  if(key == '1'){
    strokeColor = color(0, 20);
  }else if(key == '2'){
    strokeColor = color(192, 100, 64, 10);
  }else if(key == '3'){
    strokeColor = color(52, 100, 71, 10);
  }
  
}



String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
