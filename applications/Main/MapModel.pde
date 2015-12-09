class MapModel implements Observer {
  //Generation constants 
  static final int MIN_STEP_SIZE = 20, MAX_STEP_SIZE = 70;

  //State of map
  private GameState state; 
  ArrayList<RockModel> rocks;
  ArrayList<PlayerModel> players;
  CollisionModel collisionModel;
  int framesSinceCalibrate = 0;

  // number of players playing, used for player ID
  int playerCount = 0;

  public MapModel() {
    rocks = new ArrayList<RockModel>();
    players = new ArrayList<PlayerModel>();
    collisionModel = new CollisionModel(this);
    // TODO: get blob/dots from kinect and add those as players
    // for now, just use the mouse (mouse is used in player)
    PlayerModel player = new PlayerModel(playerCount);
    player.playerDeadEvent().addObserver(this);
    players.add(player);

    playerCount += 1;

    // procedurally generate rocks for the map
    //generateMap();
    generateFullMap();
    state = GameState.START;
  }

  public void onNotify(Event event) {
    if (event instanceof PlayerDeadEvent) {
      //state = GameState.LOSE;
    }
  }

  public GameState getState() {
    return state;
  }

  public void beginCalibration() {
    // skip calibration
    //state = GameState.CALIBRATE1;
    state = GameState.PLAY;

  }

  void update() {
    //consider just using a calibrate state and a countdown state,
    // and let the view fire an event when it's done cycling through
    // the countdown/calibration screens
    switch (state) {
      case START:
        break;
      case CALIBRATE1:
        if (framesSinceCalibrate > 100) {
          state = GameState.CALIBRATE2;
        } else {
          framesSinceCalibrate++;
        }
        break;
      case CALIBRATE2:
        if (framesSinceCalibrate > 200) {
          state = GameState.CALIBRATE3;
        } else {
          framesSinceCalibrate++;
        }
        break;
      case CALIBRATE3:
        if (framesSinceCalibrate > 300) {
          state = GameState.COUNTDOWN1;
        } else {
          framesSinceCalibrate++;
        }
        break;
      case COUNTDOWN1:
        if (framesSinceCalibrate > 400) {
          state = GameState.COUNTDOWN2;
        } else {
          framesSinceCalibrate++;
        }
        break;
      case COUNTDOWN2:
        if (framesSinceCalibrate > 500) {
          state = GameState.COUNTDOWN3;
        } else {
          framesSinceCalibrate++;
        }
        break;
      case COUNTDOWN3:
        if (framesSinceCalibrate > 600) {
          state = GameState.PLAY;
        } else {
          framesSinceCalibrate++;
        }
        break;
      case PLAY:
        for (PlayerModel player : mapModel.players) {
          player.update();
          //perform victory/death condition check here
          // 3 pixel edge tolerance
          //On notification player has crossed edge boundary
          if (player.getRawX() >= width-3) {
            //state = GameState.WIN;
          }
        }
        ArrayList<RockModel> rocksToDestroy = new ArrayList<RockModel>();
  
        for (RockModel rock : mapModel.rocks) {
          rock.update();
          if (rock.isDestroyed()) {
            rocksToDestroy.add(rock);
          }
        }
        
        //another victory condition?
        if(mapModel.rocks.size()==0) {
          //mapModel.state = GameState.WIN;
        }
        
        collisionModel.update();
  
        //Clean up rocks
        for (RockModel rock : rocksToDestroy) {
          rocks.remove(rock);
        }
        break;
      case WIN:
        System.out.println("WIN!");
        break;
    }
    println("frames since called calibrate is" + framesSinceCalibrate);
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
      for (int i = 0; i < this.rocks.size () && clear; ++i) {
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

