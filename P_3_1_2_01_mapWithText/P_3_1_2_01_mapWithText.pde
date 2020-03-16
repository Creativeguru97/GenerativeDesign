//import generativedesign.*;//No longer available?
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/

PFont font;
String textTyped = "";

PShape shapeSpace, shapeSpace2, shapePeriod, shapeComma;
PShape shapeQuestionmark, shapeExclamationmark, shapeReturn;

int centerX=0, centerY=0, offsetX=0, offsetY=0;
float zoom = 0.75;

int actRandomSeed = 6;

void setup(){
  size(displayWidth, displayHeight);
  surface.setResizable(true);//Make window resizable! First time to see this funciton for me!!!!!
  
  //Text to begin with
  textTyped += "Ich bin der Musikant mit Taschenrechner in der Hand!\n\n";
  textTyped += "Ich addiere\n";
  textTyped += "Und subtrahiere, \n\n";
  textTyped += "Kontrolliere\nUnd komponiere\nUnd wenn ich diese Taste drück,\nSpielt er ein kleines Musikstück?\n\n";
  
  textTyped += "Ich bin der Musikant mit Taschenrechner in der Hand!\n\n";
  textTyped += "Ich addiere\n";
  textTyped += "Und subtrahiere, \n\n";
  textTyped += "Kontrolliere\nUnd komponiere\nUnd wenn ich diese Taste drück,\nSpielt er ein kleines Musikstück?\n\n";
  
  centerX = width/2;
  centerY = height/2;
  
  font = createFont("miso-bold.ttf", 10);
  
  shapeSpace = loadShape("space.svg");
  shapeSpace2 = loadShape("space2.svg");
  shapePeriod = loadShape("period.svg");
  shapeComma = loadShape("comma.svg");
  shapeExclamationmark = loadShape("exclamationmark.svg");
  shapeQuestionmark = loadShape("questionmark.svg");
  shapeReturn = loadShape("return.svg");
  
  cursor(HAND);
}


void draw(){
  
  background(255);
  smooth();
  noStroke();
  textAlign(LEFT);
  
  if(mousePressed == true){//This is the way to implement mouse drag!!!!!
    centerX = mouseX - offsetX;
    centerY = mouseY - offsetY;
  }
  
  //Allways produce the same sequence of random numbers
  randomSeed(actRandomSeed);
  translate(centerX, centerY);
  scale(zoom);//Change the scale!
  
  for(int i=0; i<textTyped.length(); i++){
    float fontSize = 25;
    textFont(font, fontSize);
    char letter = textTyped.charAt(i);
    float letterWidth = textWidth(letter);
    
    // ----- letter rule table -----
    if(letter == ' '){
      int dir = floor(random(0, 2));
      if(dir == 0){
        shape(shapeSpace, 0, 0);
        translate(1.9, 0);
        rotate(PI/4);
      }else if(dir == 1){
        shape(shapeSpace2, 0, 0);
        translate(13, -5);
        rotate(-PI/4);
      }
    }else if(letter == ','){
      shape(shapeComma, 0, 0);
      translate(34, 15);
      rotate(PI/4);
    }else if(letter == '.'){
       shape(shapePeriod, 0, 0);
      translate(56, -54);
      rotate(-PI/2);
    }else if(letter == '!'){
      shape(shapeExclamationmark, 0, 0);
      translate(42, -17.4);
      rotate(-PI/4);
    }else if(letter == '?'){
      shape(shapeQuestionmark, 0, 0);
      translate(42, -18);
      rotate(-PI/4);
    }else if(letter == '\n'){ // Enter
      shape(shapeReturn, 0, 0);
      translate(0, 10);
      rotate(PI);
    }else{
      fill(0);
      text(letter, 0, 0);
      translate(letterWidth, 0);
    }
  }
  
  // blink cursor after text
  fill(0);
  if (frameCount/6 % 2 == 0) rect(0, 0, 15, 2); 
}

void mousePressed(){//This is the way to implement mouse drag!!!!!
  offsetX = mouseX-centerX;
  offsetY = mouseY-centerY;
}

void keyPressed(){
  if(key != CODED){
    if(key == DELETE){
    }else if(key == BACKSPACE){
      if(textTyped.length() > 0){
        textTyped = textTyped.substring(0, max(0, textTyped.length()-1));//Generate new string removed the last element.
        /*
          substring(): https://processing.org/reference/String_substring_.html
          shorten(): https://processing.org/reference/shorten_.html
        */
      }
    }else if(key == TAB){
    }else if(key == ENTER){
      //println("Enter key was typed!!!");
      textTyped += "\n";
    }else if(key == RETURN){
    }else if(key == ESC){
    }else{
      textTyped += key;//Add character correspond to the key on keyboard.
    }
  }
  
  //Zoom
  if(keyCode == UP) zoom += 0.05;
  if(keyCode == DOWN) zoom -= 0.05;
}

//void keyReleased(){
//  //if(key == 's') saveFrame(timestamp()+"_##.png");
//}


String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
