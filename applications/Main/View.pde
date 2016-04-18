import java.util.Map;
import ddf.minim.*;

class View implements Observer {
   private MapModel mapModel;

  //Lava lava;
  //PImage rockPlatform;
  private PImage startScreen;
  private PImage loseScreen;
  private PImage FloseScreen;
  private PImage endScreen;
  private PImage FendScreen;
  private PImage winScreen;
  private PImage winScreen2;
  // add variable to keep track of page visit to enable sound playback
  boolean startSoundNotPlayed = true;    


  //PImage calibrateScreen
  private PImage calibrateScreen1;
  private PImage calibrateScreen2;
  private PImage calibrateScreen3;
  //PImage countdownScreen
  private PImage countdownScreen1;
  private PImage countdownScreen2;
  private PImage countdownScreen3;
  private PImage betweenLevels;
  private PImage FcountdownScreen1;
  private PImage FcountdownScreen2;
  private PImage FcountdownScreen3;
  private PImage rules;
 /* PImage health bars 
  * added: health level transition check (7 health levels)
  * added: initialize healthImage here to avoid overwriting
  *        updated healthImage for player when looping for game
  */
  private int healthLevel = 7;
  private PImage health1; 
  private PImage health2;
  private PImage health3;
  private PImage health4;
  private PImage health5;
  private PImage health6;
  private PImage health7;
  private PImage healthImage;
  //PImage Between levels
  private PImage level1;
  private PImage level2;
  private PImage level3;

  private int counter = 0;
  
  //static images(gifs were too large)
  private PImage rockPlatformOne;
  private PImage rockPlatformTwo;
  private PImage rockPlatformThree;
  private PImage rockDetailOne;
  private PImage rockDetailTwo;
  private PImage rockDetailThree;
  private PImage lavaImg;
  
  private int frameLife = 800;
  private int index = 0; // stores the current index of the memory array
  private boolean increment = false; // Indicates whether we are incrementing or decrementing our index when running from memory
  private float[] tempX;
  private float[] tempY;
  private final int winBubbles = 100;
  private final int loseBubbles = 75;
  private final int playBubbles = 500;
  
  //have an arrayList of Rocks while playerisSteppedOnRock and playerStepsOffRock
  

