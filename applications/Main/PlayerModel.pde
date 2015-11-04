class PlayerModel {
        // index of player on game map
	int x,y;
	// dimensions of the world the player is in
	int mapX, mapY;
        // player id
        int id;
        
	int framesUntilDestroyed = -1;

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
		y = mouseY/(height/mapY);
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
