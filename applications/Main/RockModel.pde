class RockModel {
  // indices relative on game board grid (4x6 for example)
  int x, y;
  // width and height of ellipse that represents rock
  int w, h;
  // center point of ellipse
  int cX, cY;
  // pixel offset of top right corner of rock
  int gridX, gridY;
  // 3 different images for rocks, pick one at random
  int imageType;
  static final int DEFAULT_FRAMES = 100;
  int framesUntilDestroyed = -1;

  RockModel(int x, int y, int dimX, int dimY) {
    this.x = x;
    this.y = y;
    // TODO: these will be sizes eventually
    this.w = width / dimX;
    this.h = height / dimY;
    // TODO: dunno if we need this or not (NOTE: integer division)
    this.gridX = x * (width / dimX);
    this.gridY = y * (height / dimY);
    // have to use the actual pixels
    this.cX = gridX + w/2;
    this.cY = gridY + h/2;
    this.framesUntilDestroyed = DEFAULT_FRAMES;
    this.imageType = (int) random(3);
  }

  int getX() {
    return x;
  }

  int getY() {
    return y;
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
      println("rock(" + x + "," + y + "): " + getRemainingFrames());
      return true;
    }
    return false;
  }
}
