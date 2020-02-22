//import generativedesign.*;//No longer available?
import processing.pdf.*;
//PDF library reference: https://processing.org/reference/libraries/pdf/index.html
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/

boolean savePDF = false;

int tileCount = 20;
int actRandomSeed = 0;

int actStrokeCap = ROUND;

void setup(){
  size(600, 600);
}

void draw(){
  if(savePDF){
    beginRecord(PDF, timestamp()+".pdf");
  }
  
  background(255);
  smooth();
  noFill();
  strokeCap(actStrokeCap);
  
  randomSeed(actRandomSeed);
  
  for(int gridY = 0; gridY < tileCount; gridY++){
    for(int gridX = 0; gridX < tileCount; gridX++){
      int posX = width / tileCount * gridX;
      int posY = width / tileCount * gridY;
      
      int toggle = int(random(0, 2));
      if(toggle == 0){
        strokeWeight(mouseX/20);
        line(posX, posY, posX+width/tileCount, posY+height/tileCount);
      }
      if(toggle == 1){
        strokeWeight(mouseY/20);
        line(posX, posY+width / tileCount, posX+height / tileCount, posY);
      }
      
    }
  }
  
}

void mousePressed(){
  actRandomSeed = int(random(100000));
}


void keyReleased(){
  //No longer available?
  //if(key == 'c') GenerativeDesign.saveASE(this, colors, timestamp()+".ase");
  if(key == 's') saveFrame(timestamp()+"_##.png");
  if(key == 'p') savePDF = true;
  
  
  if (key == '1'){
    actStrokeCap = ROUND;
  }
  if (key == '2'){
    actStrokeCap = SQUARE;
  }
  if (key == '3'){
    actStrokeCap = PROJECT;
  }
  
}



String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
