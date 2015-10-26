// MapController - handles rock and map models

class MapController {
	MapModel mapModel;

    // constructor
    MapController(MapModel mapModel) {
    	this.mapModel = mapModel;
    }

    void update() {
    	// update rocks and players
    	for (PlayerModel player : mapModel.players) {
    		player.update();
    	}
    	for (RockModel rock : mapModel.rocks) {
    		rock.update();
    	}

    	// TODO: check state of player (in or out of bounds)
    	// for location in rocks.getLocations()
    	// 		if player.location == location
    	//			player is safe!
    	//  if player isn't safe
    	//		change game state to "game over"

    	for () {
    		
    	}
    }
}
