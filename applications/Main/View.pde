import java.util.Map;
//not sure why second ellipse doesn't show up? 
import ddf.minim.*;

class View implements Observer {
  private MapModel mapModel;

  // Screens and Backgrounds
  private PImage startScreen;
  private PImage loseScreen;
  private PImage FloseScreen;
  private PImage endScreen;
  private PImage FendScreen;
  private PImage winScreen;
  private PImage winScreen2;
  private PImage calibrateScreen1;
  private PImage calibrateScreen2;
  private PImage calibrateScreen3;
  private PImage countdownScreen1;
  private PImage countdownScreen2;
  private PImage countdownScreen3;
  private PImage betweenLevels;
  private PImage FcountdownScreen1;
  private PImage FcountdownScreen2;
  private PImage FcountdownScreen3;
  private PImage flamingoCountdown1;
  private PImage flamingoCountdown2;
  private PImage flamingoCountdown3;
  private PImage natureCountdown1;
  private PImage natureCountdown2;
  private PImage natureCountdown3;
  private PImage flamingoBackground;
  private PImage natureBackground;
  private PImage rules;
  // Between Level Screens
  private PImage level1;
  private PImage level2;
  private PImage level3;

  // Health Bar Images 
  private PImage health1; 
  private PImage health2;
  private PImage health3;
  private PImage health4;
  private PImage health5;
  private PImage health6;
  private PImage health7; 
  
  // Rock Images
  private PImage rockPlatformOne;
  private PImage rockPlatformTwo;
  private PImage rockPlatformThree;
  private PImage rockDetailOne;
  private PImage rockDetailTwo;
  private PImage rockDetailThree;
  private PImage flamingoDetail;
  private PImage natureDetail;
  
  // Sound Playback
  private boolean startSoundNotPlayed = true;    
  private boolean countdown1SoundNotPlayed = true;
  private boolean countdown2SoundNotPlayed = true;
  private boolean countdown3SoundNotPlayed = true;
  private boolean collectSoundNotPlayed = true;
  
  // Other counters and variables needed for view logic
  private int counter = 0;
  private int frameLife = 800;
  private int index = 0; // stores the current index of the memory array
  private boolean increment = false; // Indicates whether we are incrementing or decrementing our index when running from memory

  private float[] tempX;
  private float[] tempY;
  private final int winBubbles = 100;
  private final int loseBubbles = 75;
  private final int playBubbles = 500;
  
  //for feet ellipse
  float feetSize = 200;
  
  //have an arrayList of Rocks while playerisSteppedOnRock and playerStepsOffRock

