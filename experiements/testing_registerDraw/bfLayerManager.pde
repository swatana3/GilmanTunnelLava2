/*  bfLayerManager class
    by blindfish
    www.blindfish.co.uk
    january 2010
     
    Draws a grid of layers, including controls to re-order and hide/show layers.
     
    - Added methods to hide and show layerIcons
     
    TODO: Deal with addition of layers to managedLayers after a bfLayerManager has been created...
     
*/
 
public class bfLayerManager {
  int x;
  int y;
  int w;
  int h;
  float rowHeight;
  bfLayerIcon selectedIcon;
  bfLayers managedLayers;
  bfLayers layerIcons;  // We need to bring an icon to the front when it's clicked, so an excuse to use bfLayers :)
  boolean hidden;
  // Need to look into setting up some form of event notification
  // temporary workaround
  boolean layerShifted;
   
  bfLayerManager(int x, int y, int w, int h, bfLayers managedLayers){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.managedLayers = managedLayers;
    this.layerIcons = new bfLayers(true);
    this.rowHeight = (h/managedLayers.registeredLayerCount())-1;
    for (int i=0; i<managedLayers.registeredLayerCount(); i++){
      bfLayerIcon icon = new bfLayerIcon(h-(i*(rowHeight+1))-rowHeight-1, i, this);
      layerIcons.addLayer(icon);
    }
  }
   
  // This is all well and good - but it might make more sense if the layer manager opened in a separate window
  void hideLayerManager() {
    for (int i=0; i<layerIcons.layers.size(); i++){
      bfLayer icon = (bfLayer) layerIcons.layers.get(i);
      icon.stopped = true;
      layerIcons.updateLayerOrder();
    }
  }
   
  void showLayerManager() {
    for (int i=0; i<layerIcons.layers.size(); i++){
      bfLayer icon = (bfLayer) layerIcons.layers.get(i);
      icon.stopped = false;
      layerIcons.updateLayerOrder();
    }
  }
   
}