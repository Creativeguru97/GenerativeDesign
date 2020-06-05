//import generativedesign.*;//No longer available?
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/

int octaves = 4;
float fallOff = 0.5;

int noiseMode = 2;

void setup(){
size(512,512);
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
  
  int noiseXRange = mouseX/10;
  int noiseYRange = mouseY/10;
 
  loadPixels();
  for(int x=0; x<width; x++){
    for(int y=0; y<width; y++){
      float noiseX = map(x, 0, width, 0, noiseXRange);
      float noiseY = map(y, 0, height, 0, noiseYRange);
      
      float noiseValue = 0;
      if(noiseMode == 1) noiseValue = noise(noiseX, noiseY) * 255;
      else if(noiseMode == 2) {
        float n = noise(noiseX, noiseY) * 24;
        noiseValue = (n - int(n)) * 255;
      }
      
      pixels[x+y*width] = color(noiseValue);
    }
  }
  updatePixels();
  
  println("octaves: "+octaves+" falloff: "+fallOff+" noiseXRange: 0-"+noiseXRange+" noiseYRange: 0-"+noiseYRange); 
}

void mouseReleased(){//This is the way to implement mouse drag!!!!!
  noiseSeed(int(random(100000))) ;
}

void keyReleased(){
  if(key == 's') saveFrame(timestamp()+"_##.png");
  if (key == '1') noiseMode = 1;
  if (key == '2') noiseMode = 2;
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
