//import generativedesign.*;//No longer available?
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/
    
//import controlP5.*;

// ----- agents -----
Agent[] agents = new Agent[1000];
int agentsCount = 500;
float noiseScale = 600, noiseStrength = 10;
float agentAlpha = 90;
color agentColor;
int drawMode = 1;
int agentPosMode = 1;

int spaceSizeX = 200, spaceSizeY = 300, spaceSizeZ = 200;

boolean freeze = false;

void setup(){
  size(800, 800, P3D);
  colorMode(HSB, 360, 100, 100);

  for(int i=0; i<agents.length; i++){
    agents[i] = new Agent();
  }
}


void draw(){
  hint(ENABLE_DEPTH_TEST);
  
  background(0, 0, 0);
  smooth();
  lights();
  
  pushMatrix();

  noStroke();
  noFill();
  stroke(192, 100, 64);
  strokeWeight(1); 
  box(spaceSizeX*2, spaceSizeY*2, spaceSizeZ*2);
  
  //Draw and update agents
  agentColor = color(0, 0, 100, agentAlpha);
  for (int i=0; i<agentsCount; i++){
    if(freeze == false) agents[i].show();
    agents[i].show();
  } 
  
  popMatrix();
  
  hint(DISABLE_DEPTH_TEST);
  noLights();
}

void mouseReleased(){//This is the way to implement mouse drag!!!!!
  noiseSeed(int(random(100000))) ;
}

void keyReleased(){
  if(key == 's') saveFrame(timestamp()+"_##.png");
  if (key == '1') drawMode = 1;
  if (key == '2') drawMode = 2;
  if (key == '3') agentPosMode = 1;
  if (key == '4') agentPosMode = 2;
  
}


String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
