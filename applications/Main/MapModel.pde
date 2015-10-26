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
    rocks.add(new RockModel(1, 2));
    rocks.add(new RockModel(4, 3));
    rocks.add(new RockModel(5, 2));
    // TODO: move setFrameLife into RockModel constructor
    for (RockModel rock : rocks) {
      rock.setFrameLife(50);
    }
    players = new ArrayList<PlayerModel>();
    // TODO: implement this
    players.add(new PlayerModel("mouse?"));

  }
}

