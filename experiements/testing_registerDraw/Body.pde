abstract public class Body {
  float x;
  float y;
  float vx;
  float vy;
  float mass;
  int radius;
  boolean gravityAffected;
  boolean frictionAffected;
    
  Body(float x, float y) {
    this.x = x;
    this.y = y;
    init();
  }
   
  Body(float x, float y, float vx, float vy) {
    this.x = x;
    this.y = y;
    this.vx = vx;
    this.vy = vy;
    init();
  }
   
  void init() {
    mass = 1;
    gravityAffected = true;
    frictionAffected = true;
  }
   
  void move() {
    if(gravityAffected){
      vy += gravity;
    }
    if(frictionAffected){
      vx *= (1-friction);
      vy *= (1-friction);
    }
     
    x += vx;
    y += vy;
     
    checkBounds();
  }
   
  abstract void checkBounds();
   
  // A couple of built-in options to call in checkBounds
  void boundsWrap() {
    //constraints
      if(x < 0) {
        x = width;
      }
      else if(x>width) {
        x = 0;
      }
      if(y < 0){
        y = height;
      }
      else if (y > height) {
        y = 0;
      }
  }
   
  void boundsBounce() {
    //constraints
      if(x < leftBound+radius) {
        x = leftBound+radius;
        vx *= -1;
      }
      else if(x>rightBound-radius) {
        x = rightBound-radius;
        vx *= -1;
      }
      if(y < topBound+radius){
        y = topBound+radius;
        vy *= -1;
      }
      else if (y > bottomBound-radius) {
        y = bottomBound-radius;
        vy *= -1;
      }
  } 
}