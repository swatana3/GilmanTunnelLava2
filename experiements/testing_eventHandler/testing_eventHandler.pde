float bx;
float by;
int boxSize = 75;
boolean overBox = false;
boolean locked = false;
float xOffset = 0.0; 
float yOffset = 0.0; 
import java.awt.Event;


private GameEngine engine = new GameEngine();

void setup() {
  size(640, 360);
  bx = width/2.0;
  by = height/2.0;
  rectMode(RADIUS); 
  
  registerDraw(engine);
  registerMouseEvent(engine);
}

void draw() { 
  background(0);
  
  // Test if the cursor is over the box 
  if (mouseX > bx-boxSize && mouseX < bx+boxSize && 
      mouseY > by-boxSize && mouseY < by+boxSize) {
    overBox = true;  
    if(!locked) { 
      stroke(255); 
      fill(153);
    } 
  } else {
    stroke(153);
    fill(153);
    overBox = false;
  }
  
  // Draw the box
  rect(bx, by, boxSize, boxSize);
}