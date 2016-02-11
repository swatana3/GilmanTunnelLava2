/* Sayge Schell

Modified code to create infinitely looping lava that does not overlap.
This runs an editable # of seconds of randomizations from Perlin noise and
then loops them backwards. This is so we can control the  motion of the lava
and make sure it does not overlap.

*/

//Setup
void setup() {
  size(720, 480);
  background(255);
  smooth();
  stroke(0);
  fill(127);
}

float generation = 0;
final float speed = 1.5;
final float variation = 10;
final float offset = 1;
float noiseFactor = 0;

float[] coords = {120,350, 270,220, 450,120, 560,200, 490,260, 380,230, 230,360};
boolean reversed = false;
float toAdd = 0;
int index = 179;
boolean increment = false;
float[][] memory = new float[180][coords.length];
//declare an array that holds all memory coords of size 180

void draw() {
  
   //SET UP PORTION
  //If frameCount <= 180, generate noise and store all coords in array. Store coords for each frame.
  if (frameCount <= 180){
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
   //RUNNING FROM MEMORY PORTION
   //If frameCount > 180, begin from memory
   else if (frameCount > 180){
     for(int i = 0; i < coords.length; i++){
       coords[i] = memory[index][i];
     } 
     //Now iterate backwards or forwards through
     // On multiples of 180, switch between traversing all forward and all backwards
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
      //Otherwise if at 179, decrement
     else if (index == 179){
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
