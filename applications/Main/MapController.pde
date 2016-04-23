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
ArrayList<PVector> rightFootPositions = new ArrayList<PVector>(); //each userId has one
ArrayList<PVector> leftFootPositions = new ArrayList<PVector>();

//calibrated Left Right Position
ArrayList<PVector> rightFootPosCalibrates = new ArrayList <PVector>(); 
ArrayList<PVector> leftFootPosCalibrates = new ArrayList<PVector>();
int[] userList;
// turn feet into scalar form
float distanceScalarL;
float distanceScalarR;
// variables used for linear interpolation
FloatList leftLerpXs = new FloatList();
FloatList leftLerpYs = new FloatList();
FloatList leftLastXs = new FloatList();
FloatList leftLastYs = new FloatList();
FloatList rightLerpXs = new FloatList();
FloatList rightLerpYs = new FloatList();
FloatList rightLastXs = new FloatList();
FloatList rightLastYs = new FloatList();
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
  void drawSkeletonCalibrated(int userId){
    context.startTrackingSkeleton(userId);
  // get 3D positions of feet
    println("in draw slekelton " + userId);
    if (leftFootPositions.size() < userId){
      println("I WAS LESS");
      leftFootPositions.add(new PVector());
      rightFootPositions.add(new PVector()); 
      leftFootPosCalibrates.add(new PVector());
      rightFootPosCalibrates.add(new PVector());
      leftLerpXs.append(0);
      leftLerpYs.append(0);
      leftLastXs.append(0);
      leftLastYs.append(0);
      rightLerpXs.append(0);
      rightLerpYs.append(0);
      rightLastXs.append(0);
      rightLastYs.append(0);
    }
    println("leftFootPosition sixze is " + leftFootPositions.size() );
    PVector leftFootPosition = leftFootPositions.get(userId-1);
    PVector rightFootPosition = rightFootPositions.get(userId -1);
    PVector leftFootPosCalibrate =leftFootPosCalibrates.get(userId-1);
    PVector rightFootPosCalibrate = rightFootPosCalibrates.get(userId-1);
    float leftLerpX = leftLerpXs.get(userId-1);
    float leftLerpY = leftLerpYs.get(userId-1);
    float leftLastX = leftLastXs.get(userId-1);
    float leftLastY = leftLastYs.get(userId-1);
    float rightLerpX = rightLerpXs.get(userId-1);
    float rightLerpY = rightLerpYs.get(userId-1);
    float rightLastX = rightLastXs.get(userId-1);
    float rightLastY = rightLastYs.get(userId-1);
    
    context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_FOOT, leftFootPosition);
    context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_FOOT, rightFootPosition);
    // convert real world point to projective space
    context.convertRealWorldToProjective(leftFootPosition, leftFootPosition);
    context.convertRealWorldToProjective(rightFootPosition, rightFootPosition);
    
    println("draw skeleton leftFootPosition is " + leftFootPosition);
    println("draw skeleton rightFootPosition is " + rightFootPosition);
    // create a distance scalar related to the depth in z dimension
    distanceScalarL = (525/leftFootPosition.z);
    distanceScalarR = (525/rightFootPosition.z);
    // draw the circle at the position of the head with the head size scaled by the distance scalar
    
    leftLerpX = lerp(leftLastX, leftFootPosition.x, 0.3f);
    leftLerpY = lerp(leftLastY, leftFootPosition.y, 0.3f);
    rightLerpX = lerp(rightLastX, rightFootPosition.x, 0.3f);
    rightLerpY = lerp(rightLastY, rightFootPosition.y, 0.3f);
