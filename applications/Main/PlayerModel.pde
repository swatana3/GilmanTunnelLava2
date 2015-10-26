class PlayerModel {
        // index of player on game map
	int x,y;
	// dimensions of the world the player is in
	int mapX, mapY;
	// 
	PlayerModel(MapModel mapModel) {
		this.mapX = mapModel.mapX;
		this.mapY = mapModel.mapY;
	}

	void update() {
		// convert coordinates
		x = mouseX/(width/mapX);
		y = mouseY/(height/mapY);
	}
}
