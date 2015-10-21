//Main

MapModel mapModel;
View view;

void setup() {
  size(900, 400);
  background (225);
  
  mapModel = new MapModel();
  view = new View(mapModel);
  
}
void draw() {
  background (225);
  //Update rocks (this loop belongs in controller)
  for (RockModel rock : mapModel.getRocks()) {
    rock.update();
  }
  view.render();
}
