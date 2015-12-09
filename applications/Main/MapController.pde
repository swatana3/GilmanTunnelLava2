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

class MapController {
  MapModel mapModel;

  // constructor
  MapController(MapModel mapModel, PApplet main) {
    this.mapModel = mapModel;

    if (useOpenNI) {
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
  }
  
  // Finds the direction of the body
  void findDirection(int userId)
  {
    // find body direction
    getBodyDirection(userId, bodyCenter, bodyDir);

    bodyDir.mult(200);  // 200mm length
    bodyDir.add(bodyCenter);
  }

  // -----------------------------------------------------------------
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

  void getBodyDirection(int userId, PVector centerPoint, PVector dir)
  {
    PVector jointL = new PVector();
    PVector jointH = new PVector();
    PVector jointR = new PVector();
    float  confidence;

    // gets confidences for joint positions
    confidence = context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, jointL);
    confidence = context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_HEAD, jointH);
    confidence = context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, jointR);

    // take the neck as the center point
    confidence = context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_NECK, centerPoint);

    /*  // manually calc the centerPoint
     PVector shoulderDist = PVector.sub(jointL,jointR);
     centerPoint.set(PVector.mult(shoulderDist,.5));
     centerPoint.add(jointR);
     */

    PVector up = PVector.sub(jointH, centerPoint);
    PVector left = PVector.sub(jointR, centerPoint);

    dir.set(up.cross(left));
    dir.normalize();
  }

  void update() {
    if (useOpenNI) {
      context.update();
      switch(mapModel.getState()) {
      case START:
        //TODO: implement multiple players and adding/dropping players
        break;
      case PLAY:
        int[] userList = context.getUsers();
        for (int i=0; i<userList.length; i++)
        {
          if (context.isTrackingSkeleton(userList[i]))
            findDirection(userList[i]);

          // finds the center of mass
          if (context.getCoM(userList[i], com))
          {
            //for now we're only doing one player
            PlayerModel player = mapModel.players.get(0);
            //scale to processing coordinates
            player.setRawX((int)com.x + 1100);
            player.setRawY((int)com.y + 500);
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

