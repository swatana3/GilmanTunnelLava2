boolean movingRock = false;
RockModel r;

//now i need to make the velocity and elliptical movement
//don't check for collision yet...

// center point of ellipse
  int cX, cY;
  // velocity of this rock - don't know if this is how it should be done yet?
  float vX, vY;

void setup() {
  // do velocity now
  size(600, 400);
  r = new RockModel(width/2, height/2);
}
void draw(){
  r.updateVelocity();
}
