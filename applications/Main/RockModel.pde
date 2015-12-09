class RockModel {
  static final int WIDTH = 300;
  static final int HEIGHT = 300;
  // width and height of ellipse that represents rock
  int w, h;
  
  float posX, posY;
  
  boolean movingRock;
  
  //incrementally changing elliptical angle
  float theta;
  
  //Store real cX and cY, cX, cY for display
  int storecX, storecY;
  
  //radius of ellipse, it can be set later
  float radiusX, radiusY;
  
  // center point of ellipse
  int cX, cY;
  
  int centerX, centerY;
  // velocity of this rock - don't know if this is how it should be done yet?
  float vX, vY;

  // 3 different images for rocks, pick one at random
  int imageType;

  //if rocks are moving offscreen
  boolean movingOffScreenX; 
  boolean movingOffScreenY; 
  
  static final int DEFAULT_FRAMES = 100;
  
  //State
  int framesUntilDestroyed;
  boolean dead = false;
  boolean collidingWithPlayer = false;
  
  //variables for bounce effect called in View (can't be in View specific to each rock)
  float amplitude;
  float decay;
  float minScale;
  float t;
  float sineScale;
  //BouncingState
  boolean bouncing;
  
  //store the width and height during bounce
  int storeW, storeH; 
    

  RockModel(int cX, int cY) {
    this.cX = cX;
    this.cY = cY;
    this.centerX = cX;
    this.centerY = cY;
    // how big do we want the rocks to be?
    this.w = WIDTH;
    this.h = HEIGHT;
    
    //variables for bounce in view
    sineScale = 1;
    amplitude = 0.10;
    decay = 0.002;
    minScale = 1.0;
    t=0;
    bouncing = false;
    
    //store w and h for bounce
    storeW = w;
    storeH = h;
    
    //currrently setting radius manually
    this.radiusX = 50;
    this.radiusY = 100;
    
    //angle of ellipse
    this.theta =0; 


    this.framesUntilDestroyed = DEFAULT_FRAMES;
    // pick a random number for a rock image (3 images) to represent this rock
    this.imageType = (int) random(3);
    
    if ((int) random(3) ==0){
      println("Moving rock created!!");
      this.movingRock = true;
      
      //use these variables if it's moving rock
      this.movingOffScreenX = false;
      this.movingOffScreenY = false;
      
      this.storecX = this.cX;
      this.storecY = this.cY; 
      
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
    //change height and width of rock if its bouncing
    if (bouncing){
      bouncingMovement();
    }
    
    if (collidingWithPlayer) {
      if (this.framesUntilDestroyed > 0) {
        this.framesUntilDestroyed -= 1;
      } else {
        this.dead = true;
      }     
    }
  }
  
//bouncing movement change rock height and width
void bouncingMovement() {
  sineScale = (minScale) - (amplitude * sin(2 * PI * t / 60) + amplitude);
  if (amplitude > 0) {
    amplitude -= decay;
  } else {
    amplitude = 0;
  }
  t += 1;
  
  w = (int) (storeW * sineScale);
  h = (int) (storeH * sineScale);
       
}

//only updates velcocity if it's a moving rock 
  void updateVelocity() {
    this.theta += 0.01;
    
     this.storecX = (int)(radiusX * cos( theta )) + centerX;
     this.storecY = (int)(radiusY * sin( theta )) + centerY;
     
     //change movingOffScreen based on conditions for x coordinate
    if (!this.movingOffScreenX && (this.storecX<0 || this.storecX>width)){
      this.movingOffScreenX = true;
    } else if (movingOffScreenX && (this.storecX>0 && this.storecX<width)) {
     this.movingOffScreenX = false;
    } 
    
    //display results based on moving off screen
    if (!this.movingOffScreenX) {
      this.cX = storecX;
    } else if (this.storecX<0 ) {
      this.cX = 0;
    } else {
      this.cX = width;
    }
    
    if (!this.movingOffScreenY && (this.storecY<0 || this.storecY>height)){
      this.movingOffScreenY = true;
    } else if (movingOffScreenY && (this.storecY>0 && this.storecY<height)) {
     this.movingOffScreenY = false;
    } 
    
    if (!this.movingOffScreenY) {
      this.cY = storecY;
    } else if (this.storecY<0 ) {
      this.cY = 0;
    } else {
      this.cY = height;
    }
    
      if (theta > TWO_PI){
        theta = 0;   
      }
  }
}
