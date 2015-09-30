Lava L1;
PShape layer1;
PShape layer2;
PShape layer3;
float speed;

 void setup(){
  size(900, 480);
  smooth();
  
  //println(dataPath("")); //~/GilmanTunnelLava/applications/AnimationTest1/data
  layer1 = loadShape("../../assets/lavaDetail1/layer1.svg"); //must go up an extra directory because the default location is AnimationTest1/data
  layer2 = loadShape("../../assets/lavaDetail1/layer2.svg");
  layer3 = loadShape("../../assets/lavaDetail1/layer3.svg");
  L1 = new Lava(layer1, layer2, layer3);
  speed = 0.5; 
  frameRate(4);
 }
 
 void draw(){
   L1.display();
   speed = speed + 1.5;
   if (speed>2){
     speed = 0.5; 
   }
   println(speed); 
   L1.moveLayers(speed,speed,speed);
   //L1.display(); 
    println("frameCount is"+frameCount);
 }