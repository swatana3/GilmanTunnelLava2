class MapModel {
  ArrayList<RockModel> rocks;
  ArrayList<PlayerModel> players;
  // dimensions of map/game board
  int mapX, mapY;

  public MapModel() {
    // these can change
    this.mapX = 6;
    this.mapY = 4;
    
    // TODO: randomize locations
    rocks = new ArrayList<RockModel>();
    rocks.add(new RockModel(1, 1, mapX, mapY));
    rocks.add(new RockModel(4, 3, mapX, mapY));
    rocks.add(new RockModel(0, 2, mapX, mapY));
    rocks.add(new RockModel(3, 0, mapX, mapY));

    rocks.add(new RockModel(5, 3, mapX, mapY));

    generateMap();
    players = new ArrayList<PlayerModel>();
    // TODO: mouse by default
    players.add(new PlayerModel(this));

  }

  // add to rocks so someone can get across
  void generateMap() {
    float rand;
    int offsetX, offsetY;
    int currentX = 0, currentY;
    boolean rock_exists;
    currentY = (int) random(mapY);
    rocks.add(new RockModel(currentX, currentY, mapX, mapY));
    while (currentX < mapX - 1) {
        rock_exists = false;
        rand = random(1);
        if      (rand < .2)   { continue; }
        else if (rand < .8)   { offsetX = 1; }
        else                  { offsetX = 2; }
        // generating a point out of bounds
        if (currentX + offsetX >= mapX) {
          currentX = mapX - 1;
        } else {
          currentX += offsetX;
        }
        do {
          rand = random(1);
          if      (rand < .15)  { offsetY = -2; }
          else if (rand < .4)   { offsetY = -1; }
          else if (rand < .6)   { offsetY = 0; }
          else if (rand < .85)  { offsetY = 1; }
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

// .2 - same x, .6 +1 to x, .2 +2 x
//y's: .15 -2, .25 -1 .2 0, .25 +1, .15 +2
