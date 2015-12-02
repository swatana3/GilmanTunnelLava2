//https://www.processing.org/tutorials/curves/
//http://funprogramming.org/36-Organic-random-animation-using-noise.html


void setup() {
  size(720, 480);
  background(255);
  smooth();
  stroke(0);
  fill(127);
}

      float generation = 0;
final float speed = 2;
final float variation = 10;
final float offset = 1;

float[] coords = {120,350, 270,220, 450,120, 560,200, 490,260, 380,230, 230,360};

void draw() {
  if(frameCount % 60 == 0)
    generation += variation;
  for(int i = 0; i < coords.length; i++)
    coords[i] += ( noise(generation +offset*i) -0.5 ) * speed;
  
  
  background(255);
  
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
