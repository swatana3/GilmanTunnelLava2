//Main
MapController mapController;
MapModel mapModel;
View view;
Lava lava;


void setup() {
  size(600, 400);
  mapModel = new MapModel();
  mapController = new MapController(mapModel);
  lava = new Lava();
  view = new View(this, mapModel, lava);
}
void draw() {
  mapController.update();      
  mapModel.update();
  view.render();
}

