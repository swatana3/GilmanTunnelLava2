class RockModel {
  static final int WIDTH = 50;
  static final int HEIGHT = 50;
  // width and height of ellipse that represents rock
  int w, h;
  // center point of ellipse
  int cX, cY;
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

    this.framesUntilDestroyed = DEFAULT_FRAMES;
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
}
