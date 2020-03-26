//import generativedesign.*;//No longer available?
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/

int octaves = 4;
float fallOff = 0.5;

float noiseXOffset = 0;
float noiseYOffset = 0;
float noiseXAdd = 0.01;
float noiseYAdd = 0.01;

int seedValue = 0;

int multi = 12;

int noiseMode = 1;

void setup(){
size(960,540);
smooth();
}


void draw(){
  background(0);
  
  /*
    Adjusts the character and level of detail produced by the Perlin noise function.
    Lower octaves contribute more to the output signal and as such define the overall 
    intensity of the noise, whereas higher octaves create finer-grained details in the 
    noise sequence.
  */
  noiseDetail(octaves, fallOff);
  noiseSeed(seedValue);
  
  noiseXAdd += 0.01;
  noiseXOffset = noiseXAdd;
  noiseYAdd += 0.01;
 
  loadPixels();
  for(int x=0; x<width; x++){
    noiseYOffset = noiseYAdd;
    for(int y=0; y<height; y++){
      
      float noiseValue = 0;
      if(noiseMode == 1) noiseValue = noise(noiseXOffset, noiseYOffset) * 255;
      else if(noiseMode == 2) {
        float n = noise(noiseXOffset, noiseYOffset)*multi;
        noiseValue = (n - int(n)) * 255;
        //println(n);
      }
      
      pixels[x+y*width] = color(noiseValue);
      noiseYOffset += 0.01;
    }
    noiseXOffset += 0.01;
  }
  updatePixels();
  
  println("octaves: "+octaves+" falloff: "+fallOff); 
  
}

void mouseReleased(){//This is the way to implement mouse drag!!!!!
  seedValue++;
}

void keyReleased(){
  if(key == 's') saveFrame(timestamp()+"_##.png");
  if (key == '1') noiseMode = 1;
  if (key == '2') noiseMode = 2;
  if (key == '3') multi++;
  if (key == '4') multi--;
  if (multi < 0) multi = 0;
}

void keyPressed() {
  if (keyCode == UP) fallOff += 0.05;
  if (keyCode == DOWN) fallOff -= 0.05;
  if (fallOff > 1.0) fallOff = 1.0;
  if (fallOff < 0.0) fallOff = 0.0;

  if (keyCode == LEFT) octaves--;
  if (keyCode == RIGHT) octaves++;
  if (octaves < 0) octaves = 0;
}

String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