  View(PApplet parent, MapModel mapModel, Minim minim) {
    this.mapModel = mapModel;
    
    // Load graphics
    rockPlatformOne = loadImage("../../assets/rockPlatform1.png");
    rockPlatformTwo = loadImage("../../assets/rockPlatform2.png");
    rockPlatformThree = loadImage("../../assets/rockPlatform3.png");
    rockDetailOne = loadImage("../../assets/rockDetail1.png");
    rockDetailTwo = loadImage("../../assets/rockDetail2.png");
    rockDetailThree = loadImage("../../assets/rockDetail3.png");
    flamingoDetail = loadImage("../../assets/Final Graphics Small/GT_Level3_FlamingoObject.png");
    natureDetail = loadImage("../../assets/Final Graphics Small/GT_Level2_NatureObject.png");
    flamingoBackground = loadImage("../../assets/Final Graphics Small/GT_Level3_FlamingoBackground.png");
    natureBackground = loadImage("../../assets/Final Graphics Small/GT_Level2_NatureBackground.png");
    startScreen = loadImage("../../assets/Final Graphics Small/GT_1_Start.png");
    endScreen = loadImage("../../assets/Final Graphics Small/GT_19_GameOver1.png");
    FendScreen = loadImage("../../assets/Final Graphics Small/GT_20_GameOver2.png");
    winScreen = loadImage("../../assets/Final Graphics Small/GT_YouWin1.png");
    winScreen2 = loadImage("../../assets/Final Graphics Small/GT_YouWin2.png");
    rules = loadImage("../../assets/Final Graphics Small/GT_5_Rules.png");
    calibrateScreen1 = loadImage("../../assets/Final Graphics Small/GT_2_Calibration1.png");
    calibrateScreen2 = loadImage("../../assets/Final Graphics Small/GT_3_Calibration2.png");
    calibrateScreen3  = loadImage("../../assets/Final Graphics Small/GT_4_Calibration3.png");
    countdownScreen1 = loadImage("../../assets/Final Graphics Small/GT_8_Countdown3.png");
    countdownScreen2 = loadImage("../../assets/Final Graphics Small/GT_7_Countdown2.png");
    countdownScreen3 = loadImage("../../assets/Final Graphics Small/GT_6_Countdown1.png");
    FcountdownScreen1 = loadImage("../../assets/Final Graphics Small/GT_8_Countdown3_F.png");
    FcountdownScreen2 = loadImage("../../assets/Final Graphics Small/GT_7_Countdown2_F.png");
    FcountdownScreen3 = loadImage("../../assets/Final Graphics Small/GT_6_Countdown1_F.png");
    flamingoCountdown1 = loadImage("../../assets/Final Graphics Small/GT_Level3_Flamingo_1.png");
    flamingoCountdown2 = loadImage("../../assets/Final Graphics Small/GT_Level3_Flamingo_2.png");
    flamingoCountdown3 = loadImage("../../assets/Final Graphics Small/GT_Level3_Flamingo_3.png");
    natureCountdown1 = loadImage("../../assets/Final Graphics Small/GT_Level2_Nature_1.png");
    natureCountdown2 = loadImage("../../assets/Final Graphics Small/GT_Level2_Nature_2.png");
    natureCountdown3 = loadImage("../../assets/Final Graphics Small/GT_Level2_Nature_3.png");
    health1 = loadImage("../../assets/Final Graphics Small/GT_Health1.png");
    health2 = loadImage("../../assets/Final Graphics Small/GT_Health2.png");
    health3 = loadImage("../../assets/Final Graphics Small/GT_Health3.png");
    health4 = loadImage("../../assets/Final Graphics Small/GT_Health4.png");
    health5 = loadImage("../../assets/Final Graphics Small/GT_Health5.png");
    health6 = loadImage("../../assets/Final Graphics Small/GT_Health6.png");
    health7 = loadImage("../../assets/Final Graphics Small/GT_Health7.png");
    level1 = loadImage("../../assets/Final Graphics Small/GT_9_Level1.png");
    level2 = loadImage("../../assets/Final Graphics Small/GT_Level2_NatureStart.png");
    level3 = loadImage("../../assets/Final Graphics Small/GT_Level3_FlamingoStart.png");
    
    // Resize graphics
    endScreen.resize(width, height);
    FendScreen.resize(width, height);
    winScreen.resize(width, height);
    winScreen2.resize(width, height);
    rules.resize(width, height);
    calibrateScreen1.resize(width, height);
    calibrateScreen2.resize(width, height);
    calibrateScreen3.resize(width, height);
    countdownScreen1.resize(width, height);
    countdownScreen2.resize(width, height);
    countdownScreen3.resize(width, height);
    FcountdownScreen1.resize(width, height);
    FcountdownScreen2.resize(width, height);
    FcountdownScreen3.resize(width, height);
    flamingoCountdown1.resize(width, height);
    flamingoCountdown2.resize(width, height);
    flamingoCountdown3.resize(width, height);
    natureCountdown1.resize(width, height);
    natureCountdown2.resize(width, height);
    natureCountdown3.resize(width, height);
    flamingoBackground.resize(width, height);
    natureBackground.resize(width, height);
    health1.resize(width/5, height/10);
    health2.resize(width/5, height/10);
    health3.resize(width/5, height/10);
    health4.resize(width/5, height/10);
    health5.resize(width/5, height/10);
    health6.resize(width/5, height/10);
    health7.resize(width/5, height/10);     
    level1.resize(width, height);
    level2.resize(width, height);
    level3.resize(width, height);

    // make View an observer of PlayerStepsOnRocksEvents
    mapModel.getCollisionModel().playerStepsOnRockEvent().addObserver(this);

    // Set up background color
    background (225);
    
  }
  
  void resetCounter() {
    counter = 0;
  }
  

