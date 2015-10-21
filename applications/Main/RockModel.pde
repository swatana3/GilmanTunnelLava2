class RockModel {
  float x,y;
  int frameLife = -1;
  int framesAlive = -1;

  RockModel(float x, float y) {
    this.x = x;
    this.y = y;
  }

  float getX() {
      return x;
  }

  float getY() {
      return y;
  }

  void setFrameLife(int frameLife) {
      this.frameLife = frameLife;
      this.framesAlive = frameLife;
  }

  void update() {
      if (this.frameLife > 0 && this.framesAlive > 0) {
          this.framesAlive -= 1;
      }
  }
  
  int getFrameLife() {
    return frameLife;
  }
  
  int getFramesAlive() {
    return framesAlive;
  }

  boolean isDestroyed() {
      if (framesAlive == 0) {
          return true;
      } else {
          return false;
      }
  }
}
