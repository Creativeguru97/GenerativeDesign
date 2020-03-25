//import generativedesign.*;//No longer available?
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/

int octaves = 4;
float fallOff = 0.5;

color arcColor = color(0, 130, 164, 100);

float tileSize = 40;
int gridResolutionX, gridResolutionY;
boolean debugMode = true;
PShape arrow;

void setup(){
  size(800,800);
  gridResolutionX = round(width/tileSize);
  gridResolutionY = round(height/tileSize);
  smooth();
  arrow = loadShape("data/arrow.svg");//Store that svg image into a PShape variable.
}


void draw(){
  background(255);
  
  noiseDetail(octaves, fallOff);
  float noiseXRange = mouseX/100.0;
  float noiseYRange = mouseY/100.0;
 
  for(int gY=0; gY<=gridResolutionY; gY++){
    for(int gX=0; gX<=gridResolutionX; gX++){
      float posX = tileSize * gX;
      float posY = tileSize * gY;
      
      //Get noise value
      float noiseX = map(gX, 0, gridResolutionX, 0, noiseXRange);
      float noiseY = map(gY, 0, gridResolutionY, 0, noiseYRange);
      float noiseValue = noise(noiseX, noiseY);
      float angle = noiseValue * TWO_PI;//This is smart way.
      
      pushMatrix();
      translate(posX, posY);
      
      //Debug heatmap
      if(debugMode){
        noStroke();
        ellipseMode(CENTER);
        fill(noiseValue * 255);
        ellipse(0, 0, tileSize * 0.25, tileSize * 0.25);
      }
      
      //arc
      noFill();
      strokeCap(SQUARE);
      strokeWeight(1);
      stroke(arcColor);
      arc(0, 0, tileSize * 0.75, tileSize * 0.75, 0, angle);
      
      //arrow
      stroke(0);
      strokeWeight(0.75);
      rotate(angle);
      shape(arrow, 0, 0, tileSize * 0.75, tileSize * 0.75);
      popMatrix();
    }
  }

  
  println("octaves: "+octaves+" falloff: "+fallOff+" noiseXRange: 0-"+noiseXRange+" noiseYRange: 0-"+noiseYRange); 
}

void mouseReleased(){//This is the way to implement mouse drag!!!!!
  noiseSeed(int(random(100000))) ;
}

void keyReleased(){
  if(key == 's') saveFrame(timestamp()+"_##.png");
  if (key == 'd') debugMode = !debugMode;
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
