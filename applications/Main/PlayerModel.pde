class PlayerModel {
  // index of player on game map
	int x, y;
	// use to add native mouse pixel location,
	// more precise
	int mX, mY;
	// dimensions of the world the player is in
	int mapX, mapY;
  // player id
  int id;
        
	int framesUntilDestroyed = -1;
	// bool to tell whether the player has already been hurt this frame
	boolean hurt_this_frame;
	// 
	PlayerModel(MapModel mapModel) {
	  this.mapX = mapModel.mapX;
	  this.mapY = mapModel.mapY;
    // aka health
    this.framesUntilDestroyed = 100;
    this.hurt_this_frame = false;
    this.id = ++mapModel.playerCount;
	}

	void update() {
		// convert coordinates
		x = mouseX/(width/mapX);
		mX = mouseX;
		y = mouseY/(height/mapY);
		mY = mouseY;
	}

	int getRemainingFrames() {
	  return framesUntilDestroyed;
	}

	void decrementFramesRemaining() {
		if (this.framesUntilDestroyed > 0) {
			this.framesUntilDestroyed -= 1;
			println("player " + this.id + ":" + this.framesUntilDestroyed);
		} else {
    	// TODO: player is dead, change game state
        }
	}
}
