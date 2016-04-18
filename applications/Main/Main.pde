
//Main
MapController mapController;
MapModel mapModel;
View view;
Minim minim;
//Lava lava;

AudioPlayer gameOverSound;

void setup() {
  size(600, 400);
  
  // sound stuff
  minim = new Minim(this);
//  collectSound = minim.loadfile("Collect.wav");
//  dieSound = minim.loadfile("die.flac");
  gameOverSound = minim.loadFile("GameOver.wav");
//  jumpSound = minim.loadfile("Jump.wav");
//  levelUpSound = minim.loadfile("LevelUp.wav");
//  rocksSound = minim.loadfile("Rocks.flac");
//  rockSplashSound = minim.loadfile("RockSplash.wav");
//  winSound = minim.loadfile("Win.aiff");
  // end sound stuff
  
  mapModel = new MapModel();
  mapController = new MapController(mapModel);
//  lava = new Lava();
//  view = new View(this, mapModel, lava);
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

