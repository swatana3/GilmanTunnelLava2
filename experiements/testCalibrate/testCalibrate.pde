/*---------------------------------------------------------------
Author : Sayge Schell

Code based off of Leonardo Merza's update of "Making Things See" example code.

Modified to track feet of a user.


This class tracks the feet of multiple users, highlighting them as red dots. It also currently
prints out the x,y,z coordinates of the feet.

----------------------------------------------------------------*/
 
/*---------------------------------------------------------------
Imports
----------------------------------------------------------------*/
// import kinect library
import SimpleOpenNI.*;

 
/*---------------------------------------------------------------
Variables
----------------------------------------------------------------*/
// create kinect object
SimpleOpenNI  kinect;
// image storage from kinect
PImage kinectDepth;
// int of each user being  tracked
int[] userID;
// user colors
color[] userColor = new color[]{ color(255,0,0), color(0,255,0), color(0,0,255),
                                 color(255,255,0), color(255,0,255), color(0,255,255)};
 
// postion of feet to draw circle
PVector rightFootPosition = new PVector();
PVector leftFootPosition = new PVector();
// turn feet into scalar form
PVector leftFootPosCalibrate = new PVector();
PVector rightFootPosCalibrate = new PVector();
float distanceScalarL;
float distanceScalarR;
// variables used for linear interpolation
float leftLerpX = 0;
float leftLerpY = 0;
float leftLastX = 0;
float leftLastY = 0;
float rightLerpX = 0;
float rightLerpY = 0;
float rightLastX = 0;
float rightLastY = 0;
// diameter of feet drawn in pixels
float feetSize = 200;
 
private PImage startScreen; 
// threshold of level of confidence
float confidenceLevel = 0.5;
// the current confidence level that the kinect is tracking
float confidence;
// vector of tracked head for confidence checking
PVector confidenceVector = new PVector();
 
/*---------------------------------------------------------------
Starts new kinect object and enables skeleton tracking.
Draws window
----------------------------------------------------------------*/
void setup()
{
  // start a new kinect object
  kinect = new SimpleOpenNI(this);
 
  // enable depth sensor
  kinect.enableDepth();
 
  // enable skeleton generation for all joints
  kinect.enableUser();
 
  // draw thickness of drawer
  strokeWeight(3);
  // smooth out drawing
  smooth();
 
  // create a window the size of the depth information
  size(2200, 1000);
  
  startScreen = loadImage("GT_Start-78.png");
   
}
 
/*---------------------------------------------------------------
Updates Kinect. Gets users tracking and draws skeleton and
head if confidence of tracking is above threshold
----------------------------------------------------------------*/
void draw(){
  // update the camera
  kinect.update();
  // get Kinect data
  kinectDepth = kinect.depthImage();
  
   
  // draw depth image at coordinates (0,0)
  image(startScreen, 0, 0, width, height);
  //This was a test....
 
   // get all user IDs of tracked users
  userID = kinect.getUsers();
  
  // loop through each user to see if tracking
  for(int i=0;i<userID.length;i++)
  {
    // if Kinect is tracking certain user then get joint vectors
    if(kinect.isTrackingSkeleton(userID[i]))
    {
      // get confidence level that Kinect is tracking feet
      confidence = (kinect.getJointPositionSkeleton(userID[i],
                          SimpleOpenNI.SKEL_LEFT_FOOT,confidenceVector) + kinect.getJointPositionSkeleton(userID[i],
                          SimpleOpenNI.SKEL_RIGHT_FOOT,confidenceVector)) / 2;      
 
      // if confidence of tracking is beyond threshold, then track user
      if(confidence > confidenceLevel)
      {
        // change draw color based on hand id#
        stroke(userColor[(i)]);
        // fill the ellipse with the same color
        fill(userColor[(i)]);
        // draw the rest of the body
        drawSkeleton(userID[i]);
        //calculate and print x,y coordinates of right and left foot
//        if (mousePressed){
//          println("Left Foot (x,y,z) : (" + leftFootPosition.x + "," + leftFootPosition.y + "," + leftFootPosition.z + ")");
//          println("Right Foot (x,y,z) : (" + rightFootPosition.x + "," + rightFootPosition.y + "," + rightFootPosition.z + ")");
//        }
      }
    }
  }
} 
 
