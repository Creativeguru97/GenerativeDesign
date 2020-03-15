//import generativedesign.*;//No longer available?
import processing.pdf.*;
//PDF library reference: https://processing.org/reference/libraries/pdf/index.html
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/

boolean savePDF = false;

float x = 0, y = 0;
float stepSize = 5.0;
float moduleSize = 25;

PShape lineModule;

void setup(){
  size(displayWidth, displayHeight);
  background(255);
  smooth();
  cursor(CROSS);
  
  lineModule = loadShape("01.svg");
}

void draw(){
  if(mousePressed){
    float d = dist(x, y, mouseX, mouseY);//Calsulete distance mouse moved since last frame.
    
    if(d > stepSize){
      float angle = atan2(mouseY-y, mouseX-x);//I love this function, Very intersting!!!
      
      pushMatrix();
      translate(mouseX, mouseY);//Move coordinate origin
      rotate(angle+PI);
      //shape(lineModule, 0, 0, d, moduleSize);
      shape(lineModule, 0, 0, moduleSize, d);
      /*
        shape(shape, a, b, c, d)
        a: x
        b: y
        c: width
        d: height
      */
      
      popMatrix();
 
      x = x + cos(angle)*stepSize;
      y = y + sin(angle)*stepSize;
    }
  }
}

void mousePressed(){
  x = mouseX;
  y = mouseY;
}



void keyReleased(){
  //No longer available?
  //if(key == 'c') GenerativeDesign.saveASE(this, colors, timestamp()+".ase");
  if(key == 's') saveFrame(timestamp()+"_##.png");
  if(key == 'p') savePDF = true;
  
  if (key == DELETE || key == BACKSPACE) background(255);//Erase all
  
  // load svg for line module
  if (key=='1') lineModule = loadShape("01.svg");
  if (key=='2') lineModule = loadShape("02.svg");
  if (key=='3') lineModule = loadShape("03.svg");
  if (key=='4') lineModule = loadShape("04.svg");
  if (key=='5') lineModule = loadShape("05.svg");
  if (key=='6') lineModule = loadShape("06.svg");
  if (key=='7') lineModule = loadShape("07.svg");
  if (key=='8') lineModule = loadShape("08.svg");
  if (key=='9') lineModule = loadShape("09.svg");
  
}


String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
