Lava L1;
PShape layer1;
PShape layer2;
PShape layer3;

void setup(){
  size(900, 480);
  frameRate(60);
  
  layer1 = loadShape("../../assets/lavaDetail1/layer1.svg"); //must go up an extra directory because the default location is AnimationTest1/data
  layer2 = loadShape("../../assets/lavaDetail1/layer2.svg");
  layer3 = loadShape("../../assets/lavaDetail1/layer3.svg");
  L1 = new Lava(layer1, layer2, layer3);
  L1.ay = -0.4; 
}

void draw(){
  background(255); //reset frame
   //<>//
  L1.draw();
  
  if(L1.y < 0){
    L1.y = height;
    L1.vy = 0; //reset animation instead of looping effect like Portal
  }
}