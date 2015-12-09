/*  bfLayer
    by blindfish
    www.blindfish.co.uk
    january 2010
     
   A convenience class for property storage of each individual layer, independent of the
   object stored in the layer.
   Avoids using multi-dimensional arrays (though these may be a quicker option in terms of performance?)
     
*/
 
class bfLayer {
  Object object;
  String name;      // could be used by bfLayerManager
  boolean stopped;  // i.e. hidden; though stopped is more accurate since when stopped the layer's draw loop is not run
  boolean mouseLocked;  // Changing the mouse order is useful, but there are times when you want to handle a lower layer without changing the draw order
  color colour;     // Again thinking more of bfLayerManager
   
  bfLayer(Object object){
    this.object = object;
    this.name = "";
  }
   
   
   
}