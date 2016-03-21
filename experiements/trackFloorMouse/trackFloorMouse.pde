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

//where the mouse is and how the Kinect sees it. 
float currentX;
float currentY;
float currentZ; 

//current mouses
float currentMouseX;
float currentMouseY;

float mouseBottomLX;
float mouseBottomLY;

//while there is no keyboard input
boolean cont; 

//Coordinates of the rectange on the floor
//use ModelX, ModelY, ModelZ to set them
float floorX; 
float floorY;
float floorZ;

//the floor height
float floorWidth;
float floorLength;
int floorHeight;

//if the corners are set
boolean bottomRSet;
boolean bottomLSet;
boolean topRSet;
boolean topLSet;
boolean floorCalibrated; 

//depthPoints
 PVector[] depthPoints;

//Frame
PImage currentFrame;

void setup()
{
 size(640, 480, P3D);
 kinect = new SimpleOpenNI(this);
 kinect.enableRGB();
 kinect.enableDepth();
 
 //function that aligns rgb and depth
 kinect.alternativeViewPointDepthToImage();
 
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
 floorHeight = 100; 
 //for keyboard input
 cont = false; 
 println("Select bottom right corner");
 
}
void draw() 
{
  kinect.update();
  currentFrame = kinect.rgbImage ();
  depthPoints = kinect.depthMapRealWorld();
  if (floorCalibrated == false){
    image(currentFrame,0,0);
  } else {
//    println("going to this if statement");
//    stroke(204, 102, 130);    // Setting the outline (stroke) to black
//    fill(204, 102, 0); 
//    translate(bottomLCorner.x, bottomLCorner.y, bottomLCorner.z);
//    box (floorWidth, floorLength, floorHeight); 
    stroke(204, 102, 130);    // Setting the outline (stroke) to black
    fill(204, 102, 0); 
    translate(abs(bottomLCorner.x), abs(bottomLCorner.y), abs(bottomLCorner.z));
    box (149, 80, 100); 
    println ("bottomLCorner.x is " + abs(bottomLCorner.x));
    println ("bottomLCorner.y is " + abs(bottomLCorner.y));
    println ("bottomLCorner.z is " + abs(bottomLCorner.z));
    println ("mouseBottomLX is " + mouseBottomLX);
    println ("mouseBottomLY is " + mouseBottomLY);
  }
  //loads pixels in the pixels array
  currentFrame.loadPixels();

//set keypressed to false again
  cont = false; 

  
// Draw a circle at the tracked pixel
  fill(trackColor);
  strokeWeight(4.0);
  stroke(0);
  ellipse(currentMouseX,currentMouseY,16,16);
}


void mousePressed(){
// Save color where the mouse is clicked in trackColor variable
 int loc = mouseX + mouseY*(currentFrame.width);
 
 currentMouseX = mouseX;
 currentMouseY = mouseY;
 
 println (loc);
 currentX = depthPoints[loc].x;
 println("currentX is " + currentX);
 currentY = depthPoints[loc].y;
 println("currentY is " + currentY);
 currentZ = depthPoints[loc].z;
 println("currentZ is " + currentZ);

 
 trackColor = currentFrame.pixels[loc];
 //Let user be notified if they want to set it to that corner
  if (bottomRSet == false && currentX!=0){
    println("currentMouseX is " + currentMouseX);
    println("currentMouseY is " + currentMouseY);
    println("Would you like to set this as bottom right corner?(y/n)");
  } else if (bottomLSet == false && currentX!=0){
    println("currentMouseX is " + currentMouseX);
    println("currentMouseY is " + currentMouseY);
    println("Would you like to set this as bottom left corner?(y/n)");
  } else if(topRSet == false && currentX!=0){
    println("currentMouseX is " + currentMouseX);
    println("currentMouseY is " + currentMouseY);
    println("Would you like to set this as top right corner?(y/n)");
  } else if (topLSet == false && currentX!=0){
    println("currentMouseX is " + currentMouseX);
    println("currentMouseY is " + currentMouseY);
    println("Would you like to set this as top left corner?(y/n)");
  }  
 
} 

void keyPressed(){
  int keyIndex = -1;
  if (key == 'Y' || key =='y') {
   if (bottomRSet == false){
      bottomRSet = true; 
      bottomRCorner = new PVector(currentX, currentY, currentZ);
      println("bottomRCorner is" + bottomRCorner);
      println("Select bottom left corner");
    } else if (bottomLSet == false){
      bottomLSet = true; 
      bottomLCorner = new PVector(currentX, currentY, currentZ);
      println("bottomLCorner is" + bottomLCorner);
      println("Select top right corner");
      mouseBottomLX = currentMouseX;
      mouseBottomLY = currentMouseY;
    } else if(topRSet == false){
      topRSet = true; 
      topRCorner = new PVector(currentX, currentY, currentZ);
      println("topRCorner is" + topRCorner);
      println("Select top left corner");
    } else if (topLSet == false){
      topLSet = true; 
      topLCorner = new PVector(currentX, currentY, currentZ);
      println("topLCorner is" + topLCorner);
      println("Floor is set");
      createFloor(); 
      stroke(0);          // Setting the outline (stroke) to black
      fill(150); 
      println("clear floor finished");
      floorCalibrated = true;
    }
  } else if (key == 'n' || key == 'N') {
    println("Please set it as needed");
  } else {
    println("Enter either y or n");
  }
}

//create a hot point from the points we gathered. 
void createFloor(){
  float floorWidth1 = (bottomRCorner.x - bottomLCorner.x);
  println ("floorWidth1 is" + floorWidth1);
  float floorWidth2 = (topRCorner.x - topLCorner.x);
  println("floorWidth2 is" + floorWidth2);
  floorWidth = ((floorWidth1 + floorWidth2)/2);
  println("floorWidth is " + floorWidth);
  float floorLength1 = (topRCorner.y - bottomRCorner.y);
  floorLength1 = abs(floorLength1);
  println("floorLength1 is " + floorLength1);
  float floorLength2 = (topLCorner.y - bottomLCorner.y);
  floorLength2 = abs(floorLength2);
  println("floorLength2 is " + floorLength2);
  floorLength = ((floorLength1 + floorLength2)/2);
  println("floorLength is " + floorLength);
//  stroke(0);          // Setting the outline (stroke) to black
//  fill(150); 
//  box (floorWidth, floorLength, floorHeight);
//  translate(bottomLCorner.x, bottomLCorner.y, bottomLCorner.z); 
  //popMatrix(); 
}
