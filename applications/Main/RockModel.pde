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
  int framesUntilDestroyed;

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

  int getX() {
    return cX;
  }

  int getY() {
    return cY;
  }
  
  int getType() {
    return imageType;
  }

  int getRemainingFrames() {
    return framesUntilDestroyed;
  }

  void setFramesUntilDestroyed(int framesUntilDestroyed) {
    this.framesUntilDestroyed = framesUntilDestroyed;
  }

  void decrementFramesRemaining() {
    if (this.framesUntilDestroyed > 0) {
      this.framesUntilDestroyed -= 1;
    }
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
  }

  // check whether the player is on the rock or not
  boolean checkCollision(int pX, int pY) {
    // rock is an ellipse, calculate whether the player point is in it
    // is this actually faster to do this first?
    // check rectangle,
    if (abs(pX - cX) > w/2.0 || abs(pY - cY) > h/2.0) { return false; }
    // then ellipse
    if (sq(pX - cX) / sq(w/2) + sq(pY - cY) / sq(h/2) <= 1) {
      decrementFramesRemaining();
      // DEBUGGING
      println("rock(" + cX + "," + cY + "): " + getRemainingFrames());
      return true;
    }
    return false;
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