/*---------------------------------------------------------------
Draw the skeleton of a tracked user.  Input is userID
----------------------------------------------------------------*/
void drawSkeleton(int userId){
  // get 3D positions of feet
    kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_FOOT, leftFootPosition);
    kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_FOOT, rightFootPosition);
    // convert real world point to projective space
    kinect.convertRealWorldToProjective(leftFootPosition, leftFootPosition);
    kinect.convertRealWorldToProjective(rightFootPosition, rightFootPosition);
    // create a distance scalar related to the depth in z dimension
    distanceScalarL = (525/leftFootPosition.z);
    distanceScalarR = (525/rightFootPosition.z);
    // draw the circle at the position of the head with the head size scaled by the distance scalar
    leftLerpX = lerp(leftLastX, leftFootPosition.x, 1.0f);
    leftLerpY = lerp(leftLastY, leftFootPosition.y, 1.0f);
    rightLerpX = lerp(rightLastX, rightFootPosition.x, 1.0f);
    rightLerpY = lerp(rightLastY, rightFootPosition.y, 1.0f);
    //covert these ellipse to the thing on the screen...
    // x range feet (40, 580) //range difference = 540
    // y range feet (310, 395) //range difference = 85
    //convert cordinates 500x70 to 2200x100
    //float: x-coordinate of the ellipse, float: y-coordinate of the ellipse
    //float: width of the ellipse by default,  float: height of the ellipse by default
   
    leftFootPosCalibrate.x = width - ((leftLerpX - 40.0) * (width/540.0));
    leftFootPosCalibrate.y = (leftLerpY - 310.0) * (height/85.0);
    leftFootPosCalibrate.z = 0;
    //make sure nothing is neg
    if (leftFootPosCalibrate.x <0){
      leftFootPosCalibrate.x = 0;
    }
    if (leftFootPosCalibrate.y <0){
      leftFootPosCalibrate.x = 0;
    }
    
    rightFootPosCalibrate.x = width - ((rightLerpX - 40.0) * (width/540.0));
    rightFootPosCalibrate.y = (rightLerpY - 310.0) * (height/85.0);
    rightFootPosCalibrate.z = 0;
    //make sure nothing is neg
    if (rightFootPosCalibrate.x <0){
      rightFootPosCalibrate.x = 0;
    }
    if (rightFootPosCalibrate.y <0){
      rightFootPosCalibrate.x = 0;
    }
    
    ellipse(leftFootPosCalibrate.x, leftFootPosCalibrate.y, distanceScalarL*feetSize,distanceScalarL*feetSize);
    ellipse(rightFootPosCalibrate.x, rightFootPosCalibrate.y, distanceScalarR*feetSize,distanceScalarR*feetSize);
    
    if (mousePressed){
      println(leftFootPosition + " ");
      println(rightFootPosition + " ");
    }
    
    
    
    leftLastX = leftLerpX;
    leftLastY = leftLerpY;
    rightLastX = rightLerpX;
    rightLastY = rightLerpY;
}
 
/*---------------------------------------------------------------
When a new user is found, print new user detected along with
userID and start pose detection.  Input is userID
----------------------------------------------------------------*/
void onNewUser(SimpleOpenNI curContext, int userId){
  println("New User Detected - userId: " + userId);
  // start tracking of user id
  curContext.startTrackingSkeleton(userId);
}
 
/*---------------------------------------------------------------
Print when user is lost. Input is int userId of user lost
----------------------------------------------------------------*/
void onLostUser(SimpleOpenNI curContext, int userId){
  // print user lost and user id
  println("User Lost - userId: " + userId);
}
 
/*---------------------------------------------------------------
Called when a user is tracked.
----------------------------------------------------------------*/
void onVisibleUser(SimpleOpenNI curContext, int userId){
}
