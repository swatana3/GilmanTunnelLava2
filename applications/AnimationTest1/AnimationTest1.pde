Lava L1;

void setup(){
  size(900, 480);
  frameRate(60);
  
  PShape layer1 = loadShape("../../assets/lavaDetail1/layer1.svg"); //must go up an extra directory because the default location is AnimationTest1/data
  PShape layer2 = loadShape("../../assets/lavaDetail1/layer2.svg");
  PShape layer3 = loadShape("../../assets/lavaDetail1/layer3.svg");
  L1 = new Lava(layer1, layer2, layer3);
  //L1.ay = -0.4;
  L1.vy = -2; //try setting to -3 and messing around with amplitude and period!
  L1.amplitude = 2;
  L1.period = 3;
}

void draw(){
  background(255); //reset frame
   //<>//
  L1.draw();
  
  if(L1.y < 0){
    L1.y = height;
    //L1.vy = 0; //reset animation instead of looping effect like Portal
  }
}