class View {
  MapModel mapModel;
  PImage rockPlatform;
  
  View(MapModel mapModel) {
    this.mapModel = mapModel;
    rockPlatform = loadImage("../../assets/rockPlatform1.png");
  }
  
  void render() {
    for (RockModel rock : mapModel.rocks) {
      //imageMode(CENTER);
      tint(255, rock.getRemainingFrames()/ (float) rock.DEFAULT_FRAMES * 255);
      image(rockPlatform, rock.gridX, rock.gridY, width / mapModel.mapX, height / mapModel.mapY);
    }
  }
}
