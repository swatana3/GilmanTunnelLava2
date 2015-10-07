class NumCircles {
  
  int numCircles;
  int circleR;
  int size_width, size_height;
  PFont f;
  ArrayList<PVector> visited; 
  
// Contructor
  NumCircles(int numCircles, int circleR, int size_width, int size_height) 
  {
    this.numCircles = numCircles; 
    this.circleR = circleR; 
    this.size_width = size_width; 
    this.size_height = size_height;
    visited = new ArrayList<PVector>(); 
    f = createFont("Arial",16,true); // Arial, 16 point, anti-aliasing on
    textFont(f,36);
  }
  
  //Method for avoiding collision of circles
  PVector preventCollision(){
    int x = (int)random(circleR, size_width-circleR);
    int y = (int)random(circleR, size_height-circleR);
    PVector randomP = new PVector(x, y);
    for (PVector p : visited) {
      //check if it is radius of visited
      if (dist(randomP.x, randomP.y, p.x, p.y) < circleR ) {
      //you want to change random P
        randomP =preventCollision();
        println("prevented collision!");
      }
    }
    return randomP;
  }
  
  //draw the circles
  void draw(){
    
    for (int i = 0; i < numCircles; i++) {
      PVector p = preventCollision(); 
      noFill();
      shapeMode(CENTER);
      ellipse(p.x, p.y, circleR, circleR);
      textFont(f,16);// STEP 3 Specify font to be used
      fill(0);
      //shapeMode(CORNER);// STEP 4 Specify font color 
      textAlign(CENTER);
      text(i,p.x,p.y+5);   // STEP 5 Display Tex    
      visited.add(new PVector(p.x, p.y));
    }

  }
}