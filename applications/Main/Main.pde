//Main
// "Game Engine"
MapController mapController;
View view;


//import MapController.pde;
//import View.pde;

void setup() {
  // window stuff - handled by View
  size(600, 400);
  background (225);
  
  // essential game stuff
  mapController = new MapController();
  view = new View(mapController.mapModel);
  //mapModel = new MapModel();
  
}
void draw() {
  // redraw background for each frame
  background (225);

  // main game functions
  mapController.update();
  view.render();
}

// TODO: temporary, do something better than this to change the state to PLAY
void mouseClicked() {
  mapController.mapModel.state = State.PLAY;
}
