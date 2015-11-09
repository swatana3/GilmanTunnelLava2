class MapModel {
  static final int MIN_STEP_SIZE = 20, MAX_STEP_SIZE = 70;

  ArrayList<RockModel> rocks;
  ArrayList<PlayerModel> players;
  // dimensions of map/game board
  int mapX, mapY;

  // number of players
  int playerCount;

  //State of map
  GameState state; 
  
  public MapModel() {
    // number of players playing, used for player ID
    this.playerCount = 0;
    
    rocks = new ArrayList<RockModel>();
    // procedurally generate rocks for the map
    //generateMap();
    generateFullMap();
    players = new ArrayList<PlayerModel>();
    // TODO: get blob/dots from kinect and add those as players
    // for now, just use the mouse (mouse is used in player)
    players.add(new PlayerModel(this));

    state = GameState.START;
  }
  // add to rocks so someone can get across
  // doesn't use grid for rocks
  void generateFullMap() {
    int currentY, currentX;
    float randomAngle, randomDistance;
    // randomly pick a y value to start at
    currentY = (int) random(RockModel.HEIGHT/2, height - RockModel.HEIGHT/2);
    // pick a random distance away from the left hand edge of the window
    currentX = (int) random(MAX_STEP_SIZE) + RockModel.WIDTH/2;
    rocks.add(new RockModel(currentX, currentY));
    // while we are not within one STEP away from the RHS
    // closest way to get from the circle to the RHS is a straight line --->
    while (currentX + RockModel.WIDTH/2 < width - MAX_STEP_SIZE) {
                    // min and max angles using trig
                    // subtract PI/2 to rotate 90 degrees CW
      randomAngle = random(acos(min((currentY - RockModel.HEIGHT/2.0), MAX_STEP_SIZE)/MAX_STEP_SIZE),
                    PI - acos(min((height - RockModel.HEIGHT/2.0 - currentY), MAX_STEP_SIZE)/MAX_STEP_SIZE)) - PI/2.0;
      // only works since the height and the width are the same
      randomDistance = RockModel.HEIGHT + random(MIN_STEP_SIZE, MAX_STEP_SIZE);
      currentX += (int) (randomDistance * cos(randomAngle));
      currentY += (int) (randomDistance * sin(randomAngle));
      rocks.add(new RockModel(currentX, currentY));
    }
  }
}