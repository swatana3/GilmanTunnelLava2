//click on four corners of the floor to calibrate the game
//have to calibrate other settings as size(x, y, P3D);

import SimpleOpenNI.*;
SimpleOpenNI kinect;
color trackColor;

//Get the corners of the whole floor
PVector bottomRCorner;
PVector bottomLCorner;
PVector topRCorner;
PVector topLCorner;

//current place where mouse is clicked
int currentX;
int currentY;

//while there is no keyboard input
boolean cont; 

//Coordinates of the rectange on the floor
//use ModelX, ModelY, ModelZ to set them
float floorX; 
float floorY;
float floorZ;

//the floor height
int floorHeight;

//if the corners are set
boolean bottomRSet;
boolean bottomLSet;
boolean topRSet;
boolean topLSet;
boolean floorCalibrated; 

//Frame
PImage currentFrame;

void setup()
{
 size(640, 480);
 kinect = new SimpleOpenNI(this);
 kinect.enableRGB();
 
 //trackColor = color (255,0,0);
 smooth ();
 currentFrame = createImage (640,480, RGB);
 
 //set all the corners being set to false; 
 bottomRSet = false;
 bottomLSet = false;
 topRSet = false;
 topLSet = false;
 floorCalibrated = false; 
 
 //intial for currentX, currentY
 currentX = 0;
 currentY = 0; 
 //set the floor z length
 floorHeight = 50; 
 //for keyboard input
 cont = false; 
 println("Select bottom right corner");
 
}
void draw() 
{
  kinect.update();
  currentFrame = kinect.rgbImage ();
  image(currentFrame,0,0);
  //loads pixels in the pixels array
  currentFrame.loadPixels();

//set keypressed to false again
  cont = false; 

  
// Draw a circle at the tracked pixel
  fill(trackColor);
  strokeWeight(4.0);
  stroke(0);
  ellipse(currentX,currentY,16,16);
}


void mousePressed(){
 currentX = mouseX;
 currentY = mouseY; 
 //color c = get(currentX, currentY);
 //println("r: " + red(c) + " g: " + green(c) + " b: " + blue(c));
 
// Save color where the mouse is clicked in trackColor variable
 int loc = currentX + currentY*(currentFrame.width);
 println (loc);
 
 trackColor = currentFrame.pixels[loc];
 //Let user be notified if they want to set it to that corner
  if (bottomRSet == false && currentX!=0){
    println("Would you like to set this as bottom right corner?(y/n)");
  } else if (bottomLSet == false && currentX!=0){
    println("Would you like to set this as bottom left corner?(y/n)");
  } else if(topRSet == false && currentX!=0){
    println("Would you like to set this as top right corner?(y/n)");
  } else if (topLSet == false && currentX!=0){
    println("Would you like to set this as top left corner?(y/n)");
  }  
 
} 

void keyPressed(){
  int keyIndex = -1;
  if (key == 'Y' || key =='y') {
    if (bottomRSet == false){
      bottomRSet = true; 
      bottomRCorner = new PVector(currentX, currentY);
      println("bottomRCorner is" + bottomRCorner);
      println("Select bottom left corner");
    } else if (bottomLSet == false){
      bottomLSet = true; 
      bottomLCorner = new PVector(currentX, currentY);
      println("bottomLCorner is" + bottomLCorner);
      println("Select top right corner");
    } else if(topRSet == false){
      topRSet = true; 
      topRCorner = new PVector(currentX, currentY);
      println("topRCorner is" + topRCorner);
      println("Select top left corner");
    } else if (topLSet == false){
      topLSet = true; 
      topLCorner = new PVector(currentX, currentY);
      println("topLCorner is" + topLCorner);
      println("Floor is set");
      createFloor(); 
    }
  } else if (key == 'n' || key == 'N') {
    println("Please set it as needed");
  } else {
    println("Enter either y or n");
  }
}

void createFloor(){
  //create the floor from the points we gathered
}
