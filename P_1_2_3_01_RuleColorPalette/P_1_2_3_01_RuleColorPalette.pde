//import generativedesign.*;//No longer available?
import processing.pdf.*;
//PDF library reference: https://processing.org/reference/libraries/pdf/index.html
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/

boolean savePDF = false;

int tileCountX = 50;
int tileCountY = 10;
int [] hueValues = new int[tileCountX];
int [] saturationValues = new int[tileCountX];
int [] brightnessValues = new int[tileCountX];

void setup(){
  size(800, 800);
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
  
  for(int i = 0; i < tileCountX; i++){
    hueValues[i] = int(random(0, 360));
    saturationValues[i] = int(random(0, 100));
    brightnessValues[i] = int(random(0, 100));
  }
}

void draw(){
  if(savePDF){
    beginRecord(PDF, timestamp()+".pdf");
    colorMode(HSB, 360, 100, 100, 100);
    noStroke();
  }
  
  background(0, 0, 100);//White background
  
  //Count every tile
  int counter = 0;
  
  //map mouse to grid resolution
  int currentTileCountX = int(map(mouseX, 0, width, 1, tileCountX));
  int currentTileCountY = int(map(mouseY, 0, height, 1, tileCountY));
  float tileWidth = width / float(currentTileCountX);
  float tileHeight = width / float(currentTileCountY);
  
  for(int gridY = 0; gridY < tileCountY; gridY++){
    for(int gridX = 0; gridX < tileCountX; gridX++){
      float posX = tileWidth * gridX;
      float posY = tileHeight * gridY;
      int index = counter % currentTileCountX;
      
      //Get component color values
      fill(hueValues[index], saturationValues[index], brightnessValues[index]);
      rect(posX, posY, tileWidth, tileHeight); 
      counter++;
    }
  }
  
  
  
  if(savePDF){
    savePDF = false;
    endRecord();
  }
  
}


void keyReleased(){
  //No longer available?
  //if(key == 'c') GenerativeDesign.saveASE(this, colors, timestamp()+".ase");
  if(key == 's') saveFrame(timestamp()+"_##.png");
  if(key == 'p') savePDF = true;
  
  if(key == '1'){
    for(int i = 0; i < tileCountX; i++){
      hueValues[i] = int(random(0, 360));
      saturationValues[i] = int(random(0, 360));
      brightnessValues[i] = int(random(0, 360));
    }
  }else if(key == '2'){
    for(int i = 0; i < tileCountX; i++){
      hueValues[i] = int(random(0, 360));
      saturationValues[i] = int(random(0, 360));
      brightnessValues[i] = 100;
    }
  }else if(key == '3'){
    for(int i = 0; i < tileCountX; i++){
      hueValues[i] = int(random(0, 360));
      saturationValues[i] = 100;
      brightnessValues[i] = int(random(0, 360));
    }
  }else if(key == '4'){
    for(int i = 0; i < tileCountX; i++){
      hueValues[i] = 0;
      saturationValues[i] = 0;
      brightnessValues[i] = (int) random(0,100);
    }
  }else if(key == '5'){
    for(int i = 0; i < tileCountX; i++){
      hueValues[i] = 195;
      saturationValues[i] = 100;
      brightnessValues[i] = (int) random(0,100);
    }
  }else if(key == '6'){
    for(int i = 0; i < tileCountX; i++){
      hueValues[i] = 195;
      saturationValues[i] = (int) random(0,100);
      brightnessValues[i] = 100;
    }
  }else if(key == '7'){
    for(int i = 0; i < tileCountX; i++){
      hueValues[i] = (int) random(0,180);
      saturationValues[i] = (int) random(80,100);
      brightnessValues[i] = (int) random(50,90);
    }
  }else if(key == '8'){
    for(int i = 0; i < tileCountX; i++){
      hueValues[i] = (int) random(180,360);
      saturationValues[i] = (int) random(80,100);
      brightnessValues[i] = (int) random(50,90);
    }
  }else if(key == '9'){
    for(int i = 0; i < tileCountX; i++){
      hueValues[i] = (int) random(180,360);
      saturationValues[i] = (int) random(80,100);
      brightnessValues[i] = (int) random(50,90);
    }
  }
  
}



String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
