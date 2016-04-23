import SimpleOpenNI.*;

//Main
MapController mapController;
MapModel mapModel;
View view;
//Lava lava;


void setup() {
  size(2200, 1000);
  mapModel = new MapModel();
  mapController = new MapController(mapModel, this);
  //lava = new Lava();
  //view = new View(this, mapModel, lava);
  view = new View(this, mapModel);
}
void draw() {
  mapController.update();      
  mapModel.update();
  if (mapModel.getState() == GameState.START){
    view.resetCounter();
  }
  view.render();
}
  void onNewUser(SimpleOpenNI curContext, int userId)
  {
    println("onNewUser - userId: " + userId);
    println("\tstart tracking skeleton");

    context.startTrackingSkeleton(userId);
  }

  void onLostUser(SimpleOpenNI curContext, int userId)
  {
    println("onLostUser - userId: " + userId);
  }

  void onVisibleUser(SimpleOpenNI curContext, int userId)
  {
    //println("onVisibleUser - userId: " + userId);
  }
