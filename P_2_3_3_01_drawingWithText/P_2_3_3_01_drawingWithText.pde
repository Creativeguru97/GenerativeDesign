//import generativedesign.*;//No longer available?
import processing.pdf.*;
//PDF library reference: https://processing.org/reference/libraries/pdf/index.html
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/

boolean savePDF = false;

float x = 0, y = 0;
float stepSize = 5.0;

PFont font;
String letters = "Coding is very fun, why you still haven't started?  ";
int fontSizeMin = 3;
float angleDistortion = 0.0;

int counter = 0;

void setup(){
  size(displayWidth, displayHeight);
  background(255);
  smooth();
  cursor(CROSS);
  
  font = createFont("American Typewriter", 10);
  textFont(font, fontSizeMin);
  textAlign(LEFT);
  fill(0);
}

void draw(){
  if(mousePressed){
    float d = dist(x, y, mouseX, mouseY);//Calsulete distance mouse moved since last frame.
    textFont(font, fontSizeMin+d/2);//Decide size from the distance.
    char newLetter = letters.charAt(counter);//A "counter"-th character in the "letters" sentence.
    stepSize = textWidth(newLetter);
    
    if(d > stepSize){
      float angle = atan2(mouseY-y, mouseX-x);//I love this function, Very intersting!!!
      
      pushMatrix();
      translate(x, y);//Move coordinate origin
      rotate(angle + random(angleDistortion));
      text(newLetter, 0, 0);//Draw a character on the new origin.
      popMatrix();
      
      counter++;
      if(counter > letters.length()-1) counter = 0;//If reached to end of the sentence, go back to the head.
      
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
  
}

void keyPressed(){
  if(keyCode == UP) angleDistortion += 0.1;
  if(keyCode == DOWN) angleDistortion -= 0.1;
}



String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
