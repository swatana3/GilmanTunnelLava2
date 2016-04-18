
//Main
MapController mapController;
MapModel mapModel;
View view;
Minim minim;
//Lava lava;

/* begin sound setup
 * todo:
 * convert die, rocks, and win to .wav
 * fix rockSplash bit depth
 */ 
AudioPlayer beepSound;
AudioPlayer gameOverSound;
AudioPlayer collectSound;
//AudioPlayer dieSound;
AudioPlayer jumpSound;
AudioPlayer levelUpSound;
//AudioPlayer rocksSound;
//AudioPlayer rockSplashSound;
//AudioPlayer winSound;

void setup() {
  size(2200, 1000);
  
  // sound stuff
  minim = new Minim(this);
  beepSound = minim.loadFile("Beep.mp3");
  collectSound = minim.loadFile("Collect.wav");
//  dieSound = minim.loadFile("Die.flac");
  gameOverSound = minim.loadFile("GameOver.wav");
  jumpSound = minim.loadFile("Jump.wav");
  levelUpSound = minim.loadFile("LevelUp.wav");
//  rocksSound = minim.loadFile("Rocks.flac");
//  rockSplashSound = minim.loadFile("RockSplash.wav");
//  winSound = minim.loadFile("Win.aiff");
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

