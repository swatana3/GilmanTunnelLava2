import java.util.Map;

class View implements Observer {
  MapModel mapModel;
  Lava lava;
  //PImage rockPlatform;
  PImage startScreen;
  PImage loseScreen;
  PImage FloseScreen;
  PImage endScreen;
  PImage FendScreen;
  PImage winScreen;
  //PImage calibrateScreen
  PImage calibrateScreen1;
  PImage calibrateScreen2;
  PImage calibrateScreen3;
  //PImage countdownScreen
  PImage countdownScreen1;
  PImage countdownScreen2;
  PImage countdownScreen3;
  PImage betweenLevels;
  PImage FcountdownScreen1;
  PImage FcountdownScreen2;
  PImage FcountdownScreen3;
 

  //static images(gifs were too large)
  PImage rockPlatformOne;
  PImage rockPlatformTwo;
  PImage rockPlatformThree;
  PImage rockDetailOne;
  PImage rockDetailTwo;
  PImage rockDetailThree;
  PImage lavaImg;
  
  int frameLife = 800;
  int index = 0; // stores the current index of the memory array
  boolean increment = false; // Indicates whether we are incrementing or decrementing our index when running from memory
  float[] tempX;
  float[] tempY;
  
  //have an arrayList of Rocks while playerisSteppedOnRock and playerStepsOffRock
  

  View(PApplet parent, MapModel mapModel, Lava lava) {
    this.mapModel = mapModel;
    this.lava = lava;
    rockPlatformOne = loadImage("../../assets/rockPlatform1.png");
    rockPlatformTwo = loadImage("../../assets/rockPlatform2.png");
    rockPlatformThree = loadImage("../../assets/rockPlatform3.png");
    rockDetailOne = loadImage("../../assets/rockDetail1.png");
    rockDetailTwo = loadImage("../../assets/rockDetail2.png");
    rockDetailThree = loadImage("../../assets/rockDetail3.png");
    startScreen = loadImage("../../assets/Rotated Screens/GT Setting Design_rotated_Start.png");
    endScreen = loadImage("../../assets/Rotated Screens/GT Setting Design_rotated_End.png");
    FendScreen = loadImage("../../assets/Rotated Screens/GT Setting Design_rotated_End_F.png");
    winScreen = loadImage("../../assets/Rotated Screens/GT Setting Design_End_Win.png");

    endScreen.resize(width, height);
    FendScreen.resize(width, height);
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
    FcountdownScreen1 = loadImage("../../assets/Rotated Screens/GT Setting Design_rotated_Countdown1_F.png");
    FcountdownScreen2 = loadImage("../../assets/Rotated Screens/GT Setting Design_rotated_Countdown2_F.png");
    FcountdownScreen3 = loadImage("../../assets/Rotated Screens/GT Setting Design_rotated_Countdown3_F.png");

    
    countdownScreen1.resize(width, height);
    countdownScreen2.resize(width, height);
    countdownScreen3.resize(width, height);
    FcountdownScreen1.resize(width, height);
    FcountdownScreen2.resize(width, height);
    FcountdownScreen3.resize(width, height);
    

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
        //println("we reached the render method");
        imageMode(CORNER);
        image(startScreen, 0, 0, width, height);
        //println("Image supposedly rendered");
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
      case FLIPPEDCOUNTDOWN1: 
        background(FcountdownScreen1);
        println("FLIIPED");
        break;
      case FLIPPEDCOUNTDOWN2: 
        background(FcountdownScreen2);
        println("FLIIPED");
        break;
      case FLIPPEDCOUNTDOWN3: 
        background(FcountdownScreen3);
        println("FLIIPED");
        break;
      case BETWEENLEVEL:
        //change background
        println("BETWEEN LEVEL");
        background(255, 20, 0);
        break;
      case PLAY: 
         background(255, 92, 30);
         noStroke(); 
        
        //Draw bubbles
        
        for(Bubble bubble : lava.bubbles){
          //Get x,y vertices for the specific time indicated
          tempX = bubble.getCurvesX(index);
          tempY = bubble.getCurvesY(index);
          beginShape();
          fill(bubble.getColor());
          //Draw each x,y curve
          for (int i = 0; i < (bubble.getNumPoints() + 3); i++){
            curveVertex(tempX[i], tempY[i]);
          }
          endShape(CLOSE);
        }
        //Increment or decrement our index
        if (!increment && index > 0){
          index -= 1;
        }
        else if (increment && index < frameLife - 1){
          index += 1;
        }
        //If index is currently 0, start incrementing
        if (index == 0){
          increment = true;
        }
        //Otherwise if at frameLife -1, decrement
        else if (index == (frameLife - 1)){
        increment = false;
        }      
        
        //Draw Rocks
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
        break;
      case WIN:
        //prevent gif from looping in background can test with myAnimation.isPlaying()
        ///myAnimation.noLoop(); 
        imageMode(CORNER);
        background(winScreen);
        break;
        //there's no end state yet..
        //the rock should disappear regardless of someone being there.
      case LOSE:
        imageMode(CORNER);
        image(endScreen, 0, 0, width, height);
        break;
     case FLOSE:
       imageMode(CORNER);
       image(FendScreen, 0, 0, width, height);
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

