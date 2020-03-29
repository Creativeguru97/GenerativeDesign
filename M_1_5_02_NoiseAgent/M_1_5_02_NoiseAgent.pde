//import generativedesign.*;//No longer available?
import java.util.Calendar;
/*Conversion characters for time in Java: https:
    //www.tutorialspoint.com/conversion-characters-for-time-in-java*/
    
//import controlP5.*;

// ----- agents -----
Agent[] agents = new Agent[5000];
int agentsCount = 5000;
float noiseScale = 600, noiseStrength = 10;
float overlayAlpha = 10, agentsAlpha = 90, strokeWidth = 0.3;
int drawMode = 1;
int agentPosMode = 1;


//----- ControlP5 -----
//ControlP5 controlP5;


void setup(){
  size(1280, 800, P2D);
  smooth();
  
  for(int i=0; i<agents.length; i++){
    agents[i] = new Agent();
  }
}


void draw(){
  fill(0, overlayAlpha);
  noStroke();
  rect(0, 0, width, height);
  
  stroke(255, agentsAlpha);
  
  //Draw agents
  if(drawMode == 1){
    for (int i=0; i<agentsCount; i++) agents[i].update1();
  }else if(drawMode == 2){
    for (int i=0; i<agentsCount; i++) agents[i].update2();
  }
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
