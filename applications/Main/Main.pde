//Main
// "Game Engine"
MapController mapController;
View view;


//import MapController.pde;
//import View.pde;

void setup() {
  // window stuff - handled by View
  //size(900, 400);
  //background (225);
  
  // essential game stuff
  mapController = new MapController();
  view = new View(mapController.mapModel);
  //mapModel = new MapModel();
  
}
void draw() {
  // redraw background for each frame
  //background (225);

  // main game functions
  mapController.update();
  view.render();
  // TODO: check for game over, change game state

}
