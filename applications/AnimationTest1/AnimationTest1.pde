Lava L1;
PShape layer1;
PShape layer2;
PShape layer3;
float speed; //what exactly does this variable represent?

void setup(){
  size(900, 480);
  //smooth(); //set by default, not required in Processing 3
  frameRate(4);
  
  //println(dataPath("")); //~/GilmanTunnelLava/applications/AnimationTest1/data
  layer1 = loadShape("../../assets/lavaDetail1/layer1.svg"); //must go up an extra directory because the default location is AnimationTest1/data
  layer2 = loadShape("../../assets/lavaDetail1/layer2.svg");
  layer3 = loadShape("../../assets/lavaDetail1/layer3.svg");
  L1 = new Lava(layer1, layer2, layer3);
  
  speed = 0.5; 
}

void draw(){
  //println("frameCount is "+frameCount); //instead of using a print statement, use the debugger and  create a breakpoint on ths line to track frameCount
  background(255); //reset frame
  
  //this alternated speed between 0.5 and 2, is this intensional?
  speed = speed + 1.5; //<>//
  if (speed>2){
    speed = 0.5;
  }
  //println("speed is "+speed); //instead of using a print statement, use the debugger and  create a breakpoint on ths line to track speed
  
  L1.setScale(speed); //transform, then draw
  L1.draw();
}