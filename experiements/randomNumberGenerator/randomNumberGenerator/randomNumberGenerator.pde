//this is a program to draw a random number generator
int size_width, size_height; //center point
PFont f;
NumCircles n;

void setup(){
  size_width = 900;
  size_height = 400; 
  size(900, 400);
 
 background (225);
 //frameRate(4);
 f = createFont("Arial",16,true); // Arial, 16 point, anti-aliasing on
 textFont(f,36);
  //rectMode(CENTER);
  n = new NumCircles(50, 25,size_width, size_height );
  n.generatePositions();  
  //speed = 0.5; 
}


void draw () {
  background(225);
  n.draw(); 
}
