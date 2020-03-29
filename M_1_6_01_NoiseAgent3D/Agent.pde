
class Agent{
  PVector p, pOld;
  float stepSize, offset, angleY, angleZ;
  boolean isOutSide = false;
  float noiseZ, noiseZVelocity = 0.01;
  Ribbon3d ribbon;
  
  Agent(){
    p = new PVector(0, 0, 0);
    setRandomPosition();
    pOld = new PVector(p.x, p.y);
    stepSize = random(1, 3);
    offset = 10000;
    ribbon = new Ribbon3d(p, (int)random(50, 300));
  }
  
  void update(){
    angleY = noise(p.x / noiseScale, p.y / noiseScale, p.z / noiseScale) * noiseStrength;
    angleZ = noise(p.x / noiseScale+offset, p.y / noiseScale, p.z / noiseScale) * noiseStrength;
    
    p.x += sin(angleZ) * cos(angleY) * stepSize;
    p.y += sin(angleZ) * sin(angleZ) * stepSize;
    p.z += cos(angleZ) * stepSize;
    
    if(agentPosMode == 1){
      if(p.x < -spaceSizeX || p.x > spaceSizeX || 
         p.y < -spaceSizeY || p.y > spaceSizeY ||
         p.z < -spaceSizeZ || p.z > spaceSizeZ){
         
         setRandomPosition();
         isOutSide = true;
      }
    
      if(isOutSide){
        p.x = random(width);
        p.y = random(height);
        pOld.set(p);//Copying from p
      }
    }else if(agentPosMode == 2){
      if(p.x < -spaceSizeX-10) p.x = pOld.x = spaceSizeX+10;
      if(p.x > spaceSizeX+10) p.x = pOld.x = -spaceSizeX-10;
      if(p.y < -spaceSizeY-10) p.y = pOld.y = spaceSizeY+10;
      if(p.y > spaceSizeY+10) p.y = pOld.y = -spaceSizeY-10;
      if(p.z < -spaceSizeZ-10) p.z = pOld.z = spaceSizeZ+10;
      if(p.z > spaceSizeZ+10) p.z = pOld.z = -spaceSizeZ-10;
    }
    
    // create ribbons
    ribbon.update(p,isOutside);
    
    if(agentPosMode == 1){
      isOutSide = false;
    }
    
  }
  
  void show(){
    ribbon.drawLineRibbon(agentColor, 2.0);
    
  }
  
  void setRandomPosition(){
    p.x = random(-spaceSizeX, spaceSizeX);
    p.y = random(-spaceSizeY, spaceSizeY);
    p.z = random(-spaceSizeZ, spaceSizeZ);
  }
}
