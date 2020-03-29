
class Agent{
  boolean isOutSide = false;
  PVector p;
  float stepSize, offset, angleY, angleZ;
  Ribbon3d ribbon;
  
  Agent(){
    p = new PVector(0, 0, 0);
    setRandomPosition();
    offset = 10000;
    stepSize = random(0.3, 1.5);
    ribbon = new Ribbon3d(p, int(random(20, 40)));
  }
  
  void update(){//All this does is calculates positions of the agents
    angleY = noise(p.x / noiseScale, p.y / noiseScale, p.z / noiseScale) * noiseStrength;
    angleZ = noise(p.x / noiseScale+offset, p.y / noiseScale, p.z / noiseScale) * noiseStrength;
    
    p.x += sin(angleZ) * cos(angleY) * stepSize;
    p.y += sin(angleZ) * sin(angleZ) * stepSize;
    p.z += cos(angleZ) * stepSize;
    

    if(p.x < -spaceSizeX || p.x > spaceSizeX || 
       p.y < -spaceSizeY || p.y > spaceSizeY ||
       p.z < -spaceSizeZ || p.z > spaceSizeZ){
       
        if(drawMode == 1) resetPosition();
        if(drawMode == 2) setRandomPosition();
       
       isOutSide = true;
    }
 

    // create ribbons
    ribbon.update(p,isOutSide);
    isOutSide = false;
    
  }
  
  void show(){
    ribbon.drawLineRibbon(1.0);
    
  }
  
  void resetPosition(){
    if(p.x < -spaceSizeX) p.x = spaceSizeX;
    if(p.x > spaceSizeX) p.x = -spaceSizeX;
    if(p.y < -spaceSizeY) p.y = spaceSizeY;
    if(p.y > spaceSizeY) p.y = -spaceSizeY;
    if(p.z < -spaceSizeZ) p.z = spaceSizeZ;
    if(p.z > spaceSizeZ) p.z = -spaceSizeZ;
  }
  
  void setRandomPosition(){
    p.x = random(-spaceSizeX, spaceSizeX);
    p.y = random(-spaceSizeY, spaceSizeY);
    p.z = random(-spaceSizeZ, spaceSizeZ);
  }
}
