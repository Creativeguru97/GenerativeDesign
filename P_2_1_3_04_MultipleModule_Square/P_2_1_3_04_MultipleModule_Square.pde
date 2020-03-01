//import generativedesign.*;//No longer available?
import processing.pdf.*;
//PDF library reference: https://processing.org/reference/libraries/pdf/index.html
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/

boolean savePDF = false;

float tileCountX = 6;
float tileCountY = 6;
float tileWidth, tileHeight;
float posX, posY;


int count = 0;
int lineWeight;

int drawMode = 1;

void setup(){
  size(600, 600);
}

void draw(){
  if(savePDF){
    beginRecord(PDF, timestamp()+".pdf");
  }
  
  colorMode(HSB, 360, 100, 100, 100);
  rectMode(CENTER);
  smooth();
  stroke(0);
  noFill();
  background(360);
  strokeWeight(0.5);
  
  count = mouseX/10 + 10;//Range of 10 to 70
  float para = float(mouseY)/height;//Range of 0 to 1
  
  for(int gridY = 0; gridY <= tileCountY; gridY++){
    for(int gridX = 0; gridX <= tileCountX; gridX++){
      
      tileWidth = width / tileCountX;
      tileHeight = height / tileCountY;
      posX = tileWidth * gridX + tileWidth/2;
      posY = tileHeight * gridY + tileHeight/2;
      
      pushMatrix();
      translate(posX, posY);
      
      //Switch between modules
      if(drawMode == 1){
        for(int i=0; i<count; i++){
          rect(0, 0, tileWidth, tileHeight);
          scale(1 - 3.0/count);
          rotate(para*0.1);
        }
      }else if(drawMode == 2){
        for(float i=0; i<count; i++){
          noStroke();
          color gradient = lerpColor(color(0), color(52, 100, 71), i/count);
          /*
          lerpColor(c1, c2, amt)
          
          Calculates a color between two colors at a specific increment. 
          The amt parameter is the amount to interpolate between the two values 
          where 0.0 is equal to the first point, 0.1 is very near the first point, 
          0.5 is halfway in between, etc. 
          */
          fill(gradient, i/count*200);
          rotate(QUARTER_PI);
          rect(0, 0, tileWidth, tileHeight);
          scale(1 - 3.0/count);//More the count bigger, less subtracted scale.
          rotate(para*1.5);
        }
      }else if(drawMode == 3){
        colorMode(RGB, 255);
        for(float i=0; i<count; i++){
          noStroke();
          color gradient = lerpColor(color(0, 130, 164), color(0), i/count);
          fill(gradient, 170);
          
          pushMatrix();
          translate(4*i, 0);
          ellipse(0, 0, tileWidth, tileHeight);
          popMatrix();
          
          pushMatrix();
          translate(-4*i, 0);
          ellipse(0, 0, tileWidth, tileHeight);
          popMatrix();
          
          scale(1 - 1.5/count);
          rotate(para*1.5);
        }
      }
      popMatrix();
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
  if (key == '3') drawMode = 3;
  
}



String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
