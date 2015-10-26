class PlayerModel {
        // more precise location for player,
	// can be mapped to index in game map later
	int x,y;
	// dimensions of the world the player is in
	int mapX, mapY;
	// 
	Player(MapModel mapModel) {
		this.mapX = mapModel.mapX;
		this.mapY = mapModel.mapY;
	}

	void update() {
		// convert coordinates
		x = mouseX/(width/mapX);
		y = mouseY/(height/mapY);
	}
}
