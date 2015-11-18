import gifAnimation.*;

Gif myAnimation;
//testing how PImages would work
void setup(){
  loop(); 
  size(600,400);
  myAnimation = new Gif(this, "../../assets/Lava_Animation_AE_shorter.gif");
  PImage[] allFrames = myAnimation.getPImages();
  println(allFrames.length);
  myAnimation.loop();
  
}
void draw(){
  image(myAnimation, 0,0, width,height);
}
