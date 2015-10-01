//float speed;

float x, y; //center point
float size_width, size_height; //half left of center point, half right

void setup(){
  size(900, 480);
  frameRate(60);
  
  rectMode(CENTER);
  
  //speed = 0.5; 
  
  x = 450;
  y = 240;
  size_width = 100;
  size_height = 50;
}

void draw(){
  background(255);
  //rect(x - size_width/2, y - size_height/2, size_width, size_height); //abandoned in favor of rectMode(CENTER);, see setup(){}
  rect(x, y, size_width, size_height);
  //speed = speed + 0.5;
  //if(speed>2)
    //speed = 0.5; 
  //println(speed+"\tframeCount is "+frameCount); 
}