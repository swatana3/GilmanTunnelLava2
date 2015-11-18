class MapModel {
  //Generation constants 
  static final int MIN_STEP_SIZE = 20, MAX_STEP_SIZE = 70;
  
  //State of map
  GameState state; 
  ArrayList<RockModel> rocks;
  ArrayList<PlayerModel> players;
  CollisionModel collisionModel;
  
  // number of players playing, used for player ID
  int playerCount = 0;
  
  public MapModel() {
    rocks = new ArrayList<RockModel>();
    players = new ArrayList<PlayerModel>();
    collisionModel = new CollisionModel(this);
    // TODO: get blob/dots from kinect and add those as players
    // for now, just use the mouse (mouse is used in player)  
    players.add(new PlayerModel(playerCount));
    playerCount += 1;

    // procedurally generate rocks for the map
    //generateMap();
    generateFullMap();
    state = GameState.START;
  }
  
  void update() {
    if (state == GameState.START) {
        if (mousePressed) {
          state = GameState.PLAY;
        }
    } else if (state == GameState.PLAY) {
        for (PlayerModel player : mapModel.players) {
          player.update();
        }
        for (RockModel rock : mapModel.rocks) {
          rock.update();
        }
        collisionModel.update();
        
        //perform victory/death condition check here
        // 3 pixel edge tolerance
        //On notification player has crossed edge boundary
        //if (player.mX >= width-3) {
        //this.mapModel.state = GameState.WIN;
        //}
    }
  }
  
  // add to rocks so someone can get across
  // doesn't use grid for rocks
  
  private void generateFullMap() {
    int currentY, currentX;
    float angle, dist;
    // randomly pick a y value to start at
    currentY = (int) random(RockModel.HEIGHT/2, height - RockModel.HEIGHT/2);
    // pick a random distance away from the left hand edge of the window
    currentX = (int) random(MAX_STEP_SIZE) + RockModel.WIDTH/2;
    rocks.add(new RockModel(currentX, currentY));
    // while we are not within one STEP away from the RHS
    // closest way to get from the circle to the RHS is a straight line --->
    while (currentX + RockModel.WIDTH/2 < width - MAX_STEP_SIZE) {
      // only works since the height and the width are the same
      dist = RockModel.HEIGHT + random(MIN_STEP_SIZE, MAX_STEP_SIZE);
                    // min and max angles using trig
                    // subtract PI/2 to rotate 90 degrees CW
      angle = random(acos(min((currentY - RockModel.HEIGHT/2.0), dist)/dist),
                    PI - acos(min((height - RockModel.HEIGHT/2.0 - currentY), dist)/dist)) - PI/2.0;
      // take min so the last rock doesn't go off the right side of the screen
      currentX += (int) min((dist * cos(angle)), width - RockModel.WIDTH/2);
      currentY += (int) (dist * sin(angle));

      // make sure no collision with any other rocks
      boolean clear = true;
      for (int i = 0; i < this.rocks.size() && clear; ++i) {
        // are the rock centers at least RockModel.WIDTH away?
        // just taking x coordinate distance into account
        if (abs(this.rocks.get(i).cX - currentX) < RockModel.WIDTH) {
          // could encounter collision, don't add this rock
          clear = false;
        }
      }
      if (clear) {
        rocks.add(new RockModel(currentX, currentY));
      }

    }
  }
}

