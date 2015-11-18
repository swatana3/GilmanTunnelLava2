class PlayerModel {
  private PlayerDeadEvent playerDeadEvent = new PlayerDeadEvent();

  static final int MAX_SHIELD = 20;
  // index of player on game map
  int x, y;
  // use to add native mouse pixel location,
  // more precise
  int mX, mY;
  // player id
  int id;
  int health;
  // shield provides some tolerance of time before a player
  // starts taking damage to their health
  int shield;
  // bool to tell whether the player has already been hurt this frame
  boolean hurt_this_frame;
  // 
  PlayerModel(int id) {
    // aka health
    this.shield = MAX_SHIELD;
    this.health = 100;
    this.hurt_this_frame = false;
    this.id = id;
  }

  void update() {
    // convert coordinates
    mX = mouseX;
    mY = mouseY;
  }
  
  PlayerDeadEvent playerDeadEvent() {
    return playerDeadEvent; 
  }

  int getRemainingFrames() {
    return health;
  }

  // shield/health -= 1 if hurt_this_frame
  // else shield = DEFAULT or shield += 1
  void dealDamage() {
    // if the player is standing in lava
    if (hurt_this_frame) {
      if (this.shield <= 0) {
        // if the player isn't dead, decrement health
        if (this.health > 0) {
          this.health -= 1;
          println("player " + this.id + " health: " + this.health);
        } else {
          playerDeadEvent.notifyEvent();
        }
      } else {
        this.shield -= 1;
        println("player " + id + " shield: " + this.shield);
      }
      // player is safe, recover shield
    } else {
      this.shield = min(this.shield + 1, MAX_SHIELD);
    }
  }
}

