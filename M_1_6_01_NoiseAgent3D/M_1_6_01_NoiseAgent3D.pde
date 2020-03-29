//import generativedesign.*;//No longer available?
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/
    
import peasy.*;

PeasyCam cam;

// ----- agents -----
Agent[] agents = new Agent[4000];
int agentsCount = 4000;
float noiseScale=100, noiseStrength=10;
float agentAlpha = 0;
color agentColor;
int drawMode = 1;
int agentPosMode = 1;

int spaceSizeX = 200, spaceSizeY = 300, spaceSizeZ = 200;

boolean freeze = false;

void setup(){
  size(800, 800, P3D);
  colorMode(HSB, 360, 100, 100);
  
  cam = new PeasyCam(this, 800);
  cam.setMinimumDistance(-200);
  cam.setMaximumDistance(1500);
  //translate(width/2, height/2);//Peasy Cam automatically does this

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
  
  //noiseScale = map(mouseX, 0, width, 50, 400);
  //noiseStrength = map(mouseY, 0, height, 3, 30);
  
  //Draw and update agents
  for (int i=0; i<agentsCount; i++){
    if(freeze == false) agents[i].update();
    agents[i].show();
  } 
  
  popMatrix();
  
  hint(DISABLE_DEPTH_TEST);
  noLights();
  
  println(drawMode);
}


void keyReleased(){
  if(key == 's') saveFrame(timestamp()+"_##.png");
  if (key == '1') drawMode = 1;
  if (key == '2') drawMode = 2;
  if (key == ' ') noiseSeed(int(random(100000)));
  
}


String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
