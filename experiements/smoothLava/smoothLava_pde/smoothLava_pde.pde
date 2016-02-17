/* Sayge Schell

Modified code to create infinitely looping lava that does not overlap.
This runs an editable # of seconds of randomizations from Perlin noise and
then loops them backwards. This is so we can control the  motion of the lava
and make sure it does not overlap.

*/

/* VARIABLE DECLARATIONS */
final float speed = 1.5; // determines speed of animation
final float variation = 10; // determines amount of variation in noise
final float offset = 1;
final int frame_life = 180; // stores how many frames we want to record for the looping
float[] coords = {120,350, 270,220, 450,120, 560,200, 490,260, 380,230, 230,360};
float generation = 0;
float noiseFactor = 0; // stores the noise factor
float toAdd = 0; // stores the noised noiseFactor times the speed
int index = (frame_life - 1); // stores the index we are currently at in the memory array
boolean increment = false; // stores whether we are incrementing or decrementing our index
float[][] memory = new float[frame_life][coords.length]; //declare an array that holds all memory coords of size 180

//Setup
void setup() {
  size(720, 480);
  background(255);
  smooth();
  stroke(0);
  fill(127);
}


void draw() {
  /* RECORDING PORTION */
  //If frameCount <= frame_life, generate noise and store all coords in array. Store coords for each frame.
  if (frameCount <= frame_life){
    //Set noise
    noiseDetail(6);
    noiseSeed(13);
    //Increase variation every second
    if(frameCount % 60 == 0) {
      generation += variation;
    }
    //Modify and store each coordinate
    for(int i = 0; i < coords.length; i++){
      noiseFactor = generation + offset * i;
      toAdd = ( noise(noiseFactor) -0.5 ) * speed;
      coords[i] += toAdd;
      memory[frameCount - 1][i] = coords[i];
    }
   }
   
   /* RUNNING FROM MEMORY PORTION */
   //If frameCount > frame_life, begin from memory
   else if (frameCount > frame_life){
     for(int i = 0; i < coords.length; i++){
       coords[i] = memory[index][i];
     } 
     //Now iterate backwards or forwards through
     // On multiples of frame_life, switch between traversing all forward and all backwards
     if (!increment && index > 0){
      index -= 1;
     }
     else if (increment && index < 179){
       index += 1;
     }
     //If index is currently 0, start incrementing
     if (index == 0){
       increment = true;
     }
      //Otherwise if at frame_life -1, decrement
     else if (index == (frame_life - 1)){
       increment = false;
     } 
   }
  
  background(255);
  
  beginShape();
  curveVertex(coords[coords.length-2], coords[coords.length-1]); //start control point same as second to last
  curveVertex(coords[ 0], coords[ 1]);
  curveVertex(coords[ 2], coords[ 3]);
  curveVertex(coords[ 4], coords[ 5]);
  curveVertex(coords[ 6], coords[ 7]);
  curveVertex(coords[ 8], coords[ 9]);
  curveVertex(coords[10], coords[11]);
  curveVertex(coords[12], coords[13]);
  curveVertex(coords[ 0], coords[ 1]);
  curveVertex(coords[ 2], coords[ 3]); //end control point same as second from first
  endShape();
}
