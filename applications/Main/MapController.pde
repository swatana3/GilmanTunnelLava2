// MapController - handles rock and map models

class MapController {
  private MapModel mapModel;
  private int framesPressed;

  // constructor
  MapController(MapModel mapModel) {
    this.mapModel = mapModel;
    framesPressed = 0;
  }

  void update() {
    switch(mapModel.getState()) {
      case START:
       //Only start if the player has been standing for 5 consecutive seconds.
       if (mousePressed) {
          if (framesPressed < 300) {
           framesPressed++;
          //Start the game
          } else { 
            framesPressed = 0;  
            mapModel.beginRules();
            mousePressed = false;
          }
       //Otherwise, reset the second counter if not consecutive
       } else {
         framesPressed = 0;
       }
        break;
      case RULES:
        if (mousePressed) {
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
