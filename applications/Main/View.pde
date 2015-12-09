import java.util.Map;

class View implements Observer {
  MapModel mapModel;
  //PImage rockPlatform;
  PImage startScreen;
  PImage loseScreen;
  PImage endScreen;
  PImage winScreen;
  //PImage calibrateScreen
  PImage calibrateScreen1;
  PImage calibrateScreen2;
  PImage calibrateScreen3;
  //PImage countdownScreen
  PImage countdownScreen1;
  PImage countdownScreen2;
  PImage countdownScreen3;

  //static images(gifs were too large)
  PImage rockPlatformOne;
  PImage rockPlatformTwo;
  PImage rockPlatformThree;
  PImage rockDetailOne;
  PImage rockDetailTwo;
  PImage rockDetailThree;
  PImage lavaImg;
  
  //have an arrayList of Rocks while playerisSteppedOnRock and playerStepsOffRock
  

  View(PApplet parent, MapModel mapModel) {
    this.mapModel = mapModel;
    rockPlatformOne = loadImage("../../assets/rockPlatform1.png");
    rockPlatformTwo = loadImage("../../assets/rockPlatform2.png");
    rockPlatformThree = loadImage("../../assets/rockPlatform3.png");
    rockDetailOne = loadImage("../../assets/rockDetail1.png");
    rockDetailTwo = loadImage("../../assets/rockDetail2.png");
    rockDetailThree = loadImage("../../assets/rockDetail3.png");
    startScreen = loadImage("../../assets/Rotated Screens/GT Setting Design_rotated_Start.png");
    endScreen = loadImage("../../assets/Rotated Screens/GT Setting Design_rotated_End.png");
    winScreen = loadImage("../../assets/Rotated Screens/GT Setting Design_End_Win.png");

    endScreen.resize(width, height);
    winScreen.resize(width, height);

    //calibrateScreen
    calibrateScreen1 = loadImage("../../assets/Rotated Screens/GT Setting Design_rotated_Calibrate1.png");
    calibrateScreen2 = loadImage("../../assets/Rotated Screens/GT Setting Design_rotated_Calibrate1.png");
    calibrateScreen3  = loadImage("../../assets/Rotated Screens/GT Setting Design_rotated_Calibrate1.png");

    calibrateScreen1.resize(width, height);
    calibrateScreen2.resize(width, height);
    calibrateScreen3.resize(width, height);

    //countdownScreen
    countdownScreen1 = loadImage("../../assets/Rotated Screens/GT Setting Design_rotated_Countdown1.png");
    countdownScreen2 = loadImage("../../assets/Rotated Screens/GT Setting Design_rotated_Countdown2.png");
    countdownScreen3 = loadImage("../../assets/Rotated Screens/GT Setting Design_rotated_Countdown3.png");

    
    countdownScreen1.resize(width, height);
    countdownScreen2.resize(width, height);
    countdownScreen3.resize(width, height);
    

    //Added the Lava animation gif
    //myAnimation = new Gif(parent, "../../assets/Lava_Animation_AE_shorter.gif");
    lavaImg = loadImage("../../assets/lavabkgd.png" );   
            
    lavaImg.resize(width, height); 

    // make View an observer of PlayerStepsOnRocksEvents
    mapModel.collisionModel.playerStepsOnRockEvent().addObserver(this);

    // window stuff setup
    background (225);
  }

  void render() {
    // redraw background for each frame
    background (225);
    switch (mapModel.getState()) {
      case START:
        imageMode(CORNER);
        image(startScreen, 0, 0, width, height);
        break;
      case CALIBRATE1: 
        background(calibrateScreen1);
        break;
      case CALIBRATE2:
        background(calibrateScreen2);
        break;
      case CALIBRATE3: 
        background(calibrateScreen3);
        break;
      case COUNTDOWN1: 
        background(countdownScreen1);
        break;
      case COUNTDOWN2: 
        background(countdownScreen2);
        break;
      case COUNTDOWN3: 
        background(countdownScreen3);
        break;
      case PLAY: 
        background(lavaImg); 
        for (RockModel rock : mapModel.rocks) {
          imageMode(CENTER);
          tint(255, rock.getRemainingFrames()/ (float) rock.DEFAULT_FRAMES * 255);
          // FOR TESTING PURPOSES: draw circle that the player needs to
          //  be in to be "safe"
          ellipseMode(CENTER);
          ellipse(rock.cX, rock.cY, rock.w, rock.h);
          
          PImage rockImg;
          PImage rockDetail;
          switch (rock.getType()) {
            case 0:
              rockImg = rockPlatformOne;
              rockDetail = rockDetailOne;
              break;
            case 1:
              rockImg = rockPlatformTwo;
              rockDetail = rockDetailTwo;
              break;
            default:
              rockImg = rockPlatformThree;
              rockDetail = rockDetailThree;
              break;
          }
          //top left corner size to make the image
          image(rockImg, rock.cX, rock.cY, rock.w, rock.h);
          image(rockDetail, rock.cX, rock.cY, rock.w, rock.h);
        }
        tint(255, 255);
        ellipseMode(CENTER);
        fill(255,0,0);        
        ellipse(mapModel.players.get(0).getRawX(), mapModel.players.get(0).getRawY(), 50, 50);
        break;
      case WIN:
        //prevent gif from looping in background can test with myAnimation.isPlaying()
        ///myAnimation.noLoop(); 
        background(winScreen);
        //there's no end state yet..
        //the rock should disappear regardless of someone being there..
      case LOSE:
        imageMode(CORNER);
        image(endScreen, 0, 0, width, height);
        break;
      }
  }
  public void onNotify(Event event) {
    if (event instanceof PlayerStepsOnRockEvent) {
      println("stepped on rock " + (System.identityHashCode(((PlayerStepsOnRockEvent) event).rockModel)));
      RockModel localRock = ((PlayerStepsOnRockEvent) event).rockModel;
      localRock.bouncing = true;
    }
  }
}

