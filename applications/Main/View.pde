class View {
  MapModel mapModel;
  PImage rockPlatform;
  PImage startScreen;
  PImage endScreen;
  
  View(MapModel mapModel) {
    this.mapModel = mapModel;
    // load image assets
    rockPlatform = loadImage("../../assets/rockPlatform1.png");
    startScreen = loadImage("../../assets/Screen_Start.png");
    endScreen = loadImage("../../assets/Screen_End.png");
    
  // window stuff setup
  size(600, 400);
  background (225);
  }
  
  void render() {
    // redraw background for each frame
    background (225);

    switch (mapModel.state) {
      case START:
        imageMode(CENTER);
        // TODO: rotate start screen
        image(startScreen, width/2, height/2, 600, 400);
        break;
      case PLAY:
        for (RockModel rock : mapModel.rocks) {
          //imageMode(CENTER);
          tint(255, rock.getRemainingFrames()/ (float) rock.DEFAULT_FRAMES * 255);
          image(rockPlatform, rock.gridX, rock.gridY, width / mapModel.mapX, height / mapModel.mapY);
        }
        break;
      case END:
        break;
    }
  }
}
