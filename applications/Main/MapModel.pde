class MapModel {
  ArrayList<RockModel> rocks;
  ArrayList<PlayerModel> players;
  // dimensions of map/game board
  int mapX, mapY;

  // number of players
  int playerCount;

  //State of map
  GameState state; 
  
  public MapModel() {
    // dimension of map, rock can fit in grid <mapX> by <mapY>
    // these can change
    this.mapX = 6;
    this.mapY = 4;
    
    this.playerCount = 0;
    
    rocks = new ArrayList<RockModel>();
    // procedurally generate rocks for the map
    generateMap();
    players = new ArrayList<PlayerModel>();
    // TODO: get blob/dots from kinect and add those as players
    // for now, just use the mouse (mouse is used in player)
    players.add(new PlayerModel(this));

    state = GameState.START;
  }
  // add to rocks so someone can get across
  void generateMap() {
    float rand;
    int offsetX, offsetY;
    int currentX = 0, currentY;
    boolean rock_exists;
    currentY = (int) random(mapY);
    rocks.add(new RockModel(currentX, currentY, mapX, mapY));
    while (currentX < mapX - 1) {
      rock_exists = false;
      rand = random(1);
      if      (rand < .2)   { continue; }
      else if (rand < .8)   { offsetX = 1; }
      else                  { offsetX = 2; }
      // generating a point out of bounds
      if (currentX + offsetX >= mapX) {
        currentX = mapX - 1;
      } else {
        currentX += offsetX;
      }
      do {
        rand = random(1);
        if      (rand < .15)  { offsetY = -2; }
        else if (rand < .4)   { offsetY = -1; }
        else if (rand < .6)   { offsetY = 0; }
        else if (rand < .85)  { offsetY = 1; }
        else                  { offsetY = 2; }
      // generating a point out of bounds
      } while (currentY + offsetY < 0 || currentY + offsetY >= mapY);
      currentY += offsetY;
      // check if rock already exists
      for (RockModel rock : rocks) {
        if (rock.getX() == currentX && rock.getY() == currentY) {
          rock_exists = true;
        }
      }
      if (!rock_exists) {
        rocks.add(new RockModel(currentX, currentY, mapX, mapY));
      }
    }
  }
}
// probabilities for putting rock in x/y offsets
// .2 - same x, .6 +1 to x, .2 +2 x
//y's: .15 -2, .25 -1 .2 0, .25 +1, .15 +2
