import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Main extends PApplet {

//Main
// "Game Engine"
MapController mapController;
View view;


//import MapController.pde;
//import View.pde;

public void setup() {
  // essential game stuff
  // can't put this in view, rocks depend on height and width being set
  size(600, 400);

  mapController = new MapController();
  view = new View(mapController.mapModel); 
 
}
public void draw() {
  // main game functions
  mapController.update();
  view.render();
}

// TODO: temporary, do something better than this to change the state to PLAY
public void mouseClicked() {
  mapController.mapModel.state = GameState.PLAY;
}
// MapController - handles rock and map models

class MapController {
	MapModel mapModel;

  // constructor
  MapController() {
  	this.mapModel = new MapModel();
  }

  public void update() {
    if (mapModel.state == GameState.PLAY) {
      // update rocks and players
  	  for (PlayerModel player : mapModel.players) {
  	    player.update();
  	  }
      
      //RockModel
      ArrayList<RockModel> rocks_to_delete = new ArrayList<RockModel>();
      for (PlayerModel player : mapModel.players) {
        player.hurt_this_frame = true;
        for (RockModel rock : mapModel.rocks) {
          //println(player.x + "," + player.y);
          // player is dissolving rock
          if (rock.checkCollision(player.mX, player.mY)) {
              player.hurt_this_frame = false;
              // BUG: players can stand on rock at the same time,
              //      won't be deleted until after both for loops
              // rock has been destroyed
              if (rock.isDestroyed()) {
                rocks_to_delete.add(rock);
              }
          }
        }
      }
      // delete rocks that have "died"
      for (RockModel rock : rocks_to_delete) {
        mapModel.rocks.remove(rock);
      }
      // BUG: players still injured when not on map,
      //      do collision differently? 2d array of rocks on map?
      for (PlayerModel player : mapModel.players) {
        if (player.hurt_this_frame) {
          player.decrementFramesRemaining();
        }
      }
    }
  }
}
class MapModel {
  ArrayList<RockModel> rocks;
  ArrayList<PlayerModel> players;
  // dimensions of map/game board
  int mapX, mapY;

  // number of players
  int playerCount;

  //State of map
  GameState state; 
  
  public MapModel() {
    // dimension of map, rock can fit in grid <mapX> by <mapY>
    // these can change
    this.mapX = 6;
    this.mapY = 4;
    
    this.playerCount = 0;
    
    rocks = new ArrayList<RockModel>();
    // procedurally generate rocks for the map
    generateMap();
    players = new ArrayList<PlayerModel>();
    // TODO: get blob/dots from kinect and add those as players
    // for now, just use the mouse (mouse is used in player)
    players.add(new PlayerModel(this));

    state = GameState.START;
  }
  // add to rocks so someone can get across
  public void generateMap() {
    float rand;
    int offsetX, offsetY;
    int currentX = 0, currentY;
    boolean rock_exists;
    currentY = (int) random(mapY);
    rocks.add(new RockModel(currentX, currentY, mapX, mapY));
    while (currentX < mapX - 1) {
      rock_exists = false;
      rand = random(1);
      if      (rand < .2f)   { continue; }
      else if (rand < .8f)   { offsetX = 1; }
      else                  { offsetX = 2; }
      // generating a point out of bounds
      if (currentX + offsetX >= mapX) {
        currentX = mapX - 1;
      } else {
        currentX += offsetX;
      }
      do {
        rand = random(1);
        if      (rand < .15f)  { offsetY = -2; }
        else if (rand < .4f)   { offsetY = -1; }
        else if (rand < .6f)   { offsetY = 0; }
        else if (rand < .85f)  { offsetY = 1; }
        else                  { offsetY = 2; }
      // generating a point out of bounds
      } while (currentY + offsetY < 0 || currentY + offsetY >= mapY);
      currentY += offsetY;
      // check if rock already exists
      for (RockModel rock : rocks) {
        if (rock.getX() == currentX && rock.getY() == currentY) {
          rock_exists = true;
        }
      }
      if (!rock_exists) {
        rocks.add(new RockModel(currentX, currentY, mapX, mapY));
      }
    }
  }
}
// probabilities for putting rock in x/y offsets
// .2 - same x, .6 +1 to x, .2 +2 x
//y's: .15 -2, .25 -1 .2 0, .25 +1, .15 +2
class PlayerModel {
  // index of player on game map
	int x, y;
	// use to add native mouse pixel location,
	// more precise
	int mX, mY;
	// dimensions of the world the player is in
	int mapX, mapY;
  // player id
  int id;
        
	int framesUntilDestroyed = -1;
	// bool to tell whether the player has already been hurt this frame
	boolean hurt_this_frame;
	// 
	PlayerModel(MapModel mapModel) {
	  this.mapX = mapModel.mapX;
	  this.mapY = mapModel.mapY;
    // aka health
    this.framesUntilDestroyed = 100;
    this.hurt_this_frame = false;
    this.id = ++mapModel.playerCount;
	}

	public void update() {
		// convert coordinates
		x = mouseX/(width/mapX);
		mX = mouseX;
		y = mouseY/(height/mapY);
		mY = mouseY;
	}

	public int getRemainingFrames() {
	  return framesUntilDestroyed;
	}

	public void decrementFramesRemaining() {
		if (this.framesUntilDestroyed > 0) {
			this.framesUntilDestroyed -= 1;
			println("player " + this.id + ":" + this.framesUntilDestroyed);
		} else {
    	// TODO: player is dead, change game state
        }
	}
}
class RockModel {
  // indices relative on game board grid (4x6 for example)
  int x, y;
  // width and height of ellipse that represents rock
  int w, h;
  // center point of ellipse
  int cX, cY;
  // pixel offset of top right corner of rock
  int gridX, gridY;
  // 3 different images for rocks, pick one at random
  int imageType;
  static final int DEFAULT_FRAMES = 100;
  int framesUntilDestroyed = -1;

  RockModel(int x, int y, int dimX, int dimY) {
    this.x = x;
    this.y = y;
    // TODO: these will be sizes eventually
    this.w = width / dimX;
    this.h = height / dimY;
    // TODO: dunno if we need this or not (NOTE: integer division)
    this.gridX = x * (width / dimX);
    this.gridY = y * (height / dimY);
    // have to use the actual pixels
    this.cX = gridX + w/2;
    this.cY = gridY + h/2;
    this.framesUntilDestroyed = DEFAULT_FRAMES;
    this.imageType = (int) random(3);
  }

  public int getX() {
    return x;
  }

  public int getY() {
    return y;
  }

  public int getRemainingFrames() {
    return framesUntilDestroyed;
  }

  public void setFramesUntilDestroyed(int framesUntilDestroyed) {
    this.framesUntilDestroyed = framesUntilDestroyed;
  }

  public void decrementFramesRemaining() {
    if (this.framesUntilDestroyed > 0) {
      this.framesUntilDestroyed -= 1;
    }
  }

  public boolean isDestroyed() {
    if (framesUntilDestroyed == 0) {
      println("Rock destroyed.");
      return true;
    } else {
      return false;
    }
  }
  public void update() {
    
  }

  // check whether the player is on the rock or not
  public boolean checkCollision(int pX, int pY) {
    // rock is an ellipse, calculate whether the player point is in it
    // check rectangle,
    if (abs(pX - cX) > w/2.0f || abs(pY - cY) > h/2.0f) { return false; }
    // then ellipse
    if (sq(pX - cX) / sq(w/2) + sq(pY - cY) / sq(h/2) <= 1) {
      decrementFramesRemaining();
      // DEBUGGING
      println("rock(" + x + "," + y + "): " + getRemainingFrames());
      return true;
    }
    return false;
  }
}
class View {
  MapModel mapModel;
  PImage rockPlatform;
  PImage startScreen;
  PImage endScreen;
  
  View(MapModel mapModel) {
    this.mapModel = mapModel;
    // load image assets
    rockPlatform = loadImage("../../assets/rockPlatform1.png");
    startScreen = loadImage("../../assets/Screen_Start.png");
    endScreen = loadImage("../../assets/Screen_End.png");
    
    // window stuff setup
    background (225);
  }
  
  public void render() {
    // redraw background for each frame
    background (225);

    switch (mapModel.state) {
      case START:
        //imageMode(CENTER);
        // TODO: rotate start screen
        image(startScreen, 0, 0, 600, 400);
        break;
      case PLAY:
        for (RockModel rock : mapModel.rocks) {
          //imageMode(CENTER);
          tint(255, rock.getRemainingFrames()/ (float) rock.DEFAULT_FRAMES * 255);
          // FOR TESTING PURPOSES: draw circle that the player needs to
          //  be in to be "safe"
          ellipseMode(CORNER);
          ellipse(rock.gridX, rock.gridY, width / mapModel.mapX, height / mapModel.mapY);
          //                  top left corner         size to make the image
          image(rockPlatform, rock.gridX, rock.gridY, width / mapModel.mapX, height / mapModel.mapY);
        }
        break;
      case END:
        break;
    }
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Main" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
