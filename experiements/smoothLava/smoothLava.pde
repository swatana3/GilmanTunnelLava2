//https://www.processing.org/tutorials/curves/
//http://funprogramming.org/36-Organic-random-animation-using-noise.html


void setup() {
  size(720, 480);
  background(255);
  smooth();
  stroke(0);
  fill(127);
}


final float s = 0.008; //speed
final float v = 0; //variation
final float o = 1; //offset

int[] coords = {120,350, 270,220, 450,120, 560,200, 490,260, 380,230, 230,360};

void draw() {
  background(255);
  
  beginShape();
  curveVertex(coords[coords.length-2] +noise(frameCount*s+o*12)*v, coords[coords.length-1] +noise(frameCount*s+o*13)*v); //start control point same as second to last
  curveVertex(coords[ 0] +noise(frameCount*s+o* 0)*v, coords[ 1] +noise(frameCount*s+o* 1)*v);
  curveVertex(coords[ 2] +noise(frameCount*s+o* 2)*v, coords[ 3] +noise(frameCount*s+o* 3)*v);
  curveVertex(coords[ 4] +noise(frameCount*s+o* 4)*v, coords[ 5] +noise(frameCount*s+o* 5)*v);
  curveVertex(coords[ 6] +noise(frameCount*s+o* 6)*v, coords[ 7] +noise(frameCount*s+o* 7)*v);
  curveVertex(coords[ 8] +noise(frameCount*s+o* 8)*v, coords[ 9] +noise(frameCount*s+o* 9)*v);
  curveVertex(coords[10] +noise(frameCount*s+o*10)*v, coords[11] +noise(frameCount*s+o*11)*v);
  curveVertex(coords[12] +noise(frameCount*s+o*12)*v, coords[13] +noise(frameCount*s+o*13)*v);
  curveVertex(coords[ 0] +noise(frameCount*s+o* 0)*v, coords[ 1] +noise(frameCount*s+o* 1)*v);
  curveVertex(coords[ 2] +noise(frameCount*s+o* 2)*v, coords[ 3] +noise(frameCount*s+o* 3)*v); //end control point same as second from first
  endShape();
}