//    
//    println(leftLerpX);
//    println(leftLerpY);
//    println(rightLerpX);
//    println(rightLerpY);
//    
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
    
    
    ellipse(leftFootPosCalibrate.x, leftFootPosCalibrate.y, distanceScalarL*feetSize,distanceScalarL*feetSize);
    ellipse(rightFootPosCalibrate.x, rightFootPosCalibrate.y, distanceScalarR*feetSize,distanceScalarR*feetSize);
    
    
    
    leftLastX = leftLerpX;
    leftLastY = leftLerpY;
    rightLastX = rightLerpX;
    rightLastY = rightLerpY;
    
    leftFootPositions.set(userId-1,leftFootPosition );
    rightFootPositions.set(userId -1, rightFootPosition);
    leftFootPosCalibrates.set(userId-1,leftFootPosCalibrate );
    rightFootPosCalibrates.set(userId-1,rightFootPosCalibrate);
    leftLerpXs.set(userId-1,leftLerpX );
    leftLerpYs.set(userId-1,leftLerpY );
    leftLastXs.set(userId-1, leftLastX);
    leftLastYs.set(userId-1,leftLastY );
    rightLerpXs.set(userId-1, rightLerpX);
    rightLerpYs.set(userId-1,rightLerpY );
    rightLastXs.set(userId-1,rightLastX );
    rightLastYs.set(userId-1, rightLastY);
    
    //need to set values at the emd ...
    
  }
  

  //figures out if user is standing in that 1 zone...
  //deals with frames pressed, and gives a wider range for error
  boolean standingZone5sec(int userId){
    PVector leftFootPosCalibrate = leftFootPosCalibrates.get(userId-1);
    PVector rightFootPosCalibrate = rightFootPosCalibrates.get(userId -1);
    if (leftFootPosCalibrate.x <= 430 && leftFootPosCalibrate.x >=70 ){
      if (leftFootPosCalibrate.y <= 440 && leftFootPosCalibrate.y >= 80){
        if (rightFootPosCalibrate.x <= 430 && rightFootPosCalibrate.x >=70 ){
          if (rightFootPosCalibrate.y <= 440 && rightFootPosCalibrate.y >= 80){
            framesPressed++;
//            println("They are standing in the zone");
            fill(255,200,200);
            ellipse(leftFootPosCalibrate.x, leftFootPosCalibrate.y, distanceScalarL*feetSize,distanceScalarL*feetSize);
            ellipse(rightFootPosCalibrate.x, rightFootPosCalibrate.y, distanceScalarR*feetSize,distanceScalarR*feetSize);
          }
        }
      }
    } else{
//      println("not in standing zone");
//      println("not standing zone leftPosCalibrate is " + leftFootPosCalibrate);
//      println("not standing zone rightPosCalibrate is " + rightFootPosCalibrate);
      
      framesPressed = 0;
    }
    if (framesPressed >= 60){
      return true;
    }
    return false;
  }
  void update() {
    context.update();
    switch(mapModel.getState()) {
      case START:
//        println("hello");
        userList  = context.getUsers();
//        println("userList is " + userList);
        for (int i=0; i<userList.length; i++)
          {
//            println("userList i is" + i);
//            if (context.isTrackingSkeleton(userList[i])) {
//              println("user is being tracked");
              drawSkeletonCalibrated(userList[i]);
              if (standingZone5sec(userList[i])) {//standing in zone for at least 300 frames
                framesPressed = 0;  
                mapModel.beginRules();
              }
//            }
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
            if (context.isTrackingSkeleton(userList[i]))
              drawSkeletonCalibrated(userList[i]);
          // finds the center of mass
            PlayerModel player = mapModel.players.get(0);
            //scale to processing coordinates
            //Need to set x, set y....
            player.setRawLX((int)leftFootPosCalibrates.get(userList[i]-1).x);
            player.setRawLY((int)leftFootPosCalibrates.get(userList[i]-1).y);
            player.setRawRX((int)rightFootPosCalibrates.get(userList[i]-1).x);
            player.setRawRY((int)rightFootPosCalibrates.get(userList[i]-1).y);
        }
        break;
    }
  }
  
  MapModel getMapModel(){
    return mapModel;
  }
}
