class PlayerModel {

  static final int MAX_SHIELD = 20;
  // index of player on game map
  int x, y;
  // use to add native mouse pixel location,
  // more precise
  int mX, mY;
  // player id
  int id;
  // map model
  MapModel mapModel;
  int health;
  // shield provides some tolerance of time before a player
  // starts taking damage to their health
  int shield;
  // bool to tell whether the player has already been hurt this frame
  boolean hurt_this_frame;
  // 
  PlayerModel(MapModel mapModel) {
    // aka health
    this.mapModel = mapModel;
    this.shield = MAX_SHIELD;
    this.health = 100;
    this.hurt_this_frame = false;
    this.id = ++mapModel.playerCount;
  }

  void update() {
    // convert coordinates
    mX = mouseX;
    mY = mouseY;
    // 3 pixel edge tolerance
    if (mX >= width-3) {
      this.mapModel.state = GameState.WIN;
    }
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
          // player is dead, game over
        } else {
          // player is dead, change game state
          this.mapModel.state = GameState.LOSE;
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

