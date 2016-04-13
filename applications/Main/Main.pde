
//Main
MapController mapController;
MapModel mapModel;
View view;
Minim minim;
//Lava lava;


void setup() {
  size(600, 400);
  minim = new Minim(this);
  mapModel = new MapModel();
  mapController = new MapController(mapModel);
  //lava = new Lava();
  //view = new View(this, mapModel, lava);
  view = new View(this, mapModel, minim);
}
void draw() {
  mapController.update();      
  mapModel.update();
  if (mapModel.getState() == GameState.START){
    view.resetCounter();
  }
  view.render();
}

