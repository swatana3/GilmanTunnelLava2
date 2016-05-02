// MapController - handles rock and map models

boolean useOpenNI = false; //for testing only

SimpleOpenNI context;

//calibrated Left Right Position
int[] userList;
// diameter of feet drawn in pixels
float feetSize = 200;
// user colors
//color[] userColor = new color[]{ color(255,0,0), color(0,255,0), color(0,0,255),
//                                 color(255,255,0), color(255,0,255), color(0,255,255)};


class MapController {
  private MapModel mapModel;

  // constructor
  MapController(MapModel mapModel, PApplet main) {
    this.mapModel = mapModel;
    
    context = new SimpleOpenNI(main);
      if (context.isInit() == false) {
        println("Can't init SimpleOpenNI, maybe the camera is not connected!");
        exit();
        return;
      }
     // disable mirror
     context.setMirror(false);

     // enable depthMap generation 
     context.enableDepth();

     // enable skeleton generation for all joints
     context.enableUser();
  }
    // SimpleOpenNI user events

  //need to claibrate to where the screen is..
  void getLeftRightFoot(int userId){
    
    ArrayList<PlayerModel> players = mapModel.getPlayers();
    for (int i=0; i<players.size(); i++){
      if (userId == players.get(i).getId()){
        PlayerModel player = players.get(i);
        PVector leftFootPosition = new PVector();
        PVector rightFootPosition = new PVector();
        
        float leftLastX = player.getLeftLastX();
        float leftLastY = player.getLeftLastY();
        float rightLastX = player.getRightLastX();
        float rightLastY = player.getRightLastY();
    
        context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_FOOT, leftFootPosition);
        context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_FOOT, rightFootPosition);
        // convert real world point to projective space
        context.convertRealWorldToProjective(leftFootPosition, leftFootPosition);
        context.convertRealWorldToProjective(rightFootPosition, rightFootPosition);
    
        // create a distance scalar related to the depth in z dimension
        float distanceScalarL = (525/leftFootPosition.z);
        float distanceScalarR = (525/rightFootPosition.z);
    
        player.setDistanceScalarL(distanceScalarL);
        player.setDistanceScalarR(distanceScalarR);
    
        float leftLerpX = lerp(leftLastX, leftFootPosition.x, 0.3f);
        float leftLerpY = lerp(leftLastY, leftFootPosition.y, 0.3f);
        float rightLerpX = lerp(rightLastX, rightFootPosition.x, 0.3f);
        float rightLerpY = lerp(rightLastY, rightFootPosition.y, 0.3f);

        //covert these ellipse to the thing on the screen...
        // x range feet (16, 598) //range difference = 582
        // y range feet (343, 406) //range difference = 63
        //convert cordinates 500x70 to 2200x100
        //float: x-coordinate of the ellipse, float: y-coordinate of the ellipse
        //float: width of the ellipse by default,  float: height of the ellipse by default
   
        float lx = width - ((leftLerpX - 16.0) * (width/582.0));
        float ly = (leftLerpY - 343.0) * (height/63.0);
        //make sure nothing is neg
        if (lx <0){
          lx = 0;
        }
        if (ly <0){
          ly = 0;
        }
        if (lx > 2200){
          lx = 2200;
        }
        if (ly > 2200){
          ly = 2200;
        }
    
        float rx = width - (rightLerpX - 16.0) * (width/582.0);
        float ry = (rightLerpY - 343.0) * (height/63.0);
        //make sure nothing is neg
        if (rx <0){
          rx = 0;
        }
        if (ry <0){
          ry = 0;
        }
        if (rx > 2200){
          rx = 2200;
        }
        if (ry > 2200){
          ry = 2200;
        }
     
        leftLastX = leftLerpX;
        leftLastY = leftLerpY;
        rightLastX = rightLerpX;
        rightLastY = rightLerpY;
    
        player.setRawLX((int)lx);
        player.setRawLY((int)ly);
        player.setRawRX((int)rx);
        player.setRawRY((int)ry);
     
        player.setLeftLastX(leftLastX);
        player.setLeftLastY(leftLastY);
        player.setRightLastX(rightLastX);
        player.setRightLastY(rightLastY);
        }
     }
  }
  

  //figures out if user is standing in that 1 zone...
  //deals with frames pressed, and gives a wider range for error
  void update() {
    context.update();
    ArrayList<PlayerModel> players;
    switch(mapModel.getState()) {
      case START:
        players = mapModel.getPlayers(); 
        for (int i=0; i<players.size(); i++)
        {
          PlayerModel player = players.get(i);
          if (context.isTrackingSkeleton(player.getId())){
          //sets the playerRaw values 
            getLeftRightFoot(player.getId());
            println("playerCount is " + mapModel.getPlayerCount());
            if (standingZone5sec(player.getId())) {//standing in zone for at least 300 frames
                mapModel.beginRules();
            }
          }
        }
        break;
      case RULES:
        //should add an if case, haven't yet, got rid of mousePressed
        mapModel.beginCalibration();
        break;
      case PLAY:
        players = mapModel.getPlayers(); 
        for (int i=0; i<players.size(); i++)
        {
          PlayerModel player = players.get(i);
          if (context.isTrackingSkeleton(player.getId())) {
              getLeftRightFoot(player.getId());
            }
        }
        break;
    }
  }
  
  MapModel getMapModel(){
    return mapModel;
  }
    boolean standingZone5sec(int userId){
      ArrayList<PlayerModel> players = mapModel.getPlayers();
      for (int i=0; i<players.size(); i++){
         if (userId == players.get(i).getId()){  
           PlayerModel p = players.get(i);
            if (p.getRawLX() <= 430 && p.getRawLX() >=70 ){
              if (p.getRawLY() <= 920 && p.getRawLY() >= 560){
                p.incrementFramesPressed();
//                println("They are standing in the zone");
                p.setInStandingZone(true);
              }
            }
            else if (p.getRawRX()<= 430 && p.getRawRX() >=70 ){
              if (p.getRawRY() <= 920 && p.getRawRY()  >= 560){
                p.incrementFramesPressed();
//                println("They are standing in the zone");
                p.setInStandingZone(true);
              }
            } else{
//          println("not in standing zone");
//          println("pLx is " + p.getRawLX());
//          println("pLy is " + p.getRawLY());
//          println("pRx is " + p.getRawRX());
//          println("pRy is " + p.getRawRY());
      
//          p.resetFramesPressed();
           }
           if (p.getFramesPressed() >= 60){
              return true;
          }
        }
      }
      return false;
    }
}
