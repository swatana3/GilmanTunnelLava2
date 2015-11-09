class View {
  MapModel mapModel;
  //PImage rockPlatform;
  PImage startScreen;
  PImage endScreen;
  
  
  //static images(gifs were too large)
  PImage rockPlatform;
  PImage lavaImg;
  
  //looping things
  int frameCountSinceLoopLava;
  int frameCountSinceLoopRock;
  
  
  
  View(PApplet parent, MapModel mapModel) {
    this.mapModel = mapModel;
    rockPlatform = loadImage("../../assets/rockPlatform1.png");
    startScreen = loadImage("../../assets/Rotated Screens/GT Setting Design_rotated_Start.png");
    endScreen = loadImage("../../assets/Rotated Screens/GT Setting Design_rotated_End.png");
    //Added the Lava animation gif
    //myAnimation = new Gif(parent, "../../assets/Lava_Animation_AE_shorter.gif");
    lavaImg = loadImage("../../assets/lavabkgd.png" );  
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
        break;
    }
  }
}
