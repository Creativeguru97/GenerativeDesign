class Agent{
  PVector p, pOld;
  float stepSize, angle;
  boolean isOutSide = false;
  float noiseZ, noiseZVelocity = 0.01;
  
  Agent(){
    p = new PVector(random(width), random(height));
    pOld = new PVector(p.x, p.y);
    stepSize = random(1, 2);
    setNoiseZRange(0.1);//Init noiseZ
  }
  
  void update1(){
    noiseScale = mouseX;
    angle = noise(p.x / noiseScale, p.y / noiseScale, noiseZ) * noiseStrength;
    
    p.x += cos(angle) * stepSize;
    p.y += sin(angle) * stepSize;
    
    if(agentPosMode == 1){
      if(p.x < -10) isOutSide = true;
      else if(p.x > width+10) isOutSide = true;
      else if(p.y < -10) isOutSide = true;
      else if(p.y > height+10) isOutSide = true;
    
      if(isOutSide){
        p.x = random(width);
        p.y = random(height);
        pOld.set(p);//Copying from p
      }
    }else if(agentPosMode == 2){
      if(p.x < -10) p.x = pOld.x = width+10;
      if(p.x > width+10) p.x = pOld.x = -10;
      if(p.y < -10) p.y = pOld.y = height+10;
      if(p.y > height+10) p.y = pOld.y = -10;
    }
   
    
    strokeWeight(strokeWidth * stepSize);
    line(pOld.x, pOld.y, p.x, p.y);
    
    pOld.set(p);//Copying from p
    noiseZ += noiseZVelocity;
    
    if(agentPosMode == 1){
      isOutSide = false;
    }
    
  }
  
  void update2(){
    noiseScale = mouseX;
    angle = noise(p.x / noiseScale, p.y / noiseScale, noiseZ) * 24;
    angle = (angle - int(angle)) * noiseStrength;
    
    p.x += cos(angle) * stepSize;
    p.y += sin(angle) * stepSize;
    
    if(agentPosMode == 1){
      if(p.x < -10) isOutSide = true;
      else if(p.x > width+10) isOutSide = true;
      else if(p.y < -10) isOutSide = true;
      else if(p.y > height+10) isOutSide = true;
    
      if(isOutSide){
        p.x = random(width);
        p.y = random(height);
        pOld.set(p);//Copying from p
      }
    }else if(agentPosMode == 2){
      if(p.x < -10) p.x = pOld.x = width+10;
      if(p.x > width+10) p.x = pOld.x = -10;
      if(p.y < -10) p.y = pOld.y = height+10;
      if(p.y > height+10) p.y = pOld.y = -10;
    }
    
    if(isOutSide){
      p.x = random(width);
      p.y = random(height);
      pOld.set(p);//Copying from p
    }
    
    strokeWeight(strokeWidth * stepSize);
    line(pOld.x, pOld.y, p.x, p.y);
    
    pOld.set(p);//Copying from p
    noiseZ += noiseZVelocity;
    
    if(agentPosMode == 1){
      isOutSide = false;
    }
    
  }
  
  void setNoiseZRange(float theNoiseZRange){
    noiseZ = random(theNoiseZRange);//// small values will increase grouping of the agents
  }
}
