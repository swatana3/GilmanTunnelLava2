/** 

Authors : Sayge Schell & Alvina Yau

Simulates the moving lava background.

**/

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
