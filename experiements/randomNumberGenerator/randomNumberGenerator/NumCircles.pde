class NumCircles {
  
  int numCircles;
  int circleR;
  int size_width, size_height;
  PFont f;
  ArrayList<PVector> visited;
  ArrayList<Rock> rocks; 
  
// Contructor
  NumCircles(int numCircles, int circleR, int size_width, int size_height) 
  {
    this.numCircles = numCircles; 
    this.circleR = circleR; 
    this.size_width = size_width; 
    this.size_height = size_height;
    visited = new ArrayList<PVector>();
    rocks = new ArrayList<Rock>(); 
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
  
  //Generate circle positions and list of rocks
  void generatePositions(){
    for (int i = 0; i < numCircles; i++) {
      PVector p = preventCollision();
      visited.add(new PVector(p.x, p.y));
      rocks.add(new Rock(p.x, p.y, 0.75));
    }
  }
  
  //draw the circles
  void draw(){
    for (int i = 0; i < numCircles; i++) {
      PVector p = visited.get(i); 
      noFill();
      shapeMode(CENTER);
      
      rocks.get(i).draw();
      rocks.get(i).setDisappear(true);
      stroke(255, 255, 255, 255);
      fill(255, 255, 255, 255);
      ellipse(p.x, p.y, circleR, circleR);
      textFont(f,16);// Specify font to be used
      fill(0); // Specify font color 
      textAlign(CENTER);
      text(i,p.x,p.y+5);   // Display Tex    
    }

  }
}
