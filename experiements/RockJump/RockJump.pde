PImage rock;
float amplitude = 0.10;
float decay = 0.002;
float minScale = 1.0;
float t=0;

void setup() {
  // essential game stuff
  // can't put this in view, rocks depend on height and width being set
  size(600, 400); 
  rock = loadImage("../../assets/rockPlatform1.png");
}
void draw() {
  imageMode(CENTER);
  background(255);
  float sineScale = (minScale) - (amplitude * sin(2 * PI * t / 60) + amplitude); 
  if (amplitude > 0) {
    amplitude -= decay;
  } else {
    amplitude = 0;
  }
  
  image(rock, 300, 200, sineScale * 100, sineScale * 100);
  t += 1;
}
