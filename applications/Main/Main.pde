//Main
private GameEngine engine = new GameEngine();

void setup(){
  size(480, 320);
  
}

void draw(){
  background(0);
  engine.update(framerate);
  // Render the world
  engine.render();
}
public boolean handleEvent(Event e) {
  return engine.handleEvent(e);
}