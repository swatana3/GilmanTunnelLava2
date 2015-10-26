class RockModel {
  int x, y;
  // 3 different images for rocks, pick one at random
  int type;
  static final int DEFAULT_FRAMES = 1000;
  int framesUntilDestroyed = -1;

  RockModel(int x, int y) {
    this.x = x;
    this.y = y;
    this.framesUntilDestroyed = DEFAULT_FRAMES;
    this.type = (int) random(3);
  }

  float getX() {
    return x;
  }

  float getY() {
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
