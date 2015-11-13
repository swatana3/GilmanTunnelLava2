class View {
  MapModel mapModel;
  //PImage rockPlatform;
  PImage startScreen;
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
  
  //keep track of frames since calibrate was called
  int framesSinceCalledCalibrate; 
   
  View(PApplet parent, MapModel mapModel) {
    this.mapModel = mapModel;
    rockPlatform = loadImage("../../assets/rockPlatform1.png");
    startScreen = loadImage("../../assets/Rotated Screens/GT Setting Design_rotated_Start.png");
    endScreen = loadImage("../../assets/Rotated Screens/GT Setting Design_rotated_End.png");
    
    //calibrateScreen
    calibrateScreen1 = loadImage("../../assets/Rotated Screens/GT Setting Design_rotated_Calibrate1.png");
    calibrateScreen2 = loadImage("../../assets/Rotated Screens/GT Setting Design_rotated_Calibrate1.png");
    calibrateScreen3  = loadImage("../../assets/Rotated Screens/GT Setting Design_rotated_Calibrate1.png");
    
    //countdownScreen
    countdownScreen1 = loadImage("../../assets/Rotated Screens/GT Setting Design_rotated_Countdown1.png");
    countdownScreen2 = loadImage("../../assets/Rotated Screens/GT Setting Design_rotated_Countdown2.png");
    countdownScreen3 = loadImage("../../assets/Rotated Screens/GT Setting Design_rotated_Countdown3.png");
    
    //Added the Lava animation gif
    //myAnimation = new Gif(parent, "../../assets/Lava_Animation_AE_shorter.gif");
    lavaImg = loadImage("../../assets/lavabkgd.png" );   
    
    framesSinceCalledCalibrate =0; 
    
    // window stuff setup
    background (225);
  }
  
  void render() {
    // redraw background for each frame
    background (225);

    switch (mapModel.state) {
      case START:
        imageMode(CORNER);
        image(startScreen, 0, 0, width, height);
        break;
      case CALIBRATE1:
        //println("calibrating....1");
        if (framesSinceCalledCalibrate <=100)
        {
          calibrateScreen1.resize(width, height); 
          background(calibrateScreen1);
          println("frames since called calibrate is" + framesSinceCalledCalibrate);
          framesSinceCalledCalibrate++; 
        } else {
          mapModel.state = GameState.CALIBRATE2; 
        }
        break;
     case CALIBRATE2:
       if (framesSinceCalledCalibrate<=200){
          calibrateScreen2.resize(width, height); 
          background(calibrateScreen2);
          println("frames since called calibrate is" + framesSinceCalledCalibrate);
          framesSinceCalledCalibrate++; 
        } else{
          mapModel.state = GameState.CALIBRATE3; 
        }
         break;
       case CALIBRATE3:
         if (framesSinceCalledCalibrate<=300){
          calibrateScreen3.resize(width, height); 
          background(calibrateScreen3);
          println("frames since called calibrate is" + framesSinceCalledCalibrate);
          framesSinceCalledCalibrate++; 
         } else{
          mapModel.state = GameState.COUNTDOWN1; 
         }
       break;
       case COUNTDOWN1:
         if (framesSinceCalledCalibrate<=400){
          countdownScreen1.resize(width, height); 
          background(countdownScreen1);
          println("frames since called calibrate is" + framesSinceCalledCalibrate);
          framesSinceCalledCalibrate++; 
         } else{
          mapModel.state = GameState.COUNTDOWN2; 
         }
       break;
       case COUNTDOWN2:
         if (framesSinceCalledCalibrate<=500){
          countdownScreen2.resize(width, height); 
          background(countdownScreen2);
          println("frames since called calibrate is" + framesSinceCalledCalibrate);
          framesSinceCalledCalibrate++; 
          }else{
          mapModel.state = GameState.COUNTDOWN3; 
          }
       break;
       case COUNTDOWN3:
         if (framesSinceCalledCalibrate<=600){
          countdownScreen3.resize(width, height); 
          background(countdownScreen3);
          println("frames since called calibrate is" + framesSinceCalledCalibrate);
          framesSinceCalledCalibrate++; 
         } else{
          mapModel.state = GameState.PLAY; 
          }
       break;
     case PLAY:
        lavaImg.resize(width, height); 
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
        //resize endscreen for background image. 
        endScreen.resize(width, height); 
        background(endScreen);
        println("YOU WON");
        //there's no end state yet..
        //the rock should disappear regardless of someone being there..
      case LOSE:
        imageMode(CORNER);
        image(endScreen, 0, 0, width, height);
        break;
    }
  }
}
