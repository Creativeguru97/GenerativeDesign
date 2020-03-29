
class Ribbon3d{
  int count; //How many points has the ribbon.
  PVector[] p;
  boolean[] isGap;
  
  Ribbon3d(PVector theP, int theCount){
    count = theCount;
    p = new PVector[count];
    isGap = new boolean[count];
    
    for(int i=0; i<count; i++){
      p[i] = new PVector(theP.x, theP.y, theP.z);
      isGap[i] = false;
    }
  }
  
  void update(PVector theP, boolean theIsGap){
    //Shift the values to the right side
    //Simple queue
    for(int i=count-1; i>0; i--){
      p[i].set(p[i-1]);
      isGap[i] = isGap[i-1];
    }
    p[0].set(theP);
    isGap[0] = theIsGap;
  }
  
  void drawLineRibbon(float theWidth){
    //Draw the ribbon with lines
    noFill();
    strokeWeight(theWidth);

    for(int i=0; i<count-1; i++){
      //If the point was wrapped => finish the line and start a new one
      if(isGap[i] == false){
        agentAlpha = 100-(100/count*i);
        agentColor = color(0, 0, 100, agentAlpha);
        stroke(agentColor);
        
        beginShape(LINES);
        vertex(p[i].x, p[i].y, p[i].z);
        vertex(p[i+1].x, p[i+1].y, p[i+1].z);
        endShape();
      }
    }
  }
}
