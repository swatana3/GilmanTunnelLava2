class RockModel {
  // indices relative on game board grid (4x6 for example)
  int x, y;
  // pixel offset of top right corner of rock
  int gridX, gridY;
  // 3 different images for rocks, pick one at random
  int type;
  static final int DEFAULT_FRAMES = 100;
  int framesUntilDestroyed = -1;

  RockModel(int x, int y, int dimX, int dimY) {
    this.x = x;
    this.y = y;
    this.gridX = x * (width / dimX);
    this.gridY = y * (height / dimY);
    this.framesUntilDestroyed = DEFAULT_FRAMES;
    this.type = (int) random(3);
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
}
