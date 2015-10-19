public class SimpleArenaRenderer {

  private Arena arena;
  
  public SimpleArenaRenderer(Arena arena) {
    this.arena = arena;
  }
  
  @Override
  public void render() {
    // render the grid
    int cellSize = 32; // hard coded
    
    // render the rocks must still need to implement
    g.setColor(new Color(0, 0, 1f));
    for (Obstacle obs : arena.getObstacles()) {
      int x = (int) (obs.getX() * cellSize) + 2;
      int y = (int) (obs.getY() * cellSize) + 2;
      g.fillRect(x, y, cellSize - 4, cellSize - 4);
    }
 
    // render player dot for testing purposes for now
    g.setColor(new Color(0, 1f, 0));
    Droid droid = arena.getDroid();
    int x = (int) (droid.getX() * cellSize);
    int y = (int) (droid.getY() * cellSize);
    g.fillOval(x + 2, y + 2, cellSize - 4, cellSize - 4);
    // render square on droid
    g.setColor(new Color(0.7f, 0.5f, 0f));
    g.fillRect(x + 10, y + 10, cellSize - 20, cellSize - 20);
  }
}