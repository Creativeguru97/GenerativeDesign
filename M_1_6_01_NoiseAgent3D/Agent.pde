
class Agent{
  boolean isOutSide = false;
  PVector p;
  float stepSize, offset, angleY, angleZ;
  Ribbon3d ribbon;
  int hue;
  
  float offsetX = 0.0;
  float offsetY = 0.0;
  float offsetZ = 0.0;

  
  Agent(int hue_){
    p = new PVector(0, 0, 0);
    setRandomPosition();
    offset = 10000;
    stepSize = random(0.3, 1.5);
    hue = hue_;
    ribbon = new Ribbon3d(p, int(random(20, 40)), hue);
  }
  
  void update(){//All this does is calculates positions of the agents
  
    
    angleY = noise(p.x / noiseScale+offsetX, p.y / noiseScale+offsetY, p.z / noiseScale+offsetZ) * noiseStrength;
    angleZ = noise(p.x / noiseScale+offset+offsetX, p.y / noiseScale+offsetY, p.z / noiseScale+offsetZ) * noiseStrength;
    
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
    ribbon.drawLineRibbon(2.0);
    
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
  
  void move(){
    if(key == 'x') offsetX += 0.002;
    if(key == 'y') offsetY += 0.002;
    if(key == 'z') offsetZ += 0.002;
  }
}
