Lava L1;

void setup(){
  size(900, 480);
  frameRate(60);
  
  PShape lavaDetail1 = loadShape("../../assets/lavaDetail1.svg"); //must go up an extra directory because the default location is AnimationTest1/data
  PShape layer1 = lavaDetail1.getChild("top");
  PShape layer2 = lavaDetail1.getChild("middle");
  PShape layer3 = lavaDetail1.getChild("bottom");
  L1 = new Lava(layer1, layer2, layer3);
  //L1.ay = -0.4;
  L1.vx = -2; //try setting to -3 and messing around with amplitude and period!
  L1.ampY = 2;
  L1.perY = 3;
  L1.ampS = 0.02;
  L1.perS = 5;
}

void draw(){
  background(255); //reset frame
   //<>//
  L1.draw();
  
  if(L1.x < 0){
    L1.x = width;
    //L1.vy = 0; //reset animation instead of looping effect like Portal
  }
}