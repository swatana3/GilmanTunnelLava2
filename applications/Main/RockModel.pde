class Rock {
  float x,y;
  int framesUntilDestroyed = -1;

  Rock(float x, float y) {
    this.x = x;
    this.y = y;
  }

  float getX() {
      return x;
  }

  float getY() {
      return y;
  }

  void setFramesUntilDestroyed(int framesUntilDestroyed) {
      this.framesUntilDestroyed = framesUntilDestroyed;
  }

  void update() {
      if (this.framesUntilDestroyed > 0) {
          this.framesUntilDestroyed -= 1;
      }
  }

  boolean isDestroyed() {
      if (framesUntilDestroyed == 0) {
          return true;
      } else {
          return false;
      }
}
