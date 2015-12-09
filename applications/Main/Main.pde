import SimpleOpenNI.*;

//Main
MapController mapController;
MapModel mapModel;
View view;


void setup() {
  // essential game stuff
  // can't put this in view, rocks depend on height and width being set
  //600, 400
  size(2200, 1000);
  mapModel = new MapModel();
  mapController = new MapController(mapModel, this);
  view = new View(this, mapModel);
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

