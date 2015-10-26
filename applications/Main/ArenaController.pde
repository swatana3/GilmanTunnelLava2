public class ArenaController {

  private static final int unit = 32;
  private Arena arena;
  
  /** the target cell **/
  private float targetX, targetY;
  /** true if the droid moves **/
  private boolean moving = false;
  
  public ArenaController(Arena arena) {
    this.arena = arena;
  }
  
  public void update(int framecount) {
    Player player = player.getPlayer();
    if (moving) {
      // move on X
      int bearing = 1;
      if (player.getX() > targetX) {
        bearing = -1;
      } 
      if (player.getX() != targetX) {
        player.setX(player.getX() + bearing * player.getSpeed() * delta);
        // check if arrived
        if ((player.getX() < targetX && bearing == -1)
            || (player.getX() > targetX && bearing == 1)) player.setX(targetX);
      }
      // move on Y
      bearing = 1;
      if (player.getY() > targetY) {
        bearing = -1;
      } 
      if (player.getY() != targetY) {
        player.setY(player.getY() + bearing * player.getSpeed() * delta);
        // check if arrived
        if ((player.getY() < targetY && bearing == -1)
            || (player.getY() > targetY && bearing == 1)) player.setY(targetY);
      }
      // check if arrived
      if (player.getX() == targetX && player.getY() == targetY) 
        moving = false;
    }
  }
  
  /** triggered with the coordinates every click **/
  public boolean onClick(int x, int y) {
    targetX = x / unit;
    targetY = y / unit;
    if (arena.getGrid()[(int) targetY][(int) targetX] == null) {
      // start moving the droid towards the target
      moving = true;
      return true;
    }
    return false;
  }
}