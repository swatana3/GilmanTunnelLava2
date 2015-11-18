// MapController - handles rock and map models

class MapController {
  MapModel mapModel;

  // constructor
  MapController(MapModel mapModel) {
    this.mapModel = mapModel;
  }

  void update() {
    switch(mapModel.getState()) {
      case START:
       if (mousePressed) {
          mapModel.beginGame();
        }
        break;
      case PLAY:
        for (PlayerModel player : mapModel.players) {
          player.setRawX(mouseX);
          player.setRawY(mouseY);
        }
        break;
    }
  }
}


// TODO: player shouldn't be able to destroy rocks after they're dead
