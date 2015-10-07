//this is a program to draw a random number generator
int size_width, size_height; //center point
PFont f;

void setup(){
  size_width = 900;
  size_height = 400; 
  size(900, 400);
 
 background (225);
 //frameRate(4);
 f = createFont("Arial",16,true); // Arial, 16 point, anti-aliasing on
 textFont(f,36);
  //rectMode(CENTER);
  noLoop(); 
  
  //speed = 0.5; 
}

void draw () {

  for (int i = 0; i < 10; i++) {
    int x = (int)random(20, size_width-20);
    int y = (int)random(20, size_height-20);
    //rectMode(CENTER);
    //shapeMode(CENTER);
    noFill();
    shapeMode(CENTER);
    ellipse(x, y, 25, 25);
    textFont(f,16);                  // STEP 3 Specify font to be used
    fill(0);
    //shapeMode(CORNER);// STEP 4 Specify font color 
    textAlign(CENTER);
    text(i,x,y+5);   // STEP 5 Display Tex
    
  }
}