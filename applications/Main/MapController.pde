// MapController - handles rock and map models

class MapController {
	MapModel mapModel;

    // constructor
    MapController() {
    	this.mapModel = new MapModel();
    }

    void update() {
        if (mapModel.state == GameState.PLAY) {
          // update rocks and players
      	  for (PlayerModel player : mapModel.players) {
      	    player.update();
      	  }
          /*
      	  for (RockModel rock : mapModel.rocks) {
      		rock.update();
      	  }
          */
          
      	  // TODO: check state of player (in or out of bounds)
      	  // for location in rocks.getLocations()
      	  // 		if player.location == location
      	  //			player is safe!
      	  //  if player isn't safe
      	  //		change game state to "game over"
          //RockModel
          ArrayList<RockModel> rocks_to_delete = new ArrayList<RockModel>();
          for (PlayerModel player : mapModel.players) {
            for (RockModel rock : mapModel.rocks) {
              //println(player.x + "," + player.y);
              // player is dissolving rock
              if (rock.x == player.x &&
                  rock.y == player.y) {
                  rock.decrementFramesRemaining();
                  println(rock.getRemainingFrames());
              }
              // rock has been destroyed
              if (rock.isDestroyed()) {
                rocks_to_delete.add(rock);
              }
            }
          }
          // delete rocks that have "died"
          for (RockModel rock : rocks_to_delete) {
            mapModel.rocks.remove(rock);
          }
        }

    }
    
}
