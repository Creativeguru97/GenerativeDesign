//import generativedesign.*;//No longer available?
import processing.pdf.*;
//PDF library reference: https://processing.org/reference/libraries/pdf/index.html
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/

boolean savePDF = false;

int tileCountX = 2;
int tileCountY = 10;

color[] colorsLeft = new color[tileCountY];
color[] colorsRight = new color[tileCountY];
color[] colors;

boolean interpolateShortest = true;

void setup(){
  size(800, 800);
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
  shakeColors();
}

void draw(){
  // this line will start pdf export, if the variable savePDF was set to true 
  //If statement is only one code, we can write like this below.
  if (savePDF) {
    beginRecord(PDF, timestamp()+".pdf");
    colorMode(HSB, 360, 100, 100, 100);
    noStroke(); 
  }
  
  tileCountX = (int)map(mouseX, 0, width, 2, 100);
  tileCountY = (int)map(mouseY, 0, height, 2, 10);
  
  float tileWidth = width / (float)tileCountX;
  float tileHeight = height / (float)tileCountY;
  color interCol;
  
  for (int gridY = 0; gridY < tileCountY; gridY++){
    color col1 = colorsLeft[gridY];
    color col2 = colorsRight[gridY];
    
    for (int gridX = 0; gridX < tileCountX; gridX++){
      float amount = map(gridX, 0, tileCountX-1, 0, 1);
      
      if(interpolateShortest){
        //switch to RGB mode
        colorMode(RGB, 255, 255, 255, 255);
        interCol = lerpColor(col1, col2, amount);
        //switch back to HSB mode
        colorMode(HSB, 360, 100, 100, 100);
      }else{
        interCol = lerpColor(col1, col2, amount);
      }
      //About lerpColor(): https://processing.org/reference/lerpColor_.html
      
      fill(interCol);
      
      float posX = tileWidth*gridX;
      float posY = tileHeight*gridY;
      rect(posX, posY, tileWidth, tileHeight);
    }
    
  }
  
  //end of pdf recording
  if(savePDF){
    savePDF = false;
    endRecord();
  }
   
}

void shakeColors(){
  for(int i=0; i < tileCountY; i++){
    colorsLeft[i] = color(random(0, 60), random(0, 100), 100);
    colorsRight[i] = color(random(160, 190), 100, random(0, 100));
  }
}

void mousePressed(){
  shakeColors();
}


void keyPressed(){
  //No longer available?
  //if(key == 'c') GenerativeDesign.saveASE(this, colors, timestamp()+".ase");
  if(key == 's') saveFrame(timestamp()+"_##.png");
  if(key == 'p') savePDF = true;
  
  if(key == '1') interpolateShortest = true;
  if(key == '2') interpolateShortest = false;
}

String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
