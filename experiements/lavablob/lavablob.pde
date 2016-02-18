bubble[] bubbles;
 
void setup(){
 size(500,500);
 smooth();
 stroke(255,100);
 //strokeWeight(1);
 noFill();
 bubbles=new bubble[10];
 for(int a=0;a<10;a++){
 bubbles[a]=new bubble(random(-10,510),random(-10,600));
 }
}
 
void draw(){
  background(255, 92, 30);

  //stroke(255,100);
  noStroke();
  for(int a=0;a<bubbles.length;a++){
    bubbles[a].draw();
  }
}
 
class dimmer{
  float mini, vitesse, angle, val, diff;
  dimmer(float mini1, float maxi1, float etapes, float depart){
    val=mini; angle=depart;mini=mini1;diff=maxi1-mini1;
    vitesse=360.0/etapes;
  }
  void advance(){
    angle+=vitesse;
    float rad = (cos(angle/(180.0/PI))+1)/2;
    val= mini+rad*diff; 
  }
}
 
class bubble{
  float x, y, vX, vY;float[] angles;dimmer[] radius;int n;color couleur;
  dimmer respiration;
  bubble(float ix, float ig){
    //couleur=color(random(230,255),random(130,230),0,100);
    couleur=color(random(230,255),random(150,160),0,100);
    x=ix;y=ig;
    n= floor(random(8,20));
    float depart=random(90);
    angles=new float[n];
    radius=new dimmer[n];
    float dec = 360.0/n;
    float raydebase = random(20,100);
    vY=-random(100-raydebase)*0.01;
    vX=random(-0.03,0.03);
     respiration=new dimmer(-5.5,5.5,200,random(360));
   //  minray=raydebase*0.1; maxray=minray+raydebase*0.1;
    for(int a=0;a<n;a++){
      angles[a]= (a*dec)/(180.0/PI);
      radius[a]=new dimmer(raydebase+random(raydebase/17),raydebase+ random(raydebase/30,raydebase/20),random(120,160),random(360));
    }
  }
  void draw(){
  float fx=0, fy=0, fx2=0, fy2=0, fx3=0, fy3=0;
  y+=respiration.val*0.05;
  y+=vY;boolean nothing=true;
  respiration.advance();
  x+=random(-0.4,0.4)+vX;
  beginShape();
    fill(couleur);
    //fill(255, 120, 40);
    float plus=random(-0.01,0.01);
    for(int a=0;a<n;a++){
      angles[a]+=plus;
      radius[a].advance();
      float rad=angles[a] ;
      float ix=cos(rad)*(radius[a].val+respiration.val);
      float ig=sin(rad)*(radius[a].val-respiration.val);
      curveVertex(x+ix,y+ig);
      if((y+ig)>0){nothing=false;}
      if(a==0){
          fx = x+ix;
         fy = y+ig;
      }
      if(a==1){
          fx2 = x+ix;
         fy2 = y+ig;
      }
      if(a==2){
          fx3 = x+ix;
         fy3 = y+ig;
      }
    }
    curveVertex(fx,fy);
    curveVertex(fx2,fy2);
    curveVertex(fx3,fy3);
    endShape(CLOSE);
    if(nothing==true){
      y=700 ;
      x=random(-20,520);
    }
  }
   
   
}
 


 