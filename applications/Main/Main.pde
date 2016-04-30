
import SimpleOpenNI.*;

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
  size(2200, 1000);
  mapModel = new MapModel();
  mapController = new MapController(mapModel, this);
  //lava = new Lava();
  //view = new View(this, mapModel, lava);
  view = new View(this, mapModel, minim);
  
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
    
    mapModel.addPlayer(userId);
    context.startTrackingSkeleton(userId);
  }

  void onLostUser(SimpleOpenNI curContext, int userId)
  {
    mapModel.removePlayer(userId);
    println("onLostUser - userId: " + userId);
  }

  void onVisibleUser(SimpleOpenNI curContext, int userId)
  {
    //println("onVisibleUser - userId: " + userId);
  }
