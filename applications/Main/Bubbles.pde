/** 

Authors : Sayge Schell & Alvina Yau

Simulates the moving lava background.

**/
/** BUBBLE - stores all information pertaining to each bubble **/
 
class Bubble{
 
  private color couleur;
  private dimmer respiration;
  private dimmer[] radius;
  private float x, y, vX, vY; // (x,y) coordinates for the bubble's center
  private float[] angles; 
  private int n; // Number of points to draw a bubble
  private int frameLife = 800; // Keeps track of memory
  private int bubbleNum; // Unique number to keep track of where this bubble will be in the main bubbles array
  private float[][] curves_x = new float[frameLife][]; //keeps track of x curves at a given time
  private float[][] curves_y = new float[frameLife][]; // keeps track of y curves at a given time
  private int curr_frame = 1; //stores current frame count
  
  /* Creates a new bubble */
  Bubble(float ix, float ig, int num){
    //Save given variables
    x = ix;
    y = ig;
    bubbleNum = num;
    curr_frame = 1;
    
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
    float raydebase = random(10, 150);
    respiration = new dimmer(-5.5, 5.5, 200,random(360));
    
    //Set speed of bubble center movement. Bubble center is at (x, y). vY is speed in y-direction. vX is speed in x-direction.
    vY =- random(100 - raydebase)*0.2;
    vX = random(-0.1,0.1);

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
  
  /* Sets the current frame.*/
  void setFrame(int count){
    curr_frame = count;
  }
  
 /*Retrieves the current frame.*/
 int getFrame(){
   return curr_frame;
 }
  /*Saves and updates the coordinates*/
  void update(){
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
      //beginShape();
      //fill(getColor()); 
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
      if(nothing==true){
        y= (height + 20) ;
        x=random(-20, (width + 20));
      }
      //Set the bubble's curve data for this frame
      setCurves(memory_curvesX, memory_curvesY, getFrame() - 1);
   }
   
 }

