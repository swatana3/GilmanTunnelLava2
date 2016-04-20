
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
AudioPlayer dieSound;
AudioPlayer jumpSound;
AudioPlayer levelUpSound;
AudioPlayer rocksSound;
AudioPlayer rockSplashSound;
AudioPlayer winSound;

void setup() {
  size(1100, 500);
  
  // sound stuff
  minim = new Minim(this);
  beepSound = minim.loadFile("Beep.mp3");
  collectSound = minim.loadFile("Collect.wav");
  dieSound = minim.loadFile("../../assets/Sounds/Die.wav");
  gameOverSound = minim.loadFile("../../assets/Sounds/GameOver.wav");
  jumpSound = minim.loadFile("../../assets/Sounds/Jump.wav");
  levelUpSound = minim.loadFile("../../assets/Sounds/LevelUp.wav");
  rocksSound = minim.loadFile("../../assets/Sounds/Rocks.wav");
  //rockSplashSound = minim.loadFile("../../assets/Sounds/RockSplash.wav");
  winSound = minim.loadFile("../../assets/Sounds/Win.wav");
  // end sound stuff
  
  mapModel = new MapModel();
  mapController = new MapController(mapModel);
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

