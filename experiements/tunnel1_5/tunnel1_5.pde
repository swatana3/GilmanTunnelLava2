import gifAnimation.*;

// Size of cells
int cellSize = 32;

// Number of rocks
int nRocks = 5;

// Number of lavas
int nLavas = 10;

// Variables for timer
int interval = 100;
int lastRecordedTime = 0;

LavaField field;
LavaFieldRenderer renderer;
LavaFieldController controller;
Gif rockGif;
Gif bubbleGif;
Gif lavaGif;
ArrayList<Lava> lavas = new ArrayList<Lava>();

void setup() {
  size(900, 480);
  frameRate(60);
  // Sets the color for the background grid
  stroke(48);
  noSmooth();
  
  // Load the animated gif and start animation
  rockGif = new Gif(this, "Rock1Animation3.gif");    
  rockGif.play();
  bubbleGif = new Gif(this, "BubbleAnimation4.gif");    
  bubbleGif.play();
//  lavaGif = new Gif(this, "Rock1Animation3.gif");    
  lavaGif = new Gif(this, "Lava_Animation_AE.gif");    
  lavaGif.play();

//  generateLava(lavaGif, 1);

  image(lavaGif, 0, 0, width, height);

  
  // Create lava field which is a grid with some rocks
  this.field = new LavaField(nRocks);
  
  // Show lava field
  this.renderer = new LavaFieldRenderer(field);
  
  // Create controller which manages rocks in lava field and processes mouse clicks.
  this.controller = new LavaFieldController(field);
}

// Generate a few lava positions randomly
void generateLava(Gif lavaGif, int nLavas) {
  // Clear all existing objects, if any, in the lava array list.
  this.lavas.clear();
  
  for (int i = 0; i < nLavas; i++) {
    float x = random(width);
    float y = random(height);

    // Layer2 and layer3 aren't applicable. Pass null.
    Lava L1 = new Lava(lavaGif, null, null, x, y);
    //L1.ay = -0.4;
    
    // Specify image's horizontal speed across the screen. Zero means stationary. Negative means move to the left.
    L1.vx = -1 + random(10)/10.0;
    
    // Specify image's vertical sinusoidal movement. Zero means no vertical movement.
    L1.ampY = 0;// + random(3);
    L1.perY = 3;
    
    // Specify image's horizontal sinusoidal movement. Zero means no horizontal oscillation but image still moves to the left.
    L1.ampX = 0;
    
    // Specify image's scale
    L1.ampS = 0.02;
    L1.perS = 5 + random(3);
    
    // Save lava object in a list
    this.lavas.add(L1);
  }
}

// Render all lava saved in the list
void renderLava(int nLavas) {
  for (Lava lava : this.lavas) {
    lava.draw();
  }
}

// Called by the system continuously. No need to execute code in this function too often.
// So, use timer ticks to manage execution. Execute code only after 100 timer ticks have past.
void draw() {

  //Draw grid
  this.renderer.render();

  // Manages lava, player and rocks periodically. Interval is 100 timer ticks.
  if (millis()-lastRecordedTime>interval) {
    this.controller.update();
    lastRecordedTime = millis();
  }
}

void mousePressed()
{
  // Pass the mouse position to the controller to process
  this.controller.onMousePressed(mouseX, mouseY);
}

void keyPressed() {
  // Pass the keystroke to the controller to process
  this.controller.onKeyPressed(key);
}


// View
class LavaFieldRenderer {

  // Colors for rock, player, empty. Player must be on a rock, not empty cell.
  // private color rockColor = color(0, 200, 0);
  private color rockColor = color(0);
  private color playerColor = color(100, 100, 100);
  private color emptyColor = color(0);
  
  private LavaField field;
  
  public LavaFieldRenderer(LavaField field) {
    this.field = field;
    background(0); // Fill window background
  }
  
