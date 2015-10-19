import java.util.ArrayList;
import java.util.List;
import java.util.Random;

class Arena {
  
  static final int WIDTH = 480 / 32; 
  static final int HEIGHT = 320 / 32;
  
  //static Random random = new Random(System.currentTimeMillis());

  private Object[][] grid;
  private List<RockModel>  rocks = new ArrayList<RockModel>();
  private Player player;
  
  public Arena(Player player) {
    this.player= player;

    grid = new Object[HEIGHT][WIDTH];
    for (int i = 0; i < WIDTH; i++) {
      for (int j = 0; j < HEIGHT; j++) {
        grid[j][i] = null;
      }
    }
    // add 5 rocks at random positions
    for (int i = 0; i < 5; i++) {
      int x = random.nextInt(WIDTH);
      int y = random.nextInt(HEIGHT);
      while (grid[x][y] != null) {
        x = random.nextInt(WIDTH);
        y = random.nextInt(HEIGHT);
      }
      grid[x][y] = new RockModel(x, y);
      obstacles.add((RockModel) grid[y][x]);
    }
  }
  
  public List<Rocks> getRocks() {
    return rocks;
  }
  
  public Player getPlayer() {
    return player;
  }
}