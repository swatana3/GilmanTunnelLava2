//Main
// "Game Engine"
MapController mapController;
View view;


//import MapController.pde;
//import View.pde;

void setup() {
  // essential game stuff
  // can't put this in view, rocks depend on height and width being set
  size(600, 400);

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
