class View {
  MapModel mapModel;
  //PImage rockPlatform;
  PImage startScreen;
  PImage loseScreen;
  PImage endScreen;
  //PImage calibrateScreen
  PImage calibrateScreen1;
  PImage calibrateScreen2;
  PImage calibrateScreen3;
  //PImage countdownScreen
  PImage countdownScreen1;
  PImage countdownScreen2;
  PImage countdownScreen3;

  //static images(gifs were too large)
  PImage rockPlatform;
  PImage lavaImg;

  View(PApplet parent, MapModel mapModel) {
    this.mapModel = mapModel;
    rockPlatform = loadImage("../../assets/rockPlatform1.png");
    startScreen = loadImage("../../assets/Rotated Screens/GT Setting Design_rotated_Start.png");
    endScreen = loadImage("../../assets/Rotated Screens/GT Setting Design_rotated_End.png");

    endScreen.resize(width, height);

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
          //                  top left corner         size to make the image
          image(rockPlatform, rock.cX, rock.cY, rock.w, rock.h);
        }
        break;
      case WIN:
        //prevent gif from looping in background can test with myAnimation.isPlaying()
        ///myAnimation.noLoop(); 
        background(endScreen);
        //there's no end state yet..
        //the rock should disappear regardless of someone being there..
      case LOSE:
        imageMode(CORNER);
        image(endScreen, 0, 0, width, height);
        break;
      }
  }
}

