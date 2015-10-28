//Main
// "Game Engine"
MapController mapController;
View view;


//import MapController.pde;
//import View.pde;

void setup() {
  // essential game stuff
  mapController = new MapController();
  view = new View(mapController.mapModel);  
}
void draw() {
  // main game functions
  mapController.update();
  view.render();
}

// TODO: temporary, do something better than this to change the state to PLAY
void mouseClicked() {
  mapController.mapModel.state = GameState.PLAY;
}
