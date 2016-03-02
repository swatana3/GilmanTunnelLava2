class PlayerModel {
  private PlayerDeadEvent playerDeadEvent = new PlayerDeadEvent();

  static final int MAX_SHIELD = 20;
  // raw x and y coordinates
  private int mX, mY;
  // player id
  private int id;
  private int health;
  // shield provides some tolerance of time before a player
  // starts taking damage to their health
  private int shield;
  // if colliding with lava
  private boolean collidingWithLava = false;
  private boolean dead = false;
  

  PlayerModel(int id) {
    // aka health
    this.shield = MAX_SHIELD;
    this.health = 100;
    this.id = id;
  }
  
  /* Resets health and shield - for use in between levels */
  void resetHealth(){
    this.health = 100;
    this.shield = MAX_SHIELD;  
  }

  void update() {
    if (collidingWithLava) {
      if (this.shield <= 0) {
        if (this.health > 0) {
          this.health -= 1;
        } else {
          playerDeadEvent.notifyEvent();
          this.dead = true;
        }
      } else {
        this.shield -= 1;
      }      
    } else {
      this.shield = min(this.shield + 1, MAX_SHIELD);
    } 
    println("player " + id + " shield: " + this.shield + " x: " + this.mX + " y: " + this.mY);
  }
  
  public void setCollidingWithLava(boolean collide) {
    this.collidingWithLava = collide;
  }

  public void setRawX(int x) {
    this.mX = x;
  }
  public int getRawX() {
    return mX;
  }
  
  public void setRawY(int y) {
    this.mY = y;
  }
  public int getRawY() {
    return mY;
  }
  
  PlayerDeadEvent playerDeadEvent() {
    return playerDeadEvent; 
  }

  int getRemainingFrames() {
    return health;
  }
}