  View(PApplet parent, MapModel mapModel, Minim minim) {
    this.mapModel = mapModel;
    //sounds
    
    //Collect = new PlayAudio("../../assets/Sounds/Collect.wav", minim);
    //Die = new PlayAudio("../../assets/Sounds/Die.flac", minim);*/
    //GameOver = new PlayAudio("../../assets/Sounds/GameOver.wav", minim);
    //Jump = new PlayAudio("../../assets/Sounds/Jump.wav", minim);
    //LevelUp = new PlayAudio("../../assets/Sounds/LevelUp.wav", minim);
    //Rocks = new PlayAudio("../../assets/Sounds/Rocks.flac", minim);
    //RockSplash = new PlayAudio("../../assets/Sounds/RockSplash.wav", minim);
    //Win = new PlayAudio("../../assets/Sounds/Win.aiff", minim);
    //Collect = minim.loadSnippet("../../assets/Sounds/Collect.wav");
    //Die = minim.loadSnippet("../../assets/Sounds/Die.flac");
    //GameOver = minim.loadFile("../../assets/Sounds/GameOver.wav");
    /*
    Jump = minim.loadSnippet("../../assets/Sounds/Jump.wav");
    LevelUp = minim.loadSnippet("../../assets/Sounds/LevelUp.wav");
    Rocks = minim.loadSnippet("../../assets/Sounds/Rocks.flac");
    RockSplash = minim.loadSnippet("../../assets/Sounds/RockSplash.wav");
    Win = minim.loadSnippet("../../assets/Sounds/Win.aiff");
    */
          
    
    
    
    //this.lava = lava;
    rockPlatformOne = loadImage("../../assets/rockPlatform1.png");
    rockPlatformTwo = loadImage("../../assets/rockPlatform2.png");
    rockPlatformThree = loadImage("../../assets/rockPlatform3.png");
    rockDetailOne = loadImage("../../assets/rockDetail1.png");
    rockDetailTwo = loadImage("../../assets/rockDetail2.png");
    rockDetailThree = loadImage("../../assets/rockDetail3.png");
    startScreen = loadImage("../../assets/New Screens/GT_Start-78.png");
    endScreen = loadImage("../../assets/New Screens/GT_GameOver.png");
    FendScreen = loadImage("../../assets/New Screens/GT_GameOver_Hover.png");
    winScreen = loadImage("../../assets/New Screens/GT_YouWin_2.png");
    winScreen2 = loadImage("../../assets/New Screens/GT_YouWin_1.png");
    rules = loadImage("../../assets/New Screens/GT_Rules-82.png");
    
    endScreen.resize(width, height);
    FendScreen.resize(width, height);
    winScreen.resize(width, height);
    winScreen2.resize(width, height);
    rules.resize(width, height);

    //calibrateScreen
    calibrateScreen1 = loadImage("../../assets/New Screens/GT_C1.png");
    calibrateScreen2 = loadImage("../../assets/New Screens/GT_C2.png");
    calibrateScreen3  = loadImage("../../assets/New Screens/GT_C3.png");

    calibrateScreen1.resize(width, height);
    calibrateScreen2.resize(width, height);
    calibrateScreen3.resize(width, height);

    //countdownScreen
    countdownScreen1 = loadImage("../../assets/New Screens/GT_1.png");
    countdownScreen2 = loadImage("../../assets/New Screens/GT_2.png");
    countdownScreen3 = loadImage("../../assets/New Screens/GT_3.png");
    FcountdownScreen1 = loadImage("../../assets/New Screens/GT_1_F.png");
    FcountdownScreen2 = loadImage("../../assets/New Screens/GT_2_F.png");
    FcountdownScreen3 = loadImage("../../assets/New Screens/GT_3_F.png");

    
    countdownScreen1.resize(width, height);
    countdownScreen2.resize(width, height);
    countdownScreen3.resize(width, height);
    FcountdownScreen1.resize(width, height);
    FcountdownScreen2.resize(width, height);
    FcountdownScreen3.resize(width, height);
    
    //health bars
    health1 = loadImage("../../assets/New Screens/GT_Health1.png");
    health2 = loadImage("../../assets/New Screens/GT_Health2.png");
    health3 = loadImage("../../assets/New Screens/GT_Health3.png");
    health4 = loadImage("../../assets/New Screens/GT_Health4.png");
    health5 = loadImage("../../assets/New Screens/GT_Health5.png");
    health6 = loadImage("../../assets/New Screens/GT_Health6.png");
    health7 = loadImage("../../assets/New Screens/GT_Health7.png");
    healthImage = health7;
    
    health1.resize(width/5, height/10);
    health2.resize(width/5, height/10);
    health3.resize(width/5, height/10);
    health4.resize(width/5, height/10);
    health5.resize(width/5, height/10);
    health6.resize(width/5, height/10);
    health7.resize(width/5, height/10);  

    //between levels
    level1 = loadImage("../../assets/New Screens/GT_Level1.png");
    level2 = loadImage("../../assets/New Screens/GT_Level2.png");
    level3 = loadImage("../../assets/New Screens/GT_Level3.png");
    
    level1.resize(width, height);
    level2.resize(width, height);
    level3.resize(width, height);

    //Added the Lava animation gif
    //myAnimation = new Gif(parent, "../../assets/Lava_Animation_AE_shorter.gif");
    //lavaImg = loadImage("../../assets/lavabkgd.png" );   
            
    //lavaImg.resize(width, height); 

    // make View an observer of PlayerStepsOnRocksEvents
    mapModel.getCollisionModel().playerStepsOnRockEvent().addObserver(this);

    // window stuff setup
    background (225);
    
  }
  
  void resetCounter() {
    counter = 0;
  }
  

