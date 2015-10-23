class View {
  MapModel mapModel;
  PImage rockPlatform;
  
  View(MapModel mapModel) {
    this.mapModel = mapModel;
    rockPlatform = loadImage("../../assets/rockPlatform1.png");
  }
  
  void render() {
    for (RockModel rock : mapModel.getRocks()) {
      imageMode(CENTER);
      tint(255, rock.getFramesAlive()/ (float) rock.getFrameLife() * 255);
      image(rockPlatform, rock.getX(), rock.getY(), 50, 50);
    }
  }
}
