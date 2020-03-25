//import generativedesign.*;//No longer available?
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/

int actRandomSeed = 0;

void setup(){
size(512,512);
smooth();
}


void draw(){
  background(0);
  
  randomSeed(actRandomSeed);
  
  loadPixels();
  for(int x=0; x<width; x++){
    for(int y=0; y<height; y++){
      float randomValue = random(255);
      pixels[x+y*width] = color(randomValue);
    }
  }
  updatePixels();
  //actRandomSeed = int(random(100000));
}

void mouseReleased(){//This is the way to implement mouse drag!!!!!
  actRandomSeed = int(random(100000));
}

void keyReleased(){
  if(key == 's') saveFrame(timestamp()+"_##.png");
}


String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