  public void render() {
    //background(255); //reset frame
     //<>//
     
     // render lavas
     //renderLava(nLavas);
    image(lavaGif, 0, 0, 900, 480);
    
    // render the grid
    //for (int x=0; x<width/cellSize; x++) {
    //  for (int y=0; y<height/cellSize; y++) {
    //    fill(emptyColor);
    //    rect(x*cellSize, y*cellSize, cellSize, cellSize);
    //  }
    //}
    //image(lavaGif, -500, -1000, 5*width, 10*height);
    
    // render the rocks
    for (Rock rock : this.field.getRocks()) {
      //fill(emptyColor);
      //rect(rock.getX()*cellSize, rock.getY()*cellSize, cellSize, cellSize);
      image(rockGif, rock.getX()*cellSize, rock.getY()*cellSize, 1.5*cellSize, 1.5*cellSize);
    }
      
    // render player if player has selected a rock
    Player player = this.field.getPlayer();
    if (player.getX() != -1 && player.getY() != -1) {
      // Reset the cell back to empty color
      //fill(emptyColor);
      //rect(player.getX()*cellSize, player.getY()*cellSize, cellSize, cellSize);
  
      // Show player
      //PImage img = player.getImage();
      //image(img, player.getX()*cellSize, player.getY()*cellSize, cellSize, cellSize);
      image(bubbleGif, player.getX()*cellSize, player.getY()*cellSize, cellSize, cellSize);
    }
  }

}

// Model contains Player, Rock, and LavaField.
class Player {

  // Position of player in the grid. Set by controller on mouse click.
  private int x = -1;
  private int y = -1;
   
  public int getX() {
    return this.x;
  }
  public void setX(int x) {
    this.x = x;
  }
  public int getY() {
    return this.y;
  }
  public void setY(int y) {
    this.y = y;
  } 
  //public PImage getImage() {
  //  return this.playerImage;
  //}
}

class Rock {

  // Cell position of rock in grid
  private int x = -1;
  private int y = -1;

  public Rock(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  public int getX() {
    return x;
  }
  
  public int getY() {
    return y;
  }
}

class LavaField {
   
  private Object[][] grid;
  private ArrayList<Rock> rocks = new ArrayList<Rock>();
  private Player player = new Player();
  
  public LavaField(int Rocks) {
    
    // Create a game grid and clear it before use.
    this.grid = new Object[width/cellSize][height/cellSize];
    clearCells();
    
    // Place some rocks in the grid
    placeRocks(nRocks);
  }
 
  // Clear cells, player and rocks
  private void clearCells() {
    for (int x=0; x<width/cellSize; x++) {
      for (int y=0; y<height/cellSize; y++) {
        this.grid[x][y] = null; // empty cell, no rock
      }
    }

    this.player.setX(-1);
    this.player.setY(-1);
    this.rocks.clear();
  }
  
  private void placeRocks(int nRocks) {
    for (int i = 0; i < nRocks; i++) {
      float x;
      float y;
      do {
        // Generate rock position
        x = random (width/cellSize);
        y = random (height/cellSize);
        // If cell is occupied, re-generate new position.
      } while (this.grid[int(x)][int(y)] != null);
      
      // Place a rock in the cell.
      this.grid[int(x)][int(y)] = new Rock(int(x), int(y));
      
      // Keep track of rocks in a list.
      this.rocks.add((Rock) this.grid[int(x)][int(y)]);
    }   
  }  
  
  public ArrayList<Rock> getRocks() {
    return this.rocks;
  }

  public Object[][] getGrid() {
    return this.grid;
  }
  
  public Player getPlayer() {
    return this.player;
  }
}

// Controller handles key strokes, mouse clicks, lava and rock movements.
class LavaFieldController {

  private LavaField field;
   
  public LavaFieldController(LavaField field) {
    this.field = field;
  }
  
  // This is the brain of the game. It manages player and rock positions.
  public void update() {

  }
  
  // x, y are the pixel positions of the mouse click.
  public boolean onMousePressed(int x, int y) {
    
    // Map and avoid out of bound errors
    int xCellOver = int(map(x, 0, width, 0, width/cellSize));
    xCellOver = constrain(xCellOver, 0, width/cellSize-1);
    int yCellOver = int(map(y, 0, height, 0, height/cellSize));
    yCellOver = constrain(yCellOver, 0, height/cellSize-1);
  
    // Check to see if selected cell has a rock.
    if (this.field.getGrid()[xCellOver][yCellOver] != null) { // Cell has rock
      // Move player to new position. Previous position still has a rock.
      this.field.getPlayer().setX(xCellOver);
      this.field.getPlayer().setY(yCellOver);
    }
   
    return true;
  }
  
  public boolean onKeyPressed(char key) {
    if (key == 'r' || key == 'R') {
      // Restart: reinitialization of cells
      //this.field.clearCells();
      //this.field.placeRocks(nRocks);
      // Clear screen and restart
      background(0); // Fill window background
      generateLava(lavaGif, nLavas);
    }
    
    return true;
  }
}

