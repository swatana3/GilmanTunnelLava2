class View {
  MapModel mapModel;
  PImage rockPlatform;
  PImage startScreen;
  PImage endScreen;
  
  View(MapModel mapModel) {
    this.mapModel = mapModel;
    rockPlatform = loadImage("../../assets/rockPlatform1.png");
    startScreen = loadImage("../../assets/Screen_Start.png");
    endScreen = loadImage("../../assets/Screen_End.png");
  }
  
  void render() {
    switch (mapModel.state) {
      case START:
        imageMode(CENTER);
        image(startScreen, width/2, height/2, 400, 900);
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
