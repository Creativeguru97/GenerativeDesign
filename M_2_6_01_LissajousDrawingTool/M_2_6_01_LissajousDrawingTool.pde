//import generativedesign.*;//No longer available?
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/
    
    
String backgroundImagePath;
PImage backgroundImage;
float imageAlpha = 30;
float eraserRadius = 20;

//Minimum distance to previously set point
float minDistance = 10;

float zoom = 1;
boolean drawing = false;
boolean shiftDown = false;

int pointCount = 0;
ArrayList pointList = new ArrayList();

boolean invertBackground = false;
float lineWeight = 1;
float lineAlpha = 50;

boolean connectAllPoints = true;
float connectionRadius = 150;

float minHueValue = 0;
float maxHueValue = 100;
float saturationValue = 0;
float brightnessValue = 0;
boolean invertHue = false;

boolean saveOneFrame = false;
boolean savePDF = false;

//----- mouse interaction -----
boolean dragging = false;
float offsetX = 0, offsetY = 0, clickX = 0, clickY = 0, clickOffsetX = 0, clickOffsetY = 0;


void setup(){
  size(800, 800);
  
  smooth();
  background(255);
}

void draw(){
  colorMode(RGB, 255, 255, 255, 100);
  
  pushMatrix();
  translate(width/2, height/2);
  scale(zoom);
  translate(-width/2 + offsetX, -height/2 + offsetY);
  
  color bgColor = color(255);
  color eraserColor = color(0);
  if(invertBackground){
    bgColor = color(0);
    eraserColor = color(255);
  }
  
  //Canvas dragging
  if(dragging){
    offsetX = clickOffsetX + (mouseX - clickX) / zoom;
    offsetY = clickOffsetY + (mouseY - clickY) / zoom;
  }
  
  //Set or delete points
  if(drawing){
    if(keyPressed && keyCode == SHIFT){
      // Shift pressed -> delete points
      
      for(int i=pointList.size()-1; i>=0; i--){
        PVector p = (PVector) pointList.get(i);
        float x = (mouseX - width/2) / zoom - offsetX + width/2;
        float y = (mouseY - height/2) / zoom - offsetY + height/2;
        
        if(dist(p.x, p.y, x, y) <= (eraserRadius/zoom)){
          pointList.remove(i);
        }
      }
      pointCount = pointList.size();
      
    }else{
      //Set points
      
      float x = (mouseX - width/2) / zoom - offsetX + width/2;
      float y = (mouseX - width/2) / zoom - offsetX + width/2;
      
      if(pointCount > 0){
        PVector p = (PVector) pointList.get(pointCount-1);
        if(dist(x, y, p.x, p.y) > (minDistance)){
          pointList.add(new PVector(x, y));
        }
      }else{
        pointList.add(new PVector(x, y));
      }
      pointCount = pointList.size();
    }
  }
  
  //----- draw everything -----
  strokeWeight(lineWeight);
  stroke(0, lineAlpha);
  strokeCap(ROUND);
  noFill();
  tint(255, imageAlpha);
  
  if(!connectAllPoints || shiftDown || dragging){
    background(bgColor);
    if(backgroundImage != null && !saveOneFrame && !savePDF){
      image(backgroundImage, 0, 0);
    }
    
    //Simple drawing method
    colorMode(HSB, 360, 100, 100, 100);
    
    for (int i=1; i<pointCount; i++){
      PVector p1 = (PVector) pointList.get(i-1);
      PVector p2 = (PVector) pointList.get(i);
      drawLine(p1, p2);
      i1++;
    }    
  }else{
    //Drawing method where all points are connected with each other
    //Alpha depends on distance of the points
    
    //Clear background if drawing of the lines will start from the beginning
    
  }
}




void keyPressed(){
  if(key == 's') saveFrame(timestamp()+"_##.png");
  
  
  if (key == '1') freqX--;
  if (key == '2') freqX++;
  freqX = max(freqX, 1);//To not to down below 1;
  
  if (key == '3') freqY--;
  if (key == '4') freqY++;
  freqY = max(freqY, 1);//To not to down below 1;
  
  if (key == '5') modFreqX--;
  if (key == '6') modFreqX++;
  modFreqX = max(modFreqX, 1);//To not to down below 1;
  
  if (key == '7') modFreqY--;
  if (key == '8') modFreqY++;
  modFreqY = max(modFreqY, 1);//To not to down below 1;
  
  if (keyCode == LEFT) phi -= 15;
  if (keyCode == RIGHT) phi += 15;
  
  
  
  calculateLissajousPoints();//Calculate with new values above
  drawLissajous();
}


String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
