import gifAnimation.*;

class View {
  MapModel mapModel;
  //PImage rockPlatform;
  PImage startScreen;
  PImage endScreen;
  
  //Adding Lava Animation
  //Gif lava; 
  //Gif rockPlatform; 
  
  //Image array of Lava
  PImage[] rockPlatformImgs;
  PImage[] lavaImgs;
  
  //looping things
  int frameCountSinceLoopLava;
  int frameCountSinceLoopRock;
  
  
  
  View(PApplet parent, MapModel mapModel) {
    this.mapModel = mapModel;
    // load image assets
    //rockPlatform = new Gif(parent, "../../assets/Rocks3.gif");
    rockPlatformImgs = Gif.getPImages(parent,"../../assets/Rocks3.gif" ); 
    
    startScreen = loadImage("../../assets/Rotated Screens/GT Setting Design_rotated_Start.png");
    endScreen = loadImage("../../assets/Rotated Screens/GT Setting Design_rotated_End.png");
    //Added the Lava animation gif
    //myAnimation = new Gif(parent, "../../assets/Lava_Animation_AE_shorter.gif");
    lavaImgs = Gif.getPImages(parent,"../../assets/Lava_Animation_AE_shorter.gif" );  
    frameCountSinceLoopLava =0; 
    frameCountSinceLoopRock =0;   

    
  // window stuff setup
  background (225);
  }
  
  void render() {
    // redraw background for each frame
    background (225);

    switch (mapModel.state) {
      case START:
        //imageMode(CENTER);
        // TODO: rotate start screen
        image(startScreen, 0, 0, 600, 400);
        break;
      case PLAY:
      //reset loop
        if (frameCountSinceLoopLava == lavaImgs.length){
          frameCountSinceLoopLava = 0;
        }
        if (frameCountSinceLoopRock == rockPlatformImgs.length){
          frameCountSinceLoopRock = 0;
        }
        lavaImgs[frameCountSinceLoopLava].resize(width, height);
        background(lavaImgs[frameCountSinceLoopLava]); 
        for (RockModel rock : mapModel.rocks) {
          //imageMode(CENTER);
          tint(255, rock.getRemainingFrames()/ (float) rock.DEFAULT_FRAMES * 255);
          //                  top left corner         size to make the image
          image(rockPlatformImgs[frameCountSinceLoopRock], rock.gridX, rock.gridY, width / mapModel.mapX, height / mapModel.mapY);
        }
        frameCountSinceLoopLava++;
        frameCountSinceLoopRock++; 
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
        break;
    }
  }
}
