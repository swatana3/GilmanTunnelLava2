// MapController - handles rock and map models

class MapController {
  MapModel mapModel;

  // constructor
  MapController(MapModel mapModel) {
    this.mapModel = mapModel;
  }

  void update() {
    if (mapModel.state == GameState.PLAY) {
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
        player.dealDamage();
      }
    }
  }
}


// TODO: player shouldn't be able to destroy rocks after they're dead
