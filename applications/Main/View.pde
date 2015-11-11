class View {
  MapModel mapModel;
  PImage rockPlatform;
  PImage startScreen;
  PImage endScreen;
  
  View(MapModel mapModel) {
    this.mapModel = mapModel;
    // load image assets
    rockPlatform = loadImage("../../assets/rockPlatform1.png");
    startScreen = loadImage("../../assets/Rotated Screens/GT Setting Design_rotated_Start.png");
    endScreen = loadImage("../../assets/Rotated Screens/GT Setting Design_rotated_End.png");
    
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
      case PLAY:
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
      case LOSE:
        imageMode(CORNER);
        image(endScreen, 0, 0, width, height);
        break;
      case WIN:
        imageMode(CORNER);
        image(endScreen, 0, 0, width, height);
        break;
    }
  }
}