  void render() {
    // redraw background for each frame
    background (225);

    switch (mapModel.getState()) {
      case START:
      if (startSoundNotPlayed) {
        levelUpSound.play();
        levelUpSound.rewind();
        startSoundNotPlayed = false;
      }
        //println("we reached the render method");
        imageMode(CORNER);
        image(startScreen, 0, 0, width, height);
        //println("Image supposedly rendered");
        break;
      case RULES:
        background(rules);
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
        background(countdownScreen3);
        break;
      case COUNTDOWN2: 
        background(countdownScreen2);
        break;
      case COUNTDOWN3: 
        background(countdownScreen1);
        break;
      case FLIPPEDCOUNTDOWN1: 
        background(FcountdownScreen3);
        break;
      case FLIPPEDCOUNTDOWN2: 
        background(FcountdownScreen2);
        break;
      case FLIPPEDCOUNTDOWN3: 
        background(FcountdownScreen1);
        break;
      case BETWEENLEVEL:
        //change background
        switch (mapModel.getLevel()){
          case 1 : 
            background(level1);
            break;
          case 2 : 
            background(level2);
            break;
          case 3 : 
            background(level3);
            break;
        }
        break;
      case PLAY: 
         background(255, 92, 30);
         noStroke(); 
         float currentBubbles = playBubbles;
         int factor = playBubbles;
        //Draw bubbles
        //One method of feedback - how much health is left
        //Less health = fewer bubbles
        // health percentage * 500 = number of bubbles
        
        for (PlayerModel p : mapModel.getPlayers()) {
           if (p.getRemainingFrames() < p.getMaxHealth()) {
             currentBubbles = ( ( float(p.getRemainingFrames()) / float(p.getMaxHealth()) ) * playBubbles );
             factor = Math.round(currentBubbles);
           } else {
             factor = playBubbles;
           }
           makeBubbles(factor);   
        }  
        
        //Draw Rocks
        for (RockModel rock : mapModel.getRocks()) {
          imageMode(CENTER);
          tint(255, rock.getRemainingFrames()/ (float) rock.getDefaultFrames() * 255);
          // FOR TESTING PURPOSES: draw circle that the player needs to
          //  be in to be "safe"
          //ellipseMode(CENTER);
          //ellipse(rock.cX, rock.cY, rock.w, rock.h);
          
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
          image(rockImg, rock.getCenterX(), rock.getCenterY(), rock.getWidth(), rock.getHeight());
          image(rockDetail, rock.getCenterX(), rock.getCenterY(), rock.getWidth(), rock.getHeight());
        }
        //Display Health bars
        int playerNum = 0;
        for (PlayerModel player : mapModel.getPlayers()) {
          imageMode(CORNERS);
          noTint();
          playerNum++;
          //Wrap later instead of breaking
          if ((600 - 80 * playerNum) < 0){
            break;
          }
          String display = "Player" + " " + playerNum;
          int health = (player.getRemainingFrames());
          /* Previously, on every pass through these if statements,
           * the healthImage was being set every single time,
           * which wasn't visible because there would only be a
           * noticeable change when the healthImage itself changed.
           * This resulted in issues with playing sounds, because
           * the if statement would be entered so many times that
           * the sound file would essentially be looping the entire
           * time that the game was active. By adding a variable to
           * keep track of the next healthLevel, each if statement
           * can only be entered at the time of transition, rather
           * than continuously while at a given healthLevel. This
           * will save computing power and allow sound to be played.
           */
          if (health == 0) {
            gameOverSound.play();
            gameOverSound.rewind(); 
            startSoundNotPlayed = true;
          } else if (health <= 15 && healthLevel == 1) {
            jumpSound.play();
            jumpSound.rewind();
            healthImage = health1;
            healthLevel = 0;
          } else if (health <= 30 && healthLevel == 2) {
            jumpSound.play();
            jumpSound.rewind();
           healthImage = health2;
           healthLevel = 1;
          } else if (health <= 45 && healthLevel == 3) {
            jumpSound.play();
            jumpSound.rewind();
           healthImage = health3;
           healthLevel = 2;
          }else if (health <= 60 && healthLevel == 4) {
            jumpSound.play();
            jumpSound.rewind();
           healthImage = health4;
           healthLevel = 3;
          }else if (health <= 75 && healthLevel == 5) {
            jumpSound.play();
            jumpSound.rewind();
            healthImage = health5;
            healthLevel = 4;
          }else if (health <= 90 && healthLevel == 6) {
            jumpSound.play();
            jumpSound.rewind();
            healthImage = health6;
            healthLevel = 5;
          }else if (health == 105 && healthLevel == 7) {
            collectSound.play();
            collectSound.rewind();
            healthImage = health7;
            healthLevel = 6;
          }
          image(healthImage, (600 - 80 * playerNum), 0, (600 - 80 * (playerNum - 1)), 40);
          fill(255, 255, 255);
          textFont(createFont("Agency FB", 12, true));
          text(display, 600 -  80*playerNum + 20, 50);
        }
        break;
      case WIN:
        //prevent gif from looping in background can test with myAnimation.isPlaying()
        ///myAnimation.noLoop(); 
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
        //there's no end state yet..
        //the rock should disappear regardless of someone being there.
      case LOSE:
        // messes up game over sound, but adds new game sound
//        levelUpSound.play();
//        levelUpSound.rewind();
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
      //println("stepped on rock " + (System.identityHashCode(((PlayerStepsOnRockEvent) event).rockModel)));
      RockModel localRock = ((PlayerStepsOnRockEvent) event).rockModel;
      localRock.setBouncing(true);
    }
  }
}
/*
class PlayAudio {
  private AudioSample sample;
  private AudioSnippet snippet;
  
  PlayAudio(String filepath, Minim minim) {
    sample = minim.loadSample(filepath, 512);
    snippet = minim.loadSnippet(filepath);
  }

  void playSnippet() {
    sample.trigger();
    snippet.play();
  } 
}*/

