class CollisionModel {
  private PlayerStepsOnRockEvent playerStepsOnRockEvent = new PlayerStepsOnRockEvent();
  
  private MapModel mapModel;

  CollisionModel(MapModel mapModel) {
    this.mapModel = mapModel;
  }

  void update() {
    for (PlayerModel player : mapModel.players) {
      //assume touching lava unless we find player is colliding with rock
      player.setCollidingWithLava(true);
      for (RockModel rock : mapModel.getRocks()) {
        // rock is an ellipse, calculate whether the player point is in it
        // is this actually faster to do this first?
        // check rectangle,
        int pLX = player.getRawLX();
        int pLY = player.getRawLY();
        int pRX = player.getRawRX();
        int pRY = player.getRawRY();
        int cX = rock.getRawX();
        int cY = rock.getRawY();
        int w = rock.getWidth();
        int h = rock.getHeight();
        //check rectangle
        if (  (!(abs(pLX - cX) > w/2.0 || abs(pLY - cY) > h/2.0) &&
            //then check ellipse
              (sq(pLX - cX) / sq(w/2) + sq(pLY - cY) / sq(h/2) <= 1)) ||
              //check other rectangle
              (!(abs(pRX - cX) > w/2.0 || abs(pRY - cY) > h/2.0) &&
              //then check ellipse
              (sq(pRX - cX) / sq(w/2) + sq(pRY - cY) / sq(h/2) <= 1))
           )
           {
            // if player wasn't on this rock before,
            if (!rock.collidingWithPlayer) {
              // create PlayerStepsOnRockEvent
              playerStepsOnRockEvent.notifyEvent(rock);
            }
            rock.setCollidingWithPlayer(true);
            player.setCollidingWithLava(false);
            // DEBUGGING
            println("rock(" + cX + "," + cY + "): " + rock.getRemainingFrames());
        } else { //non collision
          rock.setCollidingWithPlayer(false);
        }
      }
    }
  }
  
  MapModel getModel(){
    return mapModel;
  }

  PlayerStepsOnRockEvent playerStepsOnRockEvent() {
    return playerStepsOnRockEvent;
  }
}

