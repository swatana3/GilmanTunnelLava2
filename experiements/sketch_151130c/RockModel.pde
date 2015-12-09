class RockModel{ 
 boolean movingRock = false;

//now i need to make the velocity and elliptical movement
//don't check for collision yet...

// center point of ellipse
  int cX, cY;
  // velocity of this rock - don't know if this is how it should be done yet?
  float posX, posY;
  
  //you can change velocity
  float vel;
  
  //incrementally changing elliptical angle
  float theta;
  
  //radius of ellipse, it can be set later
  float radiusX, radiusY;
 
  RockModel(int cX, int cY) {
    this.cX = cX;
    this.cY = cY;
    
    this.vel = 100;
   
   //this.multiFactor = 0;  
    
    // can change the velocity later by changing theta increase
    
    //currrently setting radius manually
    radiusX = 50;
    radiusY = 100;
    
    //angle of ellipse
    this.theta =0; 

  }
  void updateVelocity() {
      this.theta += 0.01;
      println("theta is" + theta);
      posX = radiusX * cos( theta );
      posY = radiusY * sin( theta );
      translate( cX, cY );
      ellipseMode(RADIUS);  // Set ellipseMode to RADIUS
      fill(255);  // Set fill to white
      ellipse( posX, posY, 5, 5 );
      
      if (theta > TWO_PI){
        theta = 0;   
      }
    }
}