  void render() {
    // Redraw background for each frame
    background (225);

    switch (mapModel.getState()) {
      case START:
        if(startSoundNotPlayed) {
          levelUpSound.play();
          levelUpSound.rewind();
          startSoundNotPlayed = false; 
        }
        imageMode(CORNER);
        image(startScreen, 0, 0, width, height);
        fill(0,100,0); 
        //get where the standing zone is 
        ellipse(250, 740, 360, 360);
        for (PlayerModel p : mapModel.getPlayers()) {
          if (p.getInStandingZone()){
//            ellipseMode(CENTER);
            //fill(250,250,250); 
            //ellipse(p.getRawLX(), p.getRawLY(), p.getDistanceScalarL()*feetSize,p.getDistanceScalarL()*feetSize);
            fill(250,250,250); 
            rect(p.getRawRX(), p.getRawRY(), p.getDistanceScalarR()*feetSize,p.getDistanceScalarR()*feetSize);
//            println ("cooridnates of Lellipse is " + p.getRawLX() + " " +  p.getRawLY() + " "+ p.getDistanceScalarL());
          }
          else{
            fill(0); 
            //this one showing up
            rect(p.getRawLX(), p.getRawLY(), p.getDistanceScalarL()*feetSize,p.getDistanceScalarL()*feetSize);
            fill(0);    
            ellipse(p.getRawRX(), p.getRawRY(), p.getDistanceScalarR()*feetSize,p.getDistanceScalarR()*feetSize);
            println ("cooridnates of Rellipse is " + p.getRawRX() + " " +  p.getRawRY() + " "+ p.getDistanceScalarR());
          }
        }
        
        //println("Image supposedly rendered");
        break;
      case RULES:
//        jumpSound.play();
//        jumpSound.rewind();
        background(rules);
        break;
       case COUNTDOWN1: 
       if(countdown1SoundNotPlayed) {
           beepSound.play();
           beepSound.rewind();
           countdown1SoundNotPlayed = false;
           countdown3SoundNotPlayed = true;
         }
         switch (mapModel.getLevel()){
           case 1:
             background(countdownScreen3);
             break;
           case 3:
             background(flamingoCountdown3);
             break;
           default:
             background(countdownScreen3);
             break;
         }         
         break;
       case COUNTDOWN2: 
         if(countdown2SoundNotPlayed) {
           beepSound.play();
           beepSound.rewind();
           countdown2SoundNotPlayed = false;
           countdown1SoundNotPlayed = true;
         }
         switch (mapModel.getLevel()){
           case 1:
             background(countdownScreen2);
             break;
           case 3:
             background(flamingoCountdown2);
             break;
           default:
             background(countdownScreen2);
             break;
         } 
         break;
       case COUNTDOWN3: 
         if(countdown3SoundNotPlayed) {
           beepSound.play();
           beepSound.rewind();
           countdown3SoundNotPlayed = false;
           countdown2SoundNotPlayed = true;
         }
         switch (mapModel.getLevel()){
           case 1:
             background(countdownScreen1);
             break;
           case 3:
             background(flamingoCountdown1);
             break;
           default:
             background(countdownScreen1);
             break;
         } 
         break;
      case FLIPPEDCOUNTDOWN1: 
        if(countdown1SoundNotPlayed) {
           beepSound.play();
           beepSound.rewind();
           countdown1SoundNotPlayed = false;
           countdown3SoundNotPlayed = true;
         }
         switch (mapModel.getLevel()){
           case 2:
             background(natureCountdown3);
             break;
           default:
             background(FcountdownScreen3);
             break;
         } 
         break;
      case FLIPPEDCOUNTDOWN2: 
        if(countdown2SoundNotPlayed) {
           beepSound.play();
           beepSound.rewind();
           countdown2SoundNotPlayed = false;
           countdown1SoundNotPlayed = true;
         }
         switch (mapModel.getLevel()){
           case 2:
             background(natureCountdown2);
             break;
           default:
             background(FcountdownScreen2);
             break;
         } 
         break;
      case FLIPPEDCOUNTDOWN3: 
        if(countdown1SoundNotPlayed) {
           beepSound.play();
           beepSound.rewind();
           countdown3SoundNotPlayed = false;
           countdown2SoundNotPlayed = true;
         }
         switch (mapModel.getLevel()){
           case 2:
             background(natureCountdown1);
             break;
           default:
             background(FcountdownScreen1);
             break;
         } 
         countdown1SoundNotPlayed = false;
         countdown3SoundNotPlayed = true;
         break;
      case BETWEENLEVEL:
      collectSoundNotPlayed = true;
        //change background
        switch (mapModel.getLevel()){
          case 1 : 
            background(level1);
            //levelUpSound.play();
            //levelUpSound.rewind();
            break;
          case 2 : 
            background(level2);
            //levelUpSound.play();
            //levelUpSound.rewind();
            break;
          case 3 : 
            background(level3);
            //levelUpSound.play();
            //levelUpSound.rewind();
            break;
        }
        break;
      case PLAY: 
         if(collectSoundNotPlayed) {
            collectSound.play();
            collectSound.rewind();
           collectSoundNotPlayed = false; 
         }
         switch (mapModel.getLevel()) {
           case 1:
             background(255, 92, 30);
             for (PlayerModel p : mapModel.getPlayers()) {
              ellipseMode(CENTER);
              fill(0,0,0); 
              ellipse(p.getRawLX(), p.getRawLY(), p.getDistanceScalarL()*feetSize,p.getDistanceScalarL()*feetSize);
              fill(0,0,0); 
              ellipse(p.getRawRX(), p.getRawRY(), p.getDistanceScalarR()*feetSize,p.getDistanceScalarR()*feetSize);
            }
             break;
           case 2:
              background(natureBackground);
              for (PlayerModel p : mapModel.getPlayers()) {
                ellipseMode(CENTER);
                fill(0,0,0); 
                ellipse(p.getRawLX(), p.getRawLY(), p.getDistanceScalarL()*feetSize,p.getDistanceScalarL()*feetSize);
                ellipseMode(CENTER);
                fill(0,0,0); 
                ellipse(p.getRawRX(), p.getRawRY(), p.getDistanceScalarR()*feetSize,p.getDistanceScalarR()*feetSize);
               }
              break;
           case 3:
               background(flamingoBackground);
               for (PlayerModel p : mapModel.getPlayers()) {
//                ellipseMode(CENTER);
                fill(0,0,0); 
                ellipse(p.getRawLX(), p.getRawLY(), p.getDistanceScalarL()*feetSize,p.getDistanceScalarL()*feetSize);
//                ellipseMode(CENTER);
                fill(0,0,0); 
                ellipse(p.getRawRX(), p.getRawRY(), p.getDistanceScalarR()*feetSize,p.getDistanceScalarR()*feetSize);
              }
               break;
           default:
               background(255, 92, 30);
               break;
         }
         noStroke(); 
         float currentBubbles = playBubbles;
         int factor = playBubbles;
        //Draw bubbles
        //Less health = fewer bubbles
        // health percentage * 500 = number of bubbles
        if ((mapModel.getLevel() == 1) || (mapModel.getLevel() > 3)) {
          for (PlayerModel p : mapModel.getPlayers()) {
            if (p.getInStandingZone()){
              ellipseMode(CENTER);
              fill(0,0,0); 
              ellipse(p.getRawLX(), p.getRawLY(), p.getDistanceScalarL()*feetSize,p.getDistanceScalarL()*feetSize);
//              println ("cooridnates of Rellipse is " + p.getRawRX() + " " +  p.getRawRY() + " "+ p.getDistanceScalarR());
              ellipseMode(CENTER);
              fill(0,0,0); 
              ellipse(p.getRawRX(), p.getRawRY(), p.getDistanceScalarR()*feetSize,p.getDistanceScalarR()*feetSize);
//              println ("cooridnates of Lellipse is " + p.getRawLX() + " " +  p.getRawLY() + " "+ p.getDistanceScalarL());
            }
            else{
              ellipseMode(CENTER);
              fill(0,0,0); 
              ellipse(p.getRawLX(), p.getRawLY(), p.getDistanceScalarL()*feetSize,p.getDistanceScalarL()*feetSize);
//              println ("cooridnates of Rellipse is " + p.getRawRX() + " " +  p.getRawRY() + " "+ p.getDistanceScalarR());
              ellipseMode(CENTER);
              fill(0,0,0); 
              ellipse(p.getRawRX(), p.getRawRY(), p.getDistanceScalarR()*feetSize,p.getDistanceScalarR()*feetSize);
//              println ("cooridnates of Lellipse is " + p.getRawLX() + " " +  p.getRawLY() + " "+ p.getDistanceScalarL());
            }
             if (p.getRemainingFrames() < p.getMaxHealth()) {
               currentBubbles = ( ( float(p.getRemainingFrames()) / float(p.getMaxHealth()) ) * playBubbles );
               factor = Math.round(currentBubbles);
             } else {
               factor = playBubbles;
             }
             makeBubbles(factor);   
          }
        }  
        
        //Draw Rocks
        if ((mapModel.getRocks().size() == 0) && mapModel.getLevel() == 3){
          winSound.play();
          winSound.rewind();
        }
        for (RockModel rock : mapModel.getRocks()) {
          imageMode(CENTER);
          tint(255, rock.getRemainingFrames()/ (float) rock.getDefaultFrames() * 255);
          if (rock.getRemainingFrames() == 0){
            rocksSound.play();
            rocksSound.rewind();
          }
          
          PImage rockImg;
          PImage rockDetail;
          //Switch based on level
          switch (mapModel.getLevel()){
            case 1:
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
              image(rockImg, rock.getCenterX(), rock.getCenterY(), rock.getWidth(), rock.getHeight());
              image(rockDetail, rock.getCenterX(), rock.getCenterY(), rock.getWidth(), rock.getHeight());
              break;
           case 2:
             rockImg = natureDetail;
             image(rockImg, rock.getCenterX(), rock.getCenterY(), rock.getWidth(), rock.getHeight());
             break;
           case 3:
             rockImg = flamingoDetail;
             image(rockImg, rock.getCenterX(), rock.getCenterY(), rock.getWidth(), rock.getHeight());
             break;
           default:
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
            image(rockImg, rock.getCenterX(), rock.getCenterY(), rock.getWidth(), rock.getHeight());
            image(rockDetail, rock.getCenterX(), rock.getCenterY(), rock.getWidth(), rock.getHeight());
            break;
        }
      }
        //Display Health bars
        int playerNum = 0;
        for (PlayerModel player : mapModel.getPlayers()) {
          imageMode(CORNERS);
          noTint();
          playerNum++;
          println("Health Bar code reached. Player num: " + playerNum);
          //Wrap later instead of breaking
          if ((width - 80 * playerNum) < 0){
            break;
          }
          String display = "Player" + " " + playerNum;
          int health = (player.getRemainingFrames());
          PImage healthImage = health7;
          if (health == 0) { 
            dieSound.play();
            dieSound.rewind();
            gameOverSound.play();
            gameOverSound.rewind();
          } else if (health <= 15) {
            healthImage = health1;
          } else if (health <= 30) {
           healthImage = health2;
          } else if (health <= 45) {
           healthImage = health3;
          }else if (health <= 60) {
           healthImage = health4;
          }else if (health <= 75) {
            healthImage = health5;
          }else if (health <= 90) {
            healthImage = health6;
          }else if (health == 105) {
            healthImage = health7;
          }
          image(healthImage, (width - 80 * playerNum), 0, (width - 80 * (playerNum - 1)), 40);
          fill(255, 255, 255);
          textFont(createFont("Agency FB", 12, true));
          text(display, width -  80*playerNum + 20, 50);
        }
        break;
      case WIN: 
        imageMode(CORNER);
        background(winScreen);
        frameRate(120);
        noTint();
        tint(255,255,255, counter);
        image(winScreen2,0,0);
        if (counter < 255){
            counter++;
        }
        makeBubbles(winBubbles);
        break;
      case LOSE:
        imageMode(CORNER);
        background(endScreen);
        frameRate(120);
        noTint();
        tint(255,255,255, counter);
        image(FendScreen, 0, 0, width, height);
        if (counter < 255){
            counter++;
        }
        makeBubbles(loseBubbles);
        break;
    }
  }
  
   void makeBubbles(int numBubbles){
    for (int j = 0; j < numBubbles; j++) {
          //Get x,y vertices for the specific time indicated
          tempX = mapModel.getLava().getBubbles()[j].getCurvesX(index);
          tempY = mapModel.getLava().getBubbles()[j].getCurvesY(index);
          beginShape();
          fill(mapModel.getLava().getBubbles()[j].getColor());
          //Draw each x,y curve
          for (int i = 0; i < (mapModel.getLava().getBubbles()[j].getNumPoints() + 3); i++){
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
    }
  
  public void onNotify(Event event) {
    if (event instanceof PlayerStepsOnRockEvent) {
      RockModel localRock = ((PlayerStepsOnRockEvent) event).rockModel;
      //rockSplashSound.play();
      //rockSplashSound.rewind();
      localRock.setBouncing(true);
    }
  }
}

