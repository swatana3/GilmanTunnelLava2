class Hotpoint {
  PVector center;
  color fillColor;
  color strokeColor;
  int lengthBox;
  int widthBox;
  int heightBox; 
  int pointsIncluded;
  int maxPoints;
  boolean wasJustHit;
  int threshold;
  
  Hotpoint(float centerX, float centerY, float centerZ, int lengthB,int widthB, int heightB) { 
    center = new PVector(centerX, centerY, centerZ);
    lengthBox = lengthB;
    widthBox = widthB;
    heightBox = heightB;
    
    pointsIncluded = 0;
    maxPoints = 1000;
    threshold = 0;
    fillColor = strokeColor = color(205, 0, 0);
  }
  void setThreshold( int newThreshold ){
    threshold = newThreshold;
  }
  void setMaxPoints(int newMaxPoints) {
    maxPoints = newMaxPoints;
  }
  void setColor(float red, float blue, float green){
    fillColor = strokeColor = color(red, blue, green);
  }
  boolean check(PVector point) { 
    boolean result = false;
    if (point.x > center.x - widthBox/2 && point.x < center.x + widthBox/2) {
      if (point.y > center.y - lengthBox/2 && point.y < center.y + lengthBox/2) {
        if (point.z > center.z - heightBox/2 && point.z < center.z + heightBox/2) {
          result = true;
          pointsIncluded++;
         }
       }
    }
    return result;
  }
  void draw() { 
    pushMatrix(); 
    translate(center.x, center.y, center.z);
//    rotateX(-PI);
    fill(red(fillColor), blue(fillColor), green(fillColor),
    255 * percentIncluded());
    stroke(red(strokeColor), blue(strokeColor), green(strokeColor), 255); //fourth variableopacity
    box(lengthBox, widthBox, heightBox);
    popMatrix();
  }
  float percentIncluded() {
    return map(pointsIncluded, 0, maxPoints, 0, 1);
  }
  boolean currentlyHit() {
    return (pointsIncluded > threshold);
  }
  boolean isHit() { 
    return currentlyHit() && !wasJustHit;
  }
  boolean isJump() { 
    println ("User is jumping!"); 
    return !currentlyHit() && wasJustHit;
  }
  void clear() { 
    wasJustHit = currentlyHit();
    pointsIncluded = 0;
  }
}
