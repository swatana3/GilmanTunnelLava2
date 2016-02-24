/** 

Authors : Sayge Schell & Alvina Yau

Simulates the moving lava background.

**/

/** Global Variables - to be used across all classes **/
final int numBubbles  = 115; // Sets the number of bubbles to appear on the screen
final int frameLife = 600; //Indicates how large the memory is in frames; 60 frames = 1 second
bubble[] bubbles = new bubble[numBubbles]; // Holds the bubble objects
int index = frameLife - 1; // stores the current index of the memory array
boolean increment = false; // Indicates whether we are incrementing or decrementing our index when running from memory
 
/** SETUP/MAIN CLASS - sets up our background and our initial bubbles **/

void setup(){
 size(500,500);
 smooth();
 stroke(255,100);
 noFill();
 
 // Give each bubble its beginning x,y coordinates
 for (int a = 0 ; a < bubbles.length; a++){
   bubbles[a] = new bubble(random(-10,510),random(-10,600), a);
 }
}

void draw(){
  background(255, 92, 30);
  noStroke();
  
  /* Recording portion */
  if (frameCount <= frameLife) {
    for(int a = 0; a < bubbles.length; a++){
      //Draw the bubble; After this runs, the curves should be saved
      bubbles[a].draw();
    }
  }
  
  /* Running from memory portion */ 
  else if (frameCount > frameLife) {
    //Get the curves of the bubble from memory and draw them
    for (int a = 0; a < bubbles.length; a++){
      //Get x,y vertices for the specific time indicated
      float[] tempX = bubbles[a].getCurvesX(index);
      float[] tempY = bubbles[a].getCurvesY(index);
     
      //Draw the curves from memory     
      beginShape();
      fill(bubbles[a].getColor());
      //Draw each x,y curve
      for (int i = 0; i < (bubbles[a].getNumPoints() + 3); i++){
        curveVertex(tempX[i], tempY[i]);
      }
      endShape(CLOSE);
    }
    //Increment or decrement our index
    if (!increment && index > 0){
      index -= 1;
    }
    else if (increment && index < frameLife - 1){
      index += 1;
    }
    //If index is currently 0, start incrementing
    if (index == 0){
      increment = true;
    }
    //Otherwise if at frameLife -1, decrement
    else if (index == (frameLife - 1)){
      increment = false;
    }
 }
       
}
 
/** DIMMER **/

class dimmer{
  private float mini, vitesse, angle, val, diff;
  
  dimmer(float mini1, float maxi1, float etapes, float depart){
    val = mini;
    angle = depart;
    mini = mini1;
    diff = maxi1-mini1;
    vitesse = 360.0/etapes;
  }
  
  void advance(){
    angle += vitesse;
    float rad = (cos(angle/(180.0/PI)) + 1)/2;
    val= mini + rad*diff; 
  }
  
  float getValue(){
    return val;
  }
  
  float getMini(){
    return mini;
  }
  
  float getVitesse(){
    return vitesse;
  }
  
   float getAngle(){
    return angle;
  }
  
   float getDiff(){
    return diff;
  }
  
}

/** BUBBLE - stores all information pertaining to each bubble **/
 
class bubble{
 
  private color couleur;
  private dimmer respiration;
  private dimmer[] radius;
  private float x, y, vX, vY; // (x,y) coordinates for the bubble's center
  private float[] angles; 
  private int n; // Number of points to draw a bubble
  private int bubbleNum; // Unique number to keep track of where this bubble will be in the main bubbles array
  private float[][] curves_x = new float[frameLife][]; //keeps track of x curves at a given time
  private float[][] curves_y = new float[frameLife][]; // keeps track of y curves at a given time
  
  /* Creates a new bubble */
  bubble(float ix, float ig, int num){
    //Save given variables
    x = ix;
    y = ig;
    bubbleNum = num;
    
    //Calculate random variable
    float rand = random(0, 11);
    if (rand < 10) { 
      couleur = color(random(230, 355), random(75, 200), random(0, 30), 100); //Randomly set color
    }
    else {
      couleur = color(255, 92, 30, 100);
    }
    n = floor(random(8, 20)); //Randomly set number of points to draw bubble
    float depart = random(90);
    angles = new float[n];
    radius = new dimmer[n];
    float degree = 360.0/n;
    float raydebase = random(20, 100);
    respiration = new dimmer(-5.5, 5.5, 200,random(360));
    
    //Set speed of bubble center movement. Bubble center is at (x, y). vY is speed in y-direction. vX is speed in x-direction.
    vY =- random(100 - raydebase)*0.012;
    vX = random(-0.03,0.03);

    // Initialize each point with its initial angle and radius. Center of bubble is at (x, y).
    for ( int a = 0; a < n; a++){
      // Convert degree to radian
      angles[a]= (a*degree)/(180.0/PI);
      radius[a]=new dimmer(raydebase + random(raydebase/17), raydebase + random(raydebase/30, raydebase/20), random(120, 160), random(360));
    }
  }
  
