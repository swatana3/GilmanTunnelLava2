import processing.opengl.*;
import SimpleOpenNI.*;
SimpleOpenNI kinect;
float rotation = 0;
// declare our hotpoint object
Hotpoint floor; 
float s = 1;
void setup() {
  size(600, 400, OPENGL);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  // enable skeleton generation for all joints
  kinect.enableUser();
  // draw thickness of drawer
//  strokeWeight(3);
  // smooth out drawing
  smooth();
  // initialize hotpoints with their origins (x,y,z) and their width, height, length
  floor = new Hotpoint(0, -600, 2100, 2000, 50, 1500); 
}

void draw() {
  background(0);
  kinect.update();
  translate(width/2, height/2, -1000);
  rotateX(radians(180));
  translate(0, 0, 1400);
  rotateY(radians(map(mouseX, 0, width, -180, 180)));
  translate(0, 0, s*-1000);
  scale(s);
  stroke(255);
  PVector[] depthPoints = kinect.depthMapRealWorld();
  for (int i = 0; i < depthPoints.length; i+=10) {
    PVector currentPoint = depthPoints[i];
    // have each hotpoint check to see if it includes the currentPoint
    floor.check(currentPoint); 
    point(currentPoint.x, currentPoint.y, currentPoint.z);
  }
  println(floor.pointsIncluded); 
  if(floor.isJump()) { 
    println ("User is jumping!"); 
  }
  // display each hotpoint and clear its points
  floor.draw(); 
  floor.clear();
}
void keyPressed() {
  if (keyCode == 38) {
    s = s + 0.01;
  }
  if (keyCode == 40) {
    s = s - 0.01;
  }
}
