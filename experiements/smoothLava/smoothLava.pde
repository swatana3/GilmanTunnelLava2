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
final float v = 100; //variation
final float o = 1; //offset

void draw() {
  background(255);
  
  beginShape();
  curveVertex(230 +noise(frameCount*s+o*12)*v, 360 +noise(frameCount*s+o*13)*v); //start control point same as second to last
  curveVertex(120 +noise(frameCount*s+o* 0)*v, 350 +noise(frameCount*s+o* 1)*v);
  curveVertex(270 +noise(frameCount*s+o* 2)*v, 220 +noise(frameCount*s+o* 3)*v);
  curveVertex(450 +noise(frameCount*s+o* 4)*v, 120 +noise(frameCount*s+o* 5)*v);
  curveVertex(560 +noise(frameCount*s+o* 6)*v, 200 +noise(frameCount*s+o* 7)*v);
  curveVertex(490 +noise(frameCount*s+o* 8)*v, 260 +noise(frameCount*s+o* 9)*v);
  curveVertex(380 +noise(frameCount*s+o*10)*v, 230 +noise(frameCount*s+o*11)*v);
  curveVertex(230 +noise(frameCount*s+o*12)*v, 360 +noise(frameCount*s+o*13)*v);
  curveVertex(120 +noise(frameCount*s+o* 0)*v, 350 +noise(frameCount*s+o* 1)*v);
  curveVertex(270 +noise(frameCount*s+o* 2)*v, 220 +noise(frameCount*s+o* 3)*v); //end control point same as second from first
  endShape();
}