  /* Takes in a time and a list of x coords and y coords.
     Saves the x,y coords for this time to the bubble. */
  void setCurves(float[] listx, float[] listy, int time){
    curves_x[time] = listx;
    curves_y[time] = listy;
  }
  
  /* Returns the x coords for a given time. */
  float[] getCurvesX(int time){
    return curves_x[time];
  }
  
  /* Returns the y coords for a given time. */
  float[] getCurvesY(int time){
    return curves_y[time];
  }
  
  /* Returns the number of points. */
  int getNumPoints(){
    return n;
  }
  
  /* Returns the bubble's color. */
  color getColor(){
    return couleur;
  }
  
  /* Returns the bubble's radius. */
  dimmer[] getRadius(){
    return radius;
  }
  
  /* Returns the bubble's angles */
  float[] getAngles(){
    return angles;
  }
  
  /* Returns the respiration. */
  dimmer getRespiration(){
    return respiration;
  }
  
  void draw(){
    float fx = 0, fy = 0, fx2 = 0, fy2 = 0, fx3 = 0, fy3 = 0; //Set all coordinates to 0 initially.
    float[] memory_curvesX = new float[getNumPoints() + 3]; //Stores the x coords of curves we will need to draw from memory
    float[] memory_curvesY = new float[getNumPoints() + 3]; //Stores the y coords of curves we will need to draw from memory
    
     // Move bubble center in y-direction. Move by a fixed quantity (vY) and a random quantity (respiration.val*0.05). 
     y += respiration.val*0.05 + vY;
     respiration.advance();    // Change respiration to the next pre-defined value so that it is different in the next draw
     // Move bubble center in x-direction. Move by a fixed quantity (vX) and a random quantity (random(-0.4,0.4).
     x += random(-0.4, 0.4)+vX;

    //Draw the shape
    boolean nothing=true;
      beginShape();
      fill(getColor());
      float plus = random(-0.01, 0.01);
      for (int a = 0; a < getNumPoints(); a++){
        getAngles()[a] += plus;  // Change angle a little bit
        getRadius()[a].advance();  // Change radius to the next pre-defined value
        float rad = angles[a] ;
      
        // Using the new radius and angle, get the x and y coordinates relative to the bubble center (x, y)
        float ix = cos(rad)*(radius[a].getValue() + getRespiration().getValue());
        float ig = sin(rad)*(radius[a].getValue() - getRespiration().getValue());
        //Save the x and y coordinates of the curve so we can save it to memory for this bubble
        memory_curvesX[a] = x + ix;
        memory_curvesY[a] = y + ig;
        
        curveVertex(x+ix,y+ig);    // Connect this point and the previous point with a curve
        if((y+ig)>0){nothing=false;}      
        // Save coordinates of the first 3 points of the bubble because need to re-curve them after all points have been curved.
        // This is required by the curveVertex implementation of Catmull-Rom splines.
        // This loop curves all the points. Outside the loop, the first 3 points are re-curved.
        if (a == 0){
           fx = x+ix;
           fy = y+ig;
        }
        else if (a == 1){
          fx2 = x+ix;
          fy2 = y+ig;
        }
        else if (a == 2){
          fx3 = x+ix;
          fy3 = y+ig;
        }
      }
      //Store the rest of the (x,y) coords for the curve data
      memory_curvesX[n] = fx;
      memory_curvesY[n] = fy;
      memory_curvesX[n+1] = fx2;
      memory_curvesY[n+1] = fy2;
      memory_curvesX[n+2] = fx3;
      memory_curvesY[n+2] = fy3;
      //Draw the curves
      curveVertex(fx,fy);
      curveVertex(fx2,fy2);
      curveVertex(fx3,fy3);
      endShape(CLOSE);
      if(nothing==true){
        y=700 ;
        x=random(-20,520);
      }
      //Set the bubble's curve data for this frame
      setCurves(memory_curvesX, memory_curvesY, frameCount - 1);
   }
   
 }

