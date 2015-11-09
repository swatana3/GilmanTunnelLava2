class PlayerModel {
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
	// bool to tell whether the player has already been hurt this frame
	boolean hurt_this_frame;
	// 
	PlayerModel(MapModel mapModel) {
    // aka health
    this.mapModel = mapModel;
    this.health = 1000;
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

	void decrementFramesRemaining() {
		if (this.health > 0) {
			this.health -= 1;
			println("player " + this.id + ":" + this.health);
		} else {
    		// player is dead, change game state
    		this.mapModel.state = GameState.LOSE;
        }
	}
}
