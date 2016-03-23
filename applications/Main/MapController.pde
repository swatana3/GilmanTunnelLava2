// MapController - handles rock and map models

class MapController {
  private MapModel mapModel;

  // constructor
  MapController(MapModel mapModel) {
    this.mapModel = mapModel;
  }

  void update() {
    switch(mapModel.getState()) {
      /*case RULES:
        if (mousePressed) {
          mapModel.beginCalibration();
        }
        break;*/
      case START:
       if (mousePressed) { 
          //mapModel.beginRules();
          //println("began rules");
          //Add second count so mouse must be pressed for 5 seconds
          mapModel.beginCalibration();
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
  
  MapModel getMapModel(){
    return mapModel;
  }
}
