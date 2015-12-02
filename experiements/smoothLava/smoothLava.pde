//https://www.processing.org/tutorials/curves/


void setup() {
  size(720, 480);
  background(255);
  smooth();
  stroke(0);
  fill(127);
}


void draw() {
  beginShape();
  curveVertex(230, 360); //start control point same as second to last
  curveVertex(120, 350);
  curveVertex(270, 220);
  curveVertex(450, 120);
  curveVertex(560, 200);
  curveVertex(490, 260);
  curveVertex(380, 230);
  curveVertex(230, 360);
  curveVertex(120, 350);
  curveVertex(270, 220); //end control point same as second from first
  endShape();
}
