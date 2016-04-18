class RockModel {
  static final int WIDTH = 300;
  static final int HEIGHT = 300;
 
  // width and height of ellipse that represents rock
  private int w, h;
  
  private float posX, posY;
  
  private boolean movingRock;
  
  //incrementally changing elliptical angle
  private float theta;
  
  //Store real cX and cY, cX, cY for display
  private int storecX, storecY;
  
  //radius of ellipse, it can be set later
  private float radiusX, radiusY;
  
  // center point of ellipse
  private int cX, cY;
  
  private int centerX, centerY;
  // velocity of this rock - don't know if this is how it should be done yet?
  private float vX, vY;

  // 3 different images for rocks, pick one at random
  private int imageType;

  //if rocks are moving offscreen
  private boolean movingOffScreenX; 
  private boolean movingOffScreenY; 
  
  static final private int DEFAULT_FRAMES = 20;
  
  //State
  private int framesUntilDestroyed;
  private boolean dead = false;
  private boolean collidingWithPlayer = false;
  
  //variables for bounce effect called in View (can't be in View specific to each rock)
  private float amplitude;
  private float decay;
  private float minScale;
  private float t;
  private float sineScale;
  //BouncingState
  private boolean bouncing;
  
  //store the width and height during bounce
  private int storeW, storeH; 
  
  //type of movement
  private int move;
  private boolean down = false;
  private boolean left = false;
  
  
  RockModel(int cX, int cY, boolean Start){
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
    this.imageType = (int) random(1,3);
    this.movingRock = false;
  }
    

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
    this.radiusX = (int) random( min( min(width - this.w/2, this.w/2), 50), max(min(width - this.w/2, this.w/2), 50));
    this.radiusY = (int) random( min( min(height - this.h/2, this.h/2), 100), max(min(height - this.h/2, this.h/2), 100));
    
    //angle of ellipse
    this.theta =0; 


    this.framesUntilDestroyed = DEFAULT_FRAMES;
    // pick a random number for a rock image (3 images) to represent this rock
    this.imageType = (int) random(3);
    
    if ((int) random(3) ==0){
      //println("Moving rock created!!");
      this.movingRock = true;
      
      this.move = (int) random(0, 6);
      if (this.move == 3) {
        this.down = true;
      } else if (this.move == 5) {
        this.left = true;
      }
      //this.move = 1;
      
      //use these variables if it's moving rock
      this.movingOffScreenX = false;
      this.movingOffScreenY = false;
      
      this.storecX = this.cX;
      this.storecY = this.cY; 
      
    } else {
      //println("not created!");
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
  
  int getDefaultFrames(){
    return DEFAULT_FRAMES;
  }
  
  int getCenterX(){
    return cX;
  }
  
  int getCenterY(){
    return cY;
  }
    
  void setBouncing(boolean tf) {
    bouncing = tf;
  }
  
  public void setCollidingWithPlayer(boolean colliding) {
    this.collidingWithPlayer = colliding;
  } 

  void setFramesUntilDestroyed(int framesUntilDestroyed) {
    this.framesUntilDestroyed = framesUntilDestroyed;
  }

  boolean isDestroyed() {
    if (framesUntilDestroyed == 0) {
      //println("Rock destroyed.");
      return true;
    } else {
      return false;
    }
  }
  
  void update(int level) {
    if (movingRock) {
      //println("updating velocity");
      updateVelocity(level) ;
    } else {
      //println("NOT updating velocity");
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
  void updateVelocity(int level) {
    float scaled_t = level * .005 + (random(0, 1001) / 10000000);
    this.theta += (.01 + scaled_t);
   
     //CHANGE COORDINATES BASED ON MOVEMENT TYPE
    //circular movement 1
    if (this.move == 0) {
     this.storecX = (int)(radiusX * cos( theta )) + centerX;
     this.storecY = (int)(radiusY * sin( theta )) + centerY;
      //circular movement 2
    } else if (this.move == 1) {
      this.storecX = (int)(-1 * radiusX * cos( theta )) + centerX;
       this.storecY = (int)(-1 * radiusY * sin( theta )) + centerY;
    //vertical movement  
    } else if (this.move == 2 || this.move == 3) {
      if (down){
        this.storecX = centerX;
        this.storecY = (int)( -1 * radiusY * sin( theta )) + centerY;
      } else {
        this.storecX = centerX;
       this.storecY = (int)(radiusY * sin( theta )) + centerY;  
      }
      //horizontal movement
    } else if (this.move == 4 || this.move == 5) {
      if (left){
        this.storecX =  (int)( -1 * radiusX * sin( theta )) + centerX;
        this.storecY = centerY;
      } else {
        this.storecX = (int)(radiusX * sin( theta )) + centerX;
       this.storecY = centerY;  
      }
    }
    
    //change movingOffScreen based on conditions for x coordinate
      if (!this.movingOffScreenX && (this.storecX < (0 + this.w/2) || this.storecX > (width - this.w/2))){
        this.movingOffScreenX = true;
      } else if (movingOffScreenX && (this.storecX >= (0 + this.w/2) && this.storecX <= (width - this.w/2))){
       this.movingOffScreenX = false;
      }   
    
      //display results based on moving off screen
      if (!this.movingOffScreenX) {
        this.cX = storecX;
      } else if (this.storecX < (0 + this.w/2)) {
        this.cX = this.w/2;
        this.left = false;
      } else {
        this.cX = (width - this.w/2);
        this.left = true;
      }
    
      if (!this.movingOffScreenY && (this.storecY < (0 + this.h/2) || this.storecY > (height - this.h/2))){
        this.movingOffScreenY = true;
      } else if (movingOffScreenY && (this.storecY >= (0 + this.h/2) && this.storecY <= (height - this.h/2))) {
       this.movingOffScreenY = false;
      } 
    
      if (!this.movingOffScreenY) {
        this.cY = storecY;
      } else if (this.storecY < (0 + this.h/2) ) {
        this.cY = this.h / 2;
        this.down = false;
      } else {
        this.cY = (height - this.h/2);
        this.down = true;
      }
    
     if (theta > TWO_PI){
       theta = 0;   
     }
  }
}
