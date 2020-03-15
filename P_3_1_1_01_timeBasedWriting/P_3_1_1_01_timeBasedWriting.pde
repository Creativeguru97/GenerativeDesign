//import generativedesign.*;//No longer available?
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/

String textTyped = "Type slow and fast!!!";
float[] fontSizes = new float[textTyped.length()];
float minFontSize = 15;
float maxFontSize = 800;
float newFontSize = 0;

int pMillis;
float maxTimeDelta = 10000;

float spacing = 0;

float tracking = 0;
PFont font;

float x = 0, y = 0, fontSize = 20;

void setup(){
  size(800, 600);
  surface.setResizable(true);//Make window resizable! First time to see this funciton for me!!!!!
  
  font = createFont("Arial", 10);
  
  smooth();
  noCursor();
  
  for(int i=0; i<textTyped.length(); i++){
    fontSizes[i] = minFontSize;
  }
  
  pMillis = millis();
}


void draw(){
  
  background(255);
  textAlign(LEFT);
  fill(0);
  noStroke();
  
  spacing = map(mouseY, 0, height, 0, 120);
  translate(0, 100+spacing);//Down origin point
  
  x=0;
  y=0;
  fontSize = 20;
  
  for(int i=0; i<textTyped.length(); i++){
    //Get fontSize for the actual letter from the array
    fontSize = fontSizes[i];
    textFont(font, fontSize);
    char letter = textTyped.charAt(i);
    float letterWidth = textWidth(letter)+tracking;
    
    if(x+letterWidth > width){
      x = 0;
      y += spacing;
    }
    
    //draw letter
    text(letter, x, y);
    //update x-coordinate for next letter
    x += letterWidth;
  }
  
  //Blinking cursor after text
  float timeDelta = millis() - pMillis;
  newFontSize = map(timeDelta, 0, maxTimeDelta, minFontSize, maxFontSize);
  newFontSize = min(newFontSize, maxFontSize);//Prevent the text larger than maxFontSize
  
  fill(200, 30, 40);
  if(frameCount/10 % 2 == 0) fill(255);
  rect(x, y, newFontSize/2, newFontSize/20);
}

void keyPressed(){
  if(key != CODED){
    if(key == DELETE){
    }else if(key == BACKSPACE){
      if(textTyped.length() > 0){
        textTyped = textTyped.substring(0, max(0, textTyped.length()-1));//Generate new string removed the last element.
        fontSizes = shorten(fontSizes);//Shorten one element length.
        /*
          substring(): https://processing.org/reference/String_substring_.html
          shorten(): https://processing.org/reference/shorten_.html
        */
      }
    }else if(key == TAB){
    }else if(key == ENTER){
      //println("Enter key was typed!!!");
    }else if(key == RETURN){
    }else if(key == ESC){
    }else{
      textTyped += key;//Add character correspond to the key on keyboard.
      fontSizes = append(fontSizes, newFontSize);
    }
    
    pMillis = millis();
  }
}

//void keyReleased(){
//  //if(key == 's') saveFrame(timestamp()+"_##.png");
//}


String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
