//Main
MapController mapController;
MapModel mapModel;
View view;
Lava lava;


void setup() {
  // essential game stuff
  // can't put this in view, rocks depend on height and width being set
  size(600, 400);
  mapModel = new MapModel();
  mapController = new MapController(mapModel);
  lava = new Lava();
  view = new View(this, mapModel, lava);
}
void draw() {
  // main game functions
  // update controller
  mapController.update();      
  // do collision checking here
  // update all models
  mapModel.update();
  view.render();
}

