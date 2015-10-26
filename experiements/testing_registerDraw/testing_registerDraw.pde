/*  bfLayers Demo
    by blindfish
    www.blindfish.co.uk
    january 2010
     
    An experiment with re-ordering layers when using registerDraw to render objects
    (as opposed to manually calling a display method from the main draw loop).
     
    There may be a better way than the crude approach adopted here (unregistering then
    re-registering in the desired order) but this seems to work well enough and is
    probably suitable when there's a relatively limited number of objects to deal with.
     
    A more streamlined version (no bfLayerManager, or layer hiding) can be found at:
     
    http://www.blindfish.co.uk/code/processing/layers04/
     
    TODO:
    - bfLayerManager needs to be able to handle the addition of layers after
    a layerManager object has been created.
    - optimisation...
*/
 
Body selected;
boolean layerShifted;
PFont font;
 
float friction;
float gravity;
 
int leftBound;
int rightBound;
int topBound;
int bottomBound;
 
int divisions = 5;
int ballRadius;
 
bfLayers layers;
bfLayerManager layerManager;
 
Ball topBall;
Ball bottomBall;
 
void setup() {
  size(500,400);
   
  font = loadFont("arial18.vlw");
  textFont(font);
   
  gravity = 0;
  friction = 0.01;
  leftBound = 0;
  rightBound = 400;
  topBound = 0;
  bottomBound = 400;
   
  layers = new bfLayers(true);
   
  topBall = new Ball(width/2,height/2,30);
  topBall.colour = 200;
  topBall.layerNum = divisions*divisions;
  layers.createTopLayer(topBall);
   
  bottomBall = new Ball(35,height-35,30);
  bottomBall.colour = color(200,0,0);
  bottomBall.layerNum = -1;
  layers.createBottomLayer(bottomBall);
  
  ballRadius = (rightBound-leftBound)/(2*divisions);
  int ballOffset1 = (int)(ballRadius * 1.4);
  int ballOffset2 = (int)((((ballRadius*2)-ballOffset1)*(divisions-1))/2);
  int colourOffset = (int)(255/divisions);
   
  for(int i=0;i<divisions;i++){
    for(int j=0;j<divisions;j++){
      Ball b = new Ball(leftBound+ballOffset2+j*ballOffset1+ballRadius,topBound+ballOffset2+i*ballOffset1+ballRadius,ballRadius);
      int index = i*divisions+j;
      b.colour = color(i*colourOffset,255-j*colourOffset,255-i*colourOffset);
      layers.addLayer(b);
      bfLayer thisLayer = (bfLayer) layers.layers.get(index);
      thisLayer.colour = b.colour;
      b.layerNum = layers.layerPositionFromObject(b);
    }
  }
   
  layerManager = new bfLayerManager(rightBound+1,topBound,width-rightBound-1,height,layers);
 
  smooth();
  frameRate(60);
}
 
void draw() {
  if(layerManager.layerShifted){
    for(int i=0; i<layers.layers.size(); i++){
      bfLayer l = (bfLayer) layers.layers.get(i);
      Ball b = (Ball) l.object;
      b.layerNum = layers.layerPositionFromObject(b);
    }
    layerManager.layerShifted = false;
  }
   
  background(0);
   
  stroke(255);
  noFill();
  line(rightBound,0,rightBound,height);
   
  noStroke();
  fill(255);
  text((int)frameRate,30,15);
   
}
 
void keyPressed() {
  if(key == 's'){
    layers.showHiddenLayers();
  }
  else if(key == 'm'){
    layerManager.hidden = !layerManager.hidden;
    if(layerManager.hidden){
      layerManager.hideLayerManager();
    }
    else {
      layerManager.showLayerManager();
    }
  }
  else if(key =='r'){
    layers.activateAllMouseLayers();
  }
}