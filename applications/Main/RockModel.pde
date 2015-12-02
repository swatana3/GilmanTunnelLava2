class RockModel {
  static final int WIDTH = 50;
  static final int HEIGHT = 50;
  // width and height of ellipse that represents rock
  int w, h;
  
  float posX, posY;
  
  boolean movingRock;
  
  //incrementally changing elliptical angle
  float theta;
  
  //radius of ellipse, it can be set later
  float radiusX, radiusY;
  
  // center point of ellipse
  int cX, cY;
  // velocity of this rock - don't know if this is how it should be done yet?
  float vX, vY;

  // 3 different images for rocks, pick one at random
  int imageType;
  static final int DEFAULT_FRAMES = 100;
  
  //State
  int framesUntilDestroyed;
  boolean dead = false;
  boolean collidingWithPlayer = false;
    

  RockModel(int cX, int cY) {
    this.cX = cX;
    this.cY = cY;
    this.posX = cX;
    this.posY = cY;
    // how big do we want the rocks to be?
    this.w = WIDTH;
    this.h = HEIGHT;

     //this.vel = 100;
   
   //this.multiFactor = 0;  
    
    // can change the velocity later by changing theta increase
    
    //currrently setting radius manually
    this.radiusX = 10;
    this.radiusY = 50;
    
    //angle of ellipse
    this.theta =0; 


    this.framesUntilDestroyed = DEFAULT_FRAMES;
    // pick a random number for a rock image (3 images) to represent this rock
    this.imageType = (int) random(3);
    
    if ((int) random(3) ==0){
      println("Moving rock created!!");
      this.movingRock = true;
    } else {
      println("not created!");
      this.movingRock = false;
    }

  }

  int getRawX() {
    return cX;
  }

  int getRawY() {
    return cY;
  }
  
  int getWidth() {
    return w;
  }
  
  int getHeight() {
    return h;
  }

  int getType() {
    return imageType;
  }

  int getRemainingFrames() {
    return framesUntilDestroyed;
  }
  
  public void setCollidingWithPlayer(boolean colliding) {
    this.collidingWithPlayer = colliding;
  } 

  void setFramesUntilDestroyed(int framesUntilDestroyed) {
    this.framesUntilDestroyed = framesUntilDestroyed;
  }

  boolean isDestroyed() {
    if (framesUntilDestroyed == 0) {
      println("Rock destroyed.");
      return true;
    } else {
      return false;
    }
  }
  
  void update() {
    if (movingRock) {
      println("updating velocity");
      updateVelocity();
    } else {
      println("NOT updating velocity");
    }
    
    if (collidingWithPlayer) {
      if (this.framesUntilDestroyed > 0) {
        this.framesUntilDestroyed -= 1;
      } else {
        this.dead = true;
      }     
    }
  }

  void updateVelocity() {
     this.theta += 0.01;
      println("theta is" + theta);
      this.posX = radiusX * cos( theta );
      this.posY = radiusY * sin( theta );
      
      this.cX += posX;
      this.cY += posY; 
      
      if (theta > TWO_PI){
        theta = 0;   
      }
  }
}
