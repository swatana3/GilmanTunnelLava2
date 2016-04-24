// MapController - handles rock and map models

boolean useOpenNI = false; //for testing only

SimpleOpenNI context;

//calibrated Left Right Position
int[] userList;
// diameter of feet drawn in pixels
float feetSize = 200;
// user colors
color[] userColor = new color[]{ color(255,0,0), color(0,255,0), color(0,0,255),
                                 color(255,255,0), color(255,0,255), color(0,255,255)};


class MapController {
  private MapModel mapModel;
  private int framesPressed;

  // constructor
  MapController(MapModel mapModel, PApplet main) {
    this.mapModel = mapModel;
    framesPressed = 0;
    
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
    context.startTrackingSkeleton(userId);
    
    PlayerModel player = mapModel.players.get(userId -1);

  // get 3D positions of feet
    println("in draw slekelton " + userId);
    
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
    
    println("draw skeleton leftFootPosition is " + leftFootPosition);
    println("draw skeleton rightFootPosition is " + rightFootPosition);
    // create a distance scalar related to the depth in z dimension
    float distanceScalarL = (525/leftFootPosition.z);
    float distanceScalarR = (525/rightFootPosition.z);
    
    player.setDistanceScalarL(distanceScalarL);
    player.setDistanceScalarL(distanceScalarR);
    
    
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
   
    leftFootPosCalibrate.x = width - ((leftLerpX - 16.0) * (width/582.0));
    leftFootPosCalibrate.y = (leftLerpY - 343.0) * (height/63.0);
    leftFootPosCalibrate.z = 0;
    //make sure nothing is neg
    if (leftFootPosCalibrate.x <0){
      leftFootPosCalibrate.x = 0;
    }
    if (leftFootPosCalibrate.y <0){
      leftFootPosCalibrate.y = 0;
    }
    
    rightFootPosCalibrate.x = width - (rightLerpX - 16.0) * (width/582.0);
    rightFootPosCalibrate.y = (rightLerpY - 343.0) * (height/63.0);
    rightFootPosCalibrate.z = 0;
    //make sure nothing is neg
    if (rightFootPosCalibrate.x <0){
      rightFootPosCalibrate.x = 0;
    }
    if (rightFootPosCalibrate.y <0){
      rightFootPosCalibrate.y = 0;
    }
      
    leftLastX = leftLerpX;
    leftLastY = leftLerpY;
    rightLastX = rightLerpX;
    rightLastY = rightLerpY;
    
    player.setRawLX(leftFootPosCalibrate.x);
    player.setRawLY(leftFootPosCalibrate.y);
    player.setRawRX(rightFootPosCalibrate.x);
    player.setRawRY(rightFootPosCalibrate.y);
     
    player.setLeftLastX(leftLastX);
    player.setLeftLastY(leftLastY);
    player.setRightLastX(rightLastX);
    player.setRightLastY(rightLastY);
  }
  

  //figures out if user is standing in that 1 zone...
  //deals with frames pressed, and gives a wider range for error
//  boolean standingZone5sec(int userId){
//    PVector leftFootPosCalibrate = leftFootPosCalibrates.get(userId-1);
//    PVector rightFootPosCalibrate = rightFootPosCalibrates.get(userId -1);
//    if (leftFootPosCalibrate.x <= 430 && leftFootPosCalibrate.x >=70 ){
//      if (leftFootPosCalibrate.y <= 440 && leftFootPosCalibrate.y >= 80){
//        if (rightFootPosCalibrate.x <= 430 && rightFootPosCalibrate.x >=70 ){
//          if (rightFootPosCalibrate.y <= 440 && rightFootPosCalibrate.y >= 80){
//            framesPressed++;
////            println("They are standing in the zone");
//            fill(255,200,200);
//            ellipse(leftFootPosCalibrate.x, leftFootPosCalibrate.y, distanceScalarL*feetSize,distanceScalarL*feetSize);
//            ellipse(rightFootPosCalibrate.x, rightFootPosCalibrate.y, distanceScalarR*feetSize,distanceScalarR*feetSize);
//          }
//        }
//      }
//    } else{
////      println("not in standing zone");
////      println("not standing zone leftPosCalibrate is " + leftFootPosCalibrate);
////      println("not standing zone rightPosCalibrate is " + rightFootPosCalibrate);
//      
//      framesPressed = 0;
//    }
//    if (framesPressed >= 60){
//      return true;
//    }
//    return false;
//  }
  void update() {
    context.update();
    switch(mapModel.getState()) {
      case START:
//        println("hello");
        userList  = context.getUsers();
        for (int i=0; i<userList.length; i++)
        {
            if (context.isTrackingSkeleton(userList[i])){
              //sets the playerRaw values 
               getLeftRightFoot(userList[i]);
//              if (standingZone5sec(userList[i])) {//standing in zone for at least 300 frames
                framesPressed = 0;  
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
        userList = context.getUsers();
        for (int i=0; i<userList.length; i++)
          {
            if (context.isTrackingSkeleton(userList[i])) (
            getLeftRightFoot(userList[i]);
            PlayerModel player = mapModel.players.get(0);
        }
        break;
    }
  }
  
  MapModel getMapModel(){
    return mapModel;
  }
}
