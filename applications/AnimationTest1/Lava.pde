class Lava {
  PShape layer1, layer2, layer3;
  float x, y; //center point
  float size_width, size_height; //half left of center point, half right
  float scale;
  float vx, vy; //velocity
  float ax, ay; //acceleration
  float amplitude, period; //severity of flowing movement, period in seconds
  
  final static float DEFAULT_X = 450, DEFAULT_Y = 240;
  final static float DEFAULT_WIDTH = 100, DEFAULT_HEIGHT = 50;
  
  
  //Lava constructors, taking advantage of multiple constructors in Processing 3 for default values
  //default location and size
  Lava(PShape layer1, PShape layer2, PShape layer3){ 
    this(layer1, layer2, layer3, DEFAULT_X, DEFAULT_Y); //pass values through, add default location
  }
  //set location, default size
  Lava(PShape layer1, PShape layer2, PShape layer3, float x, float y){ 
    this(layer1, layer2, layer3, x, y, DEFAULT_WIDTH, DEFAULT_HEIGHT); //pass values through, add defailt size
  }
  //set location and size
  Lava(PShape layer1, PShape layer2, PShape layer3, float x, float y, float size_width, float size_height){ 
    this.layer1 = layer1;
    this.layer2 = layer2;
    this.layer3 = layer3;
    this.x = x;
    this.y = y;
    this.size_width = size_width;
    this.size_height = size_height;
    this.scale = 1;
    this.vx = 0;
    this.vy = 0;
    this.ax = 0;
    this.ay = 0;
    this.amplitude = 0;
    this.period = 0;
  }
  
  //apply physics
  void simulate(){
    //simple motion
    vx += ax;
    vy += ay;
    x += vx;
    y += vy;
      
    //harmonic
    x += amplitude/period * sin(2*PI/(period*1000/millis()));
  }
  
  //draws the layers 
  void draw(){
    simulate();
    
    shapeMode(CENTER); //required for correct drawing, otherwise would require shape(layer1, x - size_width/2, y - size_height/2, size_width, size_height);

    shape(layer3, x, y, size_width * scale, size_height * scale);
    shape(layer2, x, y, size_width * scale, size_height * scale);
    shape(layer1, x, y, size_width * scale, size_height * scale);
  }
}