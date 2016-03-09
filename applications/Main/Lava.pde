/** 

Authors : Sayge Schell & Alvina Yau

Simulates the moving lava background.

**/

class Lava {
  
/** Global Variables - to be used across all classes **/
private final int numBubbles  = 250; // Sets the number of bubbles to appear on the screen
private final int frameLife = 800; //Indicates how large the memory is in frames; 60 frames = 1 second
Bubble[] bubbles = new Bubble[numBubbles]; // Holds the bubble objects
private int frameCounter = 1; //Keeps track of frames
 
/** SETUP/MAIN CLASS - sets up our background and our initial bubbles **/

Lava(){
 frameCounter = 1;
 println("Lava created");
 // Give each bubble its beginning x,y coordinates
 for (int a = 0 ; a < bubbles.length; a++){
   bubbles[a] = new Bubble(random(-10,610),random(-10,410), a);
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

//void update(){
  //println(frameCounter);
  /* Recording portion */
 // if (frameCounter <= frameLife) {
   // for(Bubble bubble : bubbles){
      //Draw the bubble; After this runs, the curves should be saved
      //set the frameCounter
     /* bubble.setFrame(frameCounter);
      println("frame set");
      bubble.update();
    }
    frameCounter++;
  }*/
  
  /* Running from memory portion */ 
  //else if (frameCounter > frameLife) {
    //Get the curves of the bubble from memory and draw them
    /*for (int a = 0; a < bubbles.length; a++){
      //Get x,y vertices for the specific time indicated
      float[] tempX = bubbles[a].getCurvesX(index);
      float[] tempY = bubbles[a].getCurvesY(index);
     
      //Draw the curves from memory     
      beginShape();
      fill(bubbles[a].getColor());
      //Draw each x,y curve
      for (int i = 0; i < (bubbles[a].getNumPoints() + 3); i++){
        curveVertex(tempX[i], tempY[i]);
      }
      endShape(CLOSE);
    }
    //Increment or decrement our index
    if (!increment && index > 0){
      index -= 1;
    }
    else if (increment && index < frameLife - 1){
      index += 1;
    }
    //If index is currently 0, start incrementing
    if (index == 0){
      increment = true;
    }
    //Otherwise if at frameLife -1, decrement
    else if (index == (frameLife - 1)){
      increment = false;
    }
 } */
      
//}
}
