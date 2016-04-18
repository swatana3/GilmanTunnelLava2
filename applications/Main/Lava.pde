/** 

Authors : Sayge Schell & Alvina Yau

Simulates the moving lava background.

**/

class Lava {
  
/** Global Variables - to be used across all classes **/
private final int numBubbles  = 800; // Sets the number of bubbles to appear on the screen
private final int frameLife = 800; //Indicates how large the memory is in frames; 60 frames = 1 second
private Bubble[] bubbles = new Bubble[numBubbles]; // Holds the bubble objects
private int frameCounter = 1; //Keeps track of frames

/* Creates the lava object. */
Lava(){
 frameCounter = 1;
 // Give each bubble its beginning x,y coordinates
 for (int a = 0 ; a < bubbles.length; a++){
   bubbles[a] = new Bubble(random(-60, (width +60)),random(-60, (height + 60)), a);
 }
 for (int i = 1; i <= frameLife; i++){
   for (Bubble bubble : bubbles){
     bubble.setFrame(i);
     bubble.update();
   }
 }
}

/*Returns the array of bubble objects*/
Bubble[] getBubbles(){
  return bubbles;
}

/*Resets the frame counter to zero. */
void resetCounter(){
  frameCounter = 0;
}

/*Returns the current count of the frame counter.*/
int getCounter(){
  return frameCounter;
}

}
