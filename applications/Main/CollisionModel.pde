class CollisionModel {
  MapModel mapModel;

  CollisionModel(MapModel mapModel) {
    this.mapModel = mapModel;
  }

  void update() {
    for (PlayerModel player : mapModel.players) {
      player.setCollidingWithLava(true); //assume touching lava unless we find player is colliding with rock
      for (RockModel rock : mapModel.rocks) {
        // rock is an ellipse, calculate whether the player point is in it
        // is this actually faster to do this first?
        // check rectangle,
        int pX = player.getRawX();
        int pY = player.getRawY();
        int cX = rock.getRawX();
        int cY = rock.getRawY();
        int w = rock.getWidth();
        int h = rock.getHeight();
        //check rectangle
        if (!(abs(pX - cX) > w/2.0 || abs(pY - cY) > h/2.0) &&
          //then check ellipse
          (sq(pX - cX) / sq(w/2) + sq(pY - cY) / sq(h/2) <= 1)) {
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
}

