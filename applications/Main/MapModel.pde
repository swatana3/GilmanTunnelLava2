class MapModel implements Observer {
  //Generation constants 
  static final int MIN_STEP_SIZE = 20, MAX_STEP_SIZE = 70;

  //State of map
  private GameState state; 
  private ArrayList<RockModel> rocks;
  private ArrayList<PlayerModel> players;
  private CollisionModel collisionModel;
  private int framesSinceCalibrate = 0;
  private int level = 1;
  private boolean win_reset = false;
  private Lava lava;
  private int original_num_rocks = 0;

  // number of players playing, used for player ID
  private int playerCount = 0;

  public MapModel() {
    level = 1;
    lava = new Lava();
    rocks = new ArrayList<RockModel>();
    original_num_rocks = 0;
    players = new ArrayList<PlayerModel>();
    //not sure
    framesSinceCalibrate = 0;
    
    collisionModel = new CollisionModel(this);
    // TODO: get blob/dots from kinect and add those as players
    // for now, just use the mouse (mouse is used in player)
    PlayerModel player = new PlayerModel(playerCount);
    player.playerDeadEvent().addObserver(this);
    //Right now, only allow support for up to five players
//    if (players.size() < 5) {
//      players.add(player);
//      playerCount++;
//    }

    // procedurally generate rocks for the map
    //generateMap();
    generateFullMap();
    state = GameState.START;
  }
    /** Adds a new player to the player list, can't add it with player coordinates,
    does that somewhere else, this makes max players 2 */
  void addPlayer(int id){
    PlayerModel player = new PlayerModel(id);
    if (players.size() < 2) {
      println("added players!");
      players.add(player);
      playerCount++;
    }
  }
  /** Removes player from playerlist given id*/
  void removePlayer(int id){
     players.remove(id - 1);
     playerCount--; 
     println("removed players!");
   }
  
  ArrayList<RockModel> getRocks(){
    return rocks;
  }
  
  ArrayList<PlayerModel> getPlayers(){
    return players;
  }
  
  CollisionModel getCollisionModel(){
    return collisionModel;
  }
  
  int getLevel(){
    return level;
  }
  
  Lava getLava(){
    return lava;
  }
  
  int getOriginal_num_rocks(){
    return original_num_rocks;
  }
  
  int getPlayerCount(){
    return playerCount;
  }

  public void onNotify(Event event) {
    if (event instanceof PlayerDeadEvent) {
      state = GameState.LOSE;  
    }
  }

  /* Resets the game after death/win*/
  void reset() {
    //Reset all counters and variables
    level = 1;
    original_num_rocks = 0;
    playerCount = 0;
    framesSinceCalibrate = 0;
    players.clear();
    rocks.clear();
    //Add the players
    PlayerModel player = new PlayerModel(playerCount);
    player.playerDeadEvent().addObserver(this);
    players.add(player);
    playerCount += 1;
    generateFullMap();
    state = GameState.START;
 
  }
  
  public GameState getState() {
    return state;
  }

  public void beginCalibration() {
    // skip calibration
    //state = GameState.CALIBRATE1;
    state = GameState.BETWEENLEVEL;
    //state = GameState.COUNTDOWN1;
  }
  
  public void beginRules() {
    state = GameState.RULES;
  }

  void update() {
    switch (state) {
      case START:
        break;
      case RULES:
        //blah
        break;
      case CALIBRATE1:
        if (framesSinceCalibrate > 120) {
          state = GameState.CALIBRATE2;
        } else {
          framesSinceCalibrate++;
        }
        break;
      case CALIBRATE2:
        if (framesSinceCalibrate > 240) {
          state = GameState.CALIBRATE3;
        } else {
          framesSinceCalibrate++;
        }
        break;
      case CALIBRATE3:
        if (framesSinceCalibrate > 360) {
          state = GameState.COUNTDOWN1;
          framesSinceCalibrate = 0;
        } else {
          framesSinceCalibrate++;
        }
        break;
      case BETWEENLEVEL:
        if (framesSinceCalibrate > 360){
          framesSinceCalibrate = 0;
        }
        //Only do this if it's not the first level
        if (mapModel.getLevel() != 1){
          if(mapModel.rocks.size()==0) {
            //Add rocks below each player
            for (PlayerModel p : players){
              rocks.add(new RockModel(p.getRawLX(), p.getRawLY(), mapModel.getLevel()));
              rocks.add(new RockModel(p.getRawRX(), p.getRawRY(), mapModel.getLevel()));
            }
            generateFullMap();
          }
        }
        //else
        if (framesSinceCalibrate > 120){
          //We want a flipped countdown
          if (level % 2 == 0){
            state = GameState.FLIPPEDCOUNTDOWN1;
            framesSinceCalibrate = 0;
          } else {
            state = GameState.COUNTDOWN1;
            framesSinceCalibrate = 0;
          }  
        } else {
          framesSinceCalibrate++;
        }
        break;
      case COUNTDOWN1:
        if (framesSinceCalibrate > 120) {
          state = GameState.COUNTDOWN2;
        } else {
          framesSinceCalibrate++;
        }
        break;
      case COUNTDOWN2:
        if (framesSinceCalibrate > 240) {
          state = GameState.COUNTDOWN3;
        } else {
          framesSinceCalibrate++;
        }
        break;
      case COUNTDOWN3:
        if (framesSinceCalibrate > 360) {
          state = GameState.PLAY;
          framesSinceCalibrate = 0;
        } else {
          framesSinceCalibrate++;
        }
        break;
       case FLIPPEDCOUNTDOWN1:
        if (framesSinceCalibrate > 120) {
          state = GameState.FLIPPEDCOUNTDOWN2;
        } else {
          framesSinceCalibrate++;
        }
        break;
      case FLIPPEDCOUNTDOWN2:
        if (framesSinceCalibrate > 240) {
          state = GameState.FLIPPEDCOUNTDOWN3;
        } else {
          framesSinceCalibrate++;
        }
        break;
      case FLIPPEDCOUNTDOWN3:
        if (framesSinceCalibrate > 360) {
          state = GameState.PLAY;
          framesSinceCalibrate = 0;
        } else {
          framesSinceCalibrate++;
        }
        break;
      case PLAY:
        if (framesSinceCalibrate == 0) {
           //add rocks below players if first iteration
           for (PlayerModel p : players) {
             rocks.add(new RockModel(p.getRawLX(), p.getRawLY(), mapModel.getLevel()));
             rocks.add(new RockModel(p.getRawRX(), p.getRawRY(), mapModel.getLevel()));
          }
          framesSinceCalibrate++;
        }
        for (PlayerModel player : mapModel.players) {
          player.update();
        }
        ArrayList<RockModel> rocksToDestroy = new ArrayList<RockModel>();
  
        for (RockModel rock : mapModel.rocks) {
          rock.update(level);
          if (rock.isDestroyed()) {
            rocksToDestroy.add(rock);
          }
        }
        //Victory condition
        if(mapModel.rocks.size()==0) {
          if (level == 3){
            mapModel.state = GameState.WIN;
          } else {
            level++;
            for (PlayerModel player : mapModel.players){
              player.resetHealth();
            }
            mapModel.state = GameState.BETWEENLEVEL;
          }
        }
        
        collisionModel.update();
  
        //Clean up rocks
        for (RockModel rock : rocksToDestroy) {
          rocks.remove(rock);
        }
        rocksToDestroy.clear();
        
        break;
      case WIN:
        if ((framesSinceCalibrate > 0) && (win_reset == false)){
          framesSinceCalibrate = 0;
          win_reset = true;
        } else if ((framesSinceCalibrate > 360) && (win_reset)) {
          state = GameState.RESET;
          win_reset = false;
        } else {
          framesSinceCalibrate++;
        }
        break;

      case LOSE:
        if ((framesSinceCalibrate > 0) && (win_reset == false)){
          framesSinceCalibrate = 0;
          win_reset = true;
        } else if ((framesSinceCalibrate > 360) && (win_reset)) {
          state = GameState.RESET;
          win_reset = false;
          
        } else {
          framesSinceCalibrate++;
        }
        break;
       case RESET:
         reset();
         break;
    }
  }

  //Create rocks
  private void generateFullMap() {
    int currentY, currentX;
    float angle, dist;
    // randomly pick a y value to start at
    currentY = (int) random(RockModel.HEIGHT/2, height - RockModel.HEIGHT/2);
    // pick a random distance away from the left hand edge of the window
    currentX = (int) random(MAX_STEP_SIZE) + RockModel.WIDTH/2;
    rocks.add(new RockModel(currentX, currentY, getLevel()));
    original_num_rocks += 1;
    // while we are not within one STEP away from the RHS
    // closest way to get from the circle to the RHS is a straight line --->
    //The distance scales up with the level
    while (currentX + RockModel.WIDTH/2 < width - (1 + float(level/10) - .1) * MAX_STEP_SIZE) {
      // only works since the height and the width are the same
      dist = RockModel.HEIGHT + random(MIN_STEP_SIZE, (1 + float(level/10) - .1) * MAX_STEP_SIZE);
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
        rocks.add(new RockModel(currentX, currentY, getLevel()));
        original_num_rocks += 1;
      }
    }
  } 
}

