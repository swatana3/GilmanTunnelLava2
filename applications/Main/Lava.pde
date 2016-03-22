/** 

Authors : Sayge Schell & Alvina Yau

Simulates the moving lava background.

**/

class Lava {
  
/** Global Variables - to be used across all classes **/
private int numBubbles  = 500; // Sets the number of bubbles to appear on the screen
private final int frameLife = 800; //Indicates how large the memory is in frames; 60 frames = 1 second
Bubble[] bubbles = new Bubble[numBubbles]; // Holds the bubble objects
private int frameCounter = 1; //Keeps track of frames

Lava(){
 frameCounter = 1;
 println("Lava created");
 // Give each bubble its beginning x,y coordinates
 for (int a = 0 ; a < bubbles.length; a++){
   bubbles[a] = new Bubble(random(-60,660),random(-60, 460), a);
 }
 for (int i = 1; i <= frameLife; i++){
   for (Bubble bubble : bubbles){
     bubble.setFrame(i);
     bubble.update();
   }
 }
 println(bubbles.length);
}

Lava(int num){
 if (num > 500) {
   num = 500;
 }
 numBubbles = num;
 Bubble[] bubbles = new Bubble[numBubbles];
 frameCounter = 1;
 println("Lava created");
 // Give each bubble its beginning x,y coordinates
 for (int a = 0 ; a < bubbles.length; a++){
   bubbles[a] = new Bubble(random(-60,660),random(-60, 460), a);
 }
 for (int i = 1; i <= frameLife; i++){
   for (Bubble bubble : bubbles){
     bubble.setFrame(i);
     bubble.update();
   }
 }
 println(bubbles.length);
}

Bubble[] getBubbles(){
  return bubbles;
}

void resetCounter(){
  frameCounter = 0;
}

int getCounter(){
  return frameCounter;
}
}
