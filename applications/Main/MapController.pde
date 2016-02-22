// MapController - handles rock and map models

boolean useOpenNI = true; //for testing only

SimpleOpenNI context;
//float        zoomF =0.5f;
//float        rotX = radians(180);  // by default rotate the hole scene 180deg around the x-axis, 
//// the data from openni comes upside down
//float        rotY = radians(180);
//boolean      autoCalib=true;

//PVector      bodyCenter = new PVector();
//PVector      bodyDir = new PVector();
//PVector      com = new PVector();                                   
//PVector      com2d = new PVector();  

--------------------------------------------

// image storage from kinect
PImage kinectDepth;
// int of each user being  tracked
int[] userID;
// user colors
color[] userColor = new color[]{ color(255,0,0), color(0,255,0), color(0,0,255),
                                 color(255,255,0), color(255,0,255), color(0,255,255)};
 
// postion of feet to draw circle
PVector rightFootPosition = new PVector();
PVector leftFootPosition = new PVector();
// turn feet into scalar form
float distanceScalarL;
float distanceScalarR;
// variables used for linear interpolation
float leftLerpX = 0;
float leftLerpY = 0;
float leftLastX = 0;
float leftLastY = 0;
float leftClosestX = 0;
float leftClosestY = 0;
float rightLerpX = 0;
float rightLerpY = 0;
float rightLastX = 0;
float rightLastY = 0;
float rightClosestX = 0;
float rightClosestY = 0;
// diameter of feet drawn in pixels
float feetSize = 200;
 
// threshold of level of confidence
float confidenceLevel = 0.5;
// the current confidence level that the kinect is tracking
float confidence;
// vector of tracked head for confidence checking
PVector confidenceVector = new PVector();


class MapController {
  MapModel mapModel;

  // constructor
  MapController(MapModel mapModel, PApplet main) {
    this.mapModel = mapModel;

    if (useOpenNI) {
      kinect = new SimpleOpenNI(this);
      if (kinect.isInit() == false) {
        println("Can't init SimpleOpenNI, maybe the camera is not connected!");
        exit();
        return;
      }
     

      // enable depthMap generation 
      kinect.enableDepth();

      // enable skeleton generation for all joints
      kinect.enableUser();
      
      // draw thickness of drawer
      strokeWeight(3);
      // smooth out drawing
      smooth();
      
     // create a window the size of the depth information
     size(kinect.depthWidth(), kinect.depthHeight());
    }
  }
  //----------UNSURE IF THIS IS NECESSARY---------------
  // Finds the direction of the body
  void findDirection(int userId)
  {
    // find body direction
    drawSkeleton(userId);

    bodyDir.mult(200);  // 200mm length
    bodyDir.add(bodyCenter);
  }

  // -----------------------------------------------------------------
  // SimpleOpenNI user events

  void onNewUser(SimpleOpenNI curContext, int userId)
  {
    println("New User Detected - userId: " + userId);
  // start tracking of user id
  curContext.startTrackingSkeleton(userId);
}
 

  void onLostUser(SimpleOpenNI curContext, int userId)
  {
    // print user lost and user id
    println("User Lost - userId: " + userId);
  }

  void onVisibleUser(SimpleOpenNI curContext, int userId)
  {
    //println("onVisibleUser - userId: " + userId);
  }

  void drawSkeleton(int userId)
  {
    // get 3D positions of feet
    kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_FOOT, leftFootPosition);
    kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_FOOT, rightFootPosition);
    // convert real world point to projective space
    kinect.convertRealWorldToProjective(leftFootPosition, leftFootPosition);
    kinect.convertRealWorldToProjective(rightFootPosition, rightFootPosition);
    // create a distance scalar related to the depth in z dimension
    distanceScalarL = (525/leftFootPosition.z);
    distanceScalarR = (525/rightFootPosition.z);
    // draw the circle at the position of the head with the head size scaled by the distance scalar
    leftLerpX = lerp(leftLastX, leftFootPosition.x, 0.5f);
    leftLerpY = lerp(leftLastY, leftFootPosition.y, 0.5f);
    rightLerpX = lerp(rightLastX, rightFootPosition.x, 0.3f);
    rightLerpY = lerp(rightLastY, rightFootPosition.y, 0.3f);
    ellipse(leftLerpX,leftLerpY, distanceScalarL*feetSize,distanceScalarL*feetSize);
    ellipse(rightLerpX,rightLerpY, distanceScalarR*feetSize,distanceScalarR*feetSize);
    leftLastX = leftLerpX;
    leftLastY = leftLerpY;
    rightLastX = rightLerpX;
    rightLastY = rightLerpY;
  }

  void update() {
    if (useOpenNI) {
      kinect.update();
      switch(mapModel.getState()) {
      case START:
        mapModel.beginCalibration();
        //TODO: implement multiple players and adding/dropping players
        break;
      case PLAY:
        int[] userID = kinect.getUsers();
        for (int i=0; i<userID.length; i++)
        {
          if (kinect.isTrackingSkeleton(userID[i]))
            findDirection(userList[i]);

          // finds the center of mass
          if (kinect.getCoM(userID[i], com))
          {
            //for now we're only doing one player
            PlayerModel player = mapModel.players.get(0);
            //scale to processing coordinates
            player.setRawX((-1)*(int)com.x + 1100);
            player.setRawY((-1)*(int)com.y + 500);
            println("x: " + com.x + " y: " + com.y);
          }
        }
        break;
      }
    } else {
      switch(mapModel.getState()) {
      case START:
        if (mousePressed) {
          mapModel.beginCalibration();
        }
        break;
      case PLAY:
        for (PlayerModel player : mapModel.players) {
          player.setRawX(mouseX); 
          player.setRawY(mouseY);
          println("mousex mod: " + mouseX + " mousey mod: " + mouseY);
        }
        break;
      }
    }
  }
}