class Rock {
  float x,y;
  float scale;
  PShape rockPlatShape;
  PShape rockDetailShape;
  boolean disappear = false;
  float opacity = 1.0;
  
  Rock(float x, float y, float scale) {
    this.rockPlatShape = loadShape("../../../assets/rockPlatform1.svg");
    this.x = x;
    this.y = y;
    this.scale = scale;
  }
  
  void setDisappear(boolean disappear) {
    this.disappear = disappear;
  }
  
  void draw() {
    if (disappear) {
      opacity -= 0.1;
      if (opacity <= 0) {
        opacity = 0;
      }
    }
    shapeMode(CENTER);
    rockPlatShape.disableStyle();
    println(rockPlatShape.width * scale, rockPlatShape.height * scale);  
    stroke(color(65, 63, 81, opacity*255));
    fill(color(65, 63, 81, opacity*255));
    shape(rockPlatShape, x, y, rockPlatShape.width * scale, rockPlatShape.height * scale);
  }
}
