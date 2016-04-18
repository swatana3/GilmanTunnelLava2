// MapController - handles rock and map models

boolean useOpenNI = false; //for testing only

SimpleOpenNI context;
float        zoomF =0.5f;
float        rotX = radians(180);  // by default rotate the hole scene 180deg around the x-axis, 
// the data from openni comes upside down
float        rotY = radians(180);
boolean      autoCalib=true;

PVector      bodyCenter = new PVector();
PVector      bodyDir = new PVector();
PVector      com = new PVector();                                   
PVector      com2d = new PVector(); 

// postion of feet to draw circle
PVector rightFootPosition = new PVector();
PVector leftFootPosition = new PVector();

//calibrated Left Right Position
PVector rightFootPosCalibrate = new PVector();
PVector leftFootPosCalibrate = new PVector();
// turn feet into scalar form
float distanceScalarL;
float distanceScalarR;
// variables used for linear interpolation
float leftLerpX = 0;
float leftLerpY = 0;
float leftLastX = 0;
float leftLastY = 0;
float rightLerpX = 0;
float rightLerpY = 0;
float rightLastX = 0;
float rightLastY = 0;
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
  //need to claibrate to where the screen is..
  void drawSkeletonCalibrated(int userId){
  // get 3D positions of feet
    context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_FOOT, leftFootPosition);
    context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_FOOT, rightFootPosition);
    // convert real world point to projective space
    context.convertRealWorldToProjective(leftFootPosition, leftFootPosition);
    context.convertRealWorldToProjective(rightFootPosition, rightFootPosition);
    // create a distance scalar related to the depth in z dimension
    distanceScalarL = (525/leftFootPosition.z);
    distanceScalarR = (525/rightFootPosition.z);
    // draw the circle at the position of the head with the head size scaled by the distance scalar
    leftLerpX = lerp(leftLastX, leftFootPosition.x, 0.3f);
    leftLerpY = lerp(leftLastY, leftFootPosition.y, 0.3f);
    rightLerpX = lerp(rightLastX, rightFootPosition.x, 0.3f);
    rightLerpY = lerp(rightLastY, rightFootPosition.y, 0.3f);
    //covert these ellipse to the thing on the screen...
    // x range feet (16, 598) //range difference = 582
    // y range feet (343, 406) //range difference = 63
    //convert cordinates 500x70 to 2200x100
    //float: x-coordinate of the ellipse, float: y-coordinate of the ellipse
    //float: width of the ellipse by default,  float: height of the ellipse by default
   
    leftFootPosCalibrate.x = (leftLerpX - 16.0) * (width/582.0);
    leftFootPosCalibrate.y = (leftLerpY - 343.0) * (height/63.0);
    leftFootPosCalibrate.z = 0;
    //make sure nothing is neg
    if (leftFootPosCalibrate.x <0){
      leftFootPosCalibrate.x = 0;
    }
    if (leftFootPosCalibrate.y <0){
      leftFootPosCalibrate.x = 0;
    }
    
    rightFootPosCalibrate.x = (rightLerpX - 55.0) * (width/500.0);
    rightFootPosCalibrate.y = (righttLerpY - 320.0) * (height/70.0);
    rightFootPosCalibrate.z = 0;
    //make sure nothing is neg
    if (rightFootPosCalibrate.x <0){
      rightFootPosCalibrate.x = 0;
    }
    if (rightFootPosCalibrate.y <0){
      rightFootPosCalibrate.x = 0;
    }
    
    ellipse(leftFootPosCalibrate.x, leftFootPosCalibrate.y, distanceScalarL*feetSize,distanceScalarL*feetSize);
    ellipse(rightFootPosCalibrate.x, righttFootPosCalibrate.y, distanceScalarR*feetSize,distanceScalarR*feetSize);
    
    leftLastX = leftLerpX;
    leftLastY = leftLerpY;
    rightLastX = rightLerpX;
    rightLastY = rightLerpY;
  }
  
  // SimpleOpenNI user events

  void onNewUser(SimpleOpenNI curContext, int userId)
  {
    println("onNewUser - userId: " + userId);
    println("\tstart tracking skeleton");

    context.startTrackingSkeleton(userId);
  }

  void onLostUser(SimpleOpenNI curContext, int userId)
  {
    println("onLostUser - userId: " + userId);
  }

  void onVisibleUser(SimpleOpenNI curContext, int userId)
  {
    //println("onVisibleUser - userId: " + userId);
  }

  //figures out if user is standing in that 1 zone...
  //deals with frames pressed
  void standingZone5sec(){
    //have a slightly widerzone
    
    if (leftFootPosCalibrate.x <= 600 && leftFootPosCalibrate.x >= 250){
    framesPressed++
    return true:
  }
  void update() {
    switch(mapModel.getState()) {
      case START:
        //Only start if the player has been standing for 5 consecutive seconds.
        if (standingZone5sec()) {//standing in zone for at least 300 frames
          framesPressed = 0;  
          mapModel.beginRules();
        }
        break;
      case RULES:
        //should add an if case, haven't yet, got rid of mousePressed
        mapModel.beginCalibration();
        break;
      case PLAY:
        int[] userList = context.getUsers();
        for (int i=0; i<userList.length; i++)
          {
            if (context.isTrackingSkeleton(userList[i]))
              drawSkeletonCalibrated(userList[i]);
          // finds the center of mass
            PlayerModel player = mapModel.players.get(0);
            //scale to processing coordinates
            //Need to set x, set y....
            player.setRawLX(leftFootPosCalibrate.x);
            player.setRawLY(leftFootPosCalibrate.y);
            player.setRawRX(rightFootPosCalibrate.x);
            player.setRawRY(rightFootPosCalibrate.y);
        }
        break;
    }
  }
  
  MapModel getMapModel(){
    return mapModel;
  }
}
