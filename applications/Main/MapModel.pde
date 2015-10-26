class MapModel {
  ArrayList<RockModel> rocks;
  ArrayList<PlayerModel> players;
  // dimensions of map/game board
  int mapX, mapY;

  public MapModel() {
    // these can change
    this.mapX = 6;
    this.mapY = 4;
    
    // TODO: randomize locations
    rocks = new ArrayList<RockModel>();
    rocks.add(new RockModel(1, 1, mapX, mapY));
    rocks.add(new RockModel(4, 3, mapX, mapY));
    rocks.add(new RockModel(0, 2, mapX, mapY));
    rocks.add(new RockModel(3, 0, mapX, mapY));

    rocks.add(new RockModel(5, 3, mapX, mapY));
    players = new ArrayList<PlayerModel>();
    // TODO: mouse by default
    players.add(new PlayerModel(this));

  }
}

