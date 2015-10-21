class MapModel {
  ArrayList<RockModel> rocks;
  
  public MapModel() {
    rocks = new ArrayList<RockModel>();
    rocks.add(new RockModel(100, 50));
    rocks.add(new RockModel(200, 40));
    rocks.add(new RockModel(500, 60));
    for (RockModel rock : rocks) {
      rock.setFrameLife(50);
    }
  }
  
  ArrayList<RockModel> getRocks() {
    return rocks;
  }
}
