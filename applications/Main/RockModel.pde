class RockModel {
  static final int WIDTH = 50;
  static final int HEIGHT = 50;
  // width and height of ellipse that represents rock
  int w, h;
  
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
    // how big do we want the rocks to be?
    this.w = WIDTH;
    this.h = HEIGHT;

    // velocity of the rock, in pixels per frame
    this.vX = 0;
    this.vY = 0;

    this.framesUntilDestroyed = DEFAULT_FRAMES;
    // pick a random number for a rock image (3 images) to represent this rock
    this.imageType = (int) random(3);

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
    updateVelocity();
    this.cX += this.vX;
    this.cY += this.vY;
    
    if (collidingWithPlayer) {
      if (this.framesUntilDestroyed > 0) {
        this.framesUntilDestroyed -= 1;
      } else {
        this.dead = true;
      }     
    }
  }

  void updateVelocity() {
    // change velocity vectors if you want eliptical movement or something
    // check x wall collision
    if (this.cX <= RockModel.WIDTH/2 || this.cX >= width - RockModel.WIDTH/2) {
      this.vX *= -1;
    }
    if (this.cY <= RockModel.HEIGHT/2 || this.cY >= height - RockModel.HEIGHT/2) {
      this.vY *= -1;
    }
  }
}
