//https://www.processing.org/tutorials/curves/
//http://funprogramming.org/36-Organic-random-animation-using-noise.html

color i1, i2, f1, f2, c1, c2;
 
int i =0;
int R = 255;
int v = 150;

void setup() {
  size(720, 480);
  //background(255);
  smooth();
  //stroke(252, 92, 36);
  noStroke();
  fill(252, 92, 36);
  tint(255, 127);
  
  // Define colors
  
  i1 = color(random(R), random(R), random(R));
  i2 = color(random(R), random(R), random(R));
  c1 = i1;
  c2 = f2;
  f1 = i1;
  f2 = i2;
  //noLoop();
  
}
 
      float generation = 0;
//final float speed = 2;
final float speed = .8;
final float variation = 10;
final float offset = 1;
final float dead_zone = 100;
 
//need to reverse motion of lava at some point to prevent overlapping of coord
 
float avg_x = 0;
float avg_y = 0;
 
float[] coords = {120,350, 270,220, 450,120, 560,200, 490,260, 380,230, 230,360};
 
void draw() {
  if(frameCount % 60 == 0)
    generation += variation;
   
  avg_x = find_avg_x();
  avg_y = find_avg_y();
 
 
    for(int i = 0; i < coords.length; i++) {
      if (i % 2 == 0) // x-coord
        coords[i] = find_new_coord(avg_x, i);
      else
        coords[i] = find_new_coord(avg_y, i);
    }
      
      //background(0);
  if ( red(c1) == red(f1) && green(c1) == green(f1) && blue(c1) == blue(f1) ) {
   pickNewColor();
    //background(255);
    i++;
  }
  // make gradient
  float inter = map(i, 0, v, 0,1); {
  c1 = lerpColor(i1, f1, inter);
  c2 = lerpColor(i2, f2, inter);
  setGradient(0, 0, width, height, c1, c2);
  }

   
    beginShape();
    curveVertex(coords[coords.length-2], coords[coords.length-1]); //start control point same as second to last
    curveVertex(coords[ 0], coords[ 1]);
    curveVertex(coords[ 2], coords[ 3]);
    curveVertex(coords[ 4], coords[ 5]);
    curveVertex(coords[ 6], coords[ 7]);
    curveVertex(coords[ 8], coords[ 9]);
    curveVertex(coords[10], coords[11]);
    curveVertex(coords[12], coords[13]);
    curveVertex(coords[ 0], coords[ 1]);
    curveVertex(coords[ 2], coords[ 3]); //end control point same as second from first
    endShape();
  }
 
// The avg coord (x-coord or y-coord) and dead zone form a band which the new coord isn't allowed to be in.
// If the new coord is in the dead band, continue to use the original coord.
// Otherwise, use the newly generated coord.
float find_new_coord(float avg_coord, int i){
    float delta = ( noise(generation +offset*i) -0.5 ) * speed;
    float new_coord = coords[i] + delta;
   
    if (new_coord > avg_coord && (new_coord - dead_zone) > avg_coord)
      return new_coord;
    else if (new_coord < avg_coord && (new_coord + dead_zone) < avg_coord)
      return new_coord;
    return coords[i];
}
 
 
float find_avg_x() {
  float x = 0;
  for (int i = 0; i < coords.length; i++) {
    if (i % 2 == 0)
      x += coords[i];
  }
  return x*2/coords.length;
}
 
float find_avg_y() {
  float y = 0;
  for (int i = 0; i < coords.length; i++) {
    if (i % 2 != 0)
      y += coords[i];
  }
  return y*2/coords.length;
}


void pickNewColor(){
     
    i1 = f1;
    i2 = f2;
     
    f1 = color(random(R), random(R), random(R));
    f2 = lerpColor(i1, i2, 0.5); 
     
    i =0;
}
 
void setGradient(int x, int y, float w, float h, color c1, color c2 ) {
  
 for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
 }
}