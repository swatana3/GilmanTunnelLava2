/*  bfLayers class
    by blindfish
    www.blindfish.co.uk
    january 2010
     
    Usage:
    Instantiate a bfLayers object and add objects that need to be sorted
    on layers using the appropriate addLayer_() method.  If you want mouseEvents
    to be ordered along with layers then use the overloaded constructor passing true
    as a parameter: i.e. bfLayer foo = new bfLayer(true);
     
    You can then call sorting methods as required to re-order the layers....
     
    - Added removeLayer() method
    - Added top and bottom Layers.  These layers will always be top and bottom regardless
      of the order of the remaining layers.  Useful, for example if you want to overlay a
      'HUD' that is always drawn over the layers.  bottomLayer is perhaps less useful, except
      when it needs to be above anything drawn in the main draw() loop but at the bottom of the
      bfLayer stack.  Note that only a single top and a single bottom layer can be added.  If
      multiple objects need to be rendered in these layers you'd need to rely on calling a 'display method'
      for each of these objects from the added topLayer object.
    - Added a method to lock all mouseLayers except a single selected layer:
      void setAsOnlyActiveMouseLayer(Object object, boolean deactivateSpecialLayers)
      'object' is the layer that will remain active. Set 'deactivateSpecialLayers' to true to also switch
      mouseEvents off for top and bottom layers (I figured this may not always be desired).
     
*/
 
public class bfLayers {
   
  ArrayList layers;
  ArrayList registeredObjects;
   
  boolean doRegisterMouse;
  boolean reRegisterMouse;
   
  bfLayer topLayer;
  bfLayer bottomLayer;
   
  bfLayers() {
    layers = new ArrayList();
    registeredObjects = new ArrayList();
    registerPost(this);
  }
   
  bfLayers(boolean doRegisterMouse) {
      layers = new ArrayList();
      registeredObjects = new ArrayList();
      this.doRegisterMouse = doRegisterMouse;
      registerPost(this);
  }
   
  void addLayer(Object object){
    layers.add(new bfLayer(object));
    updateLayerOrder();
  }
   
  void addLayersFromArray(Object[] objects) {
    for(int i=0; i<objects.length; i++) {
      layers.add(new bfLayer(objects[i]));
    }
    updateLayerOrder();
  }
   
  void addLayersFromArrayList(ArrayList objects) {
    for(int i=0; i<objects.size(); i++) {
      Object thisObject = (Object) objects.get(i);
      layers.add(new bfLayer(thisObject));
    }
    updateLayerOrder();
  }
   
    void removeLayer(Object object) {
    int index = registeredObjects.indexOf(object);
    bfLayer thisLayer = (bfLayer) layers.get(index);
     
    unregisterDraw(object);
    if(doRegisterMouse){
      unregisterMouseEvent(object);
    }
     
    layers.remove(thisLayer);
    registeredObjects.remove(object);
    updateLayerOrder();
  }
   
  void updateLayerOrder() {
    unregisterObjects();
    registerObjects();
    if(doRegisterMouse){
      reRegisterMouse = true;
    }
  }
   
  // - - - - - REPORT ON LAYERS - - - - - //
  int layerPositionFromObject(Object object){
    int pos;
    if(registeredObjects.contains(object)){
      pos = registeredObjects.indexOf(object);
    }
    else {
      pos = -1;
    }
    return pos;
  }
   
  int layerPositionFromLayer(bfLayer layer){
    int pos;
    if(layers.contains(layer)){
      pos = layers.indexOf(layer);
    }
    else {
      pos = -1;
    }
    return pos;
  }
   
  int registeredLayerCount(){
    return layers.size();
  }
   
  // - - - - - MISC - - - - - //
  void hideLayer(Object object){
    if(registeredObjects.contains(object)){
      bfLayer thisLayer = getLayerFromObject(object);
      thisLayer.stopped = true;
      unregisterDraw(object);
      if(doRegisterMouse){
        unregisterMouseEvent(object);
      }
    }
  }
   
  void showLayer(Object object){
    if(registeredObjects.contains(object)){
      bfLayer thisLayer = getLayerFromObject(object);
      thisLayer.stopped = false;
      updateLayerOrder();
    }
  }
   
  void showHiddenLayers() {
    for(int i=0; i<registeredObjects.size(); i++){
      bfLayer thisLayer = getLayerFromObject(registeredObjects.get(i));
      thisLayer.stopped = false;
    }
    updateLayerOrder();
  }
   
  bfLayer getLayerFromObject(Object object) {
    int index = registeredObjects.indexOf(object);
    return (bfLayer) layers.get(index);
  }
   
  void createTopLayer(Object object) {
    if(topLayer == null){
      topLayer = new bfLayer(object);
    }
    else {
      println("WARNING (bfLayers): You have attempted to add multiple top layers\nOnly one is permitted.");
      // TODO: throw an exception?
      /* Whilst this may make things more robust it also adds the requirement of a try/catch
      statement when adding a top/bottom Layer.  I don't think the issue is serious enough to
      warrant this: the layer simply won't be added as a top/bottom layer and this will quickly
      become apparent when running the programme */
    }
  }
   
  void createBottomLayer(Object object) {
    if(bottomLayer == null){
      bottomLayer = new bfLayer(object);
    }
    else {
      println("WARNING (bfLayers): You have attempted to add multiple bottom layers\nOnly one is permitted.");
    }
  }
   
  // - - - - - SHIFT LAYER ORDER - - - - - //
  void bringToFront(Object object) {
    if(registeredObjects.contains(object)){
      unregisterObjects();
      int index = registeredObjects.indexOf(object);
      bfLayer thisLayer = (bfLayer) layers.get(index);
      layers.remove(index);
      layers.add(thisLayer);
      registerObjects();
      if(doRegisterMouse){
        reRegisterMouse = true;
      }
    }
  }
 
  void sendToBack(Object object) {
    if(registeredObjects.contains(object)){
      unregisterObjects();
      int index = registeredObjects.indexOf(object);
      bfLayer thisLayer = (bfLayer) layers.get(index);
      layers.remove(index);
      layers.add(0,thisLayer);
      registerObjects();
      if(doRegisterMouse){
        reRegisterMouse = true;
      }
    }
  }
   
  void shiftUp(Object object){
    if(registeredObjects.contains(object)){
      int index = registeredObjects.indexOf(object);
      if(index < layers.size()-1){
        unregisterObjects();
        bfLayer thisLayer = (bfLayer) layers.get(index);
        layers.remove(index);
        layers.add(index+1,thisLayer);
        registerObjects();
        if(doRegisterMouse){
          reRegisterMouse = true;
        }
      }
    }
  }
   
  void shiftDown(Object object){
    if(registeredObjects.contains(object)){
      int index = registeredObjects.indexOf(object);
      if(index > 0){
        unregisterObjects();
        bfLayer thisLayer = (bfLayer) layers.get(index);
        layers.remove(index);
        layers.add(index-1,thisLayer);
        registerObjects();
        if(doRegisterMouse){
          reRegisterMouse = true;
        }
      }
    }
  }
   
  void sendLayerTo(int target, Object object){
    if(registeredObjects.contains(object)){
      int index = registeredObjects.indexOf(object);
      if(target >= 0 && target < registeredLayerCount()) {
        unregisterObjects();
        bfLayer thisLayer = (bfLayer) layers.get(index);
        layers.remove(index);
        layers.add(target,thisLayer);
        registerObjects();
        if(doRegisterMouse){
          reRegisterMouse = true;
        }
      }
    }
  }
   
   
  // - - - - - REGISTER/UNREGISTER - - - - - //
  void unregisterObjects(){
    if(topLayer != null){
      unregisterDraw(topLayer.object);
      if(doRegisterMouse){
        unregisterMouseEvent(topLayer.object);
      }
    }
    if(bottomLayer != null){
      unregisterDraw(bottomLayer.object);
      if(doRegisterMouse){
        unregisterMouseEvent(bottomLayer.object);
      }
    }
    for(int i=0; i<layers.size(); i++){
      bfLayer thisLayer = (bfLayer) layers.get(i);
      unregisterDraw(thisLayer.object);
      if(doRegisterMouse){
        unregisterMouseEvent(thisLayer.object);
      }
    }
  }
   
  void registerObjects(){
    if(bottomLayer != null){
      if(!bottomLayer.stopped){
        registerDraw(bottomLayer.object);
      }
    }
    registeredObjects.clear();
    for(int i=0; i<layers.size(); i++){
      bfLayer thisLayer = (bfLayer) layers.get(i);
      if(!thisLayer.stopped){
        registerDraw(thisLayer.object);
      }
      registeredObjects.add(thisLayer.object);
    }
    if(topLayer != null){
      if(!topLayer.stopped){
        registerDraw(topLayer.object);
      }
    }
  }
   
   
  // - - - - - MOUSE - - - - - //
  void setAsOnlyActiveMouseLayer(Object object, boolean deactivateSpecialLayers) {
     
    if(doRegisterMouse){
      unregisterObjects();
      for(int i=0; i<layers.size(); i++){
        bfLayer thisLayer = (bfLayer) layers.get(i);
        thisLayer.mouseLocked = true;
      }
      if(deactivateSpecialLayers){
        if(topLayer != null){
          topLayer.mouseLocked = true;
        }
        if(bottomLayer != null){
          bottomLayer.mouseLocked = true;
        }
      }
      bfLayer activeLayer = getLayerFromObject(object);
      activeLayer.mouseLocked = false;
       
      registerObjects();
      reRegisterMouse = true;
    }
  }
   
  void activateAllMouseLayers() {
    if(doRegisterMouse){
      unregisterObjects();
      for(int i=0; i<layers.size(); i++){
        bfLayer thisLayer = (bfLayer) layers.get(i);
        thisLayer.mouseLocked = false;
      }
      if(topLayer!= null){
          topLayer.mouseLocked = false;
        }
        if(bottomLayer!= null){
          bottomLayer.mouseLocked = false;
        }
      registerObjects();
      reRegisterMouse = true;
    }
  }
   
  // should only be called in post; otherwise you risk a mouseEvent being repeated...
  void registerMouseObjects(){
    // in theory this can't be called if doRegisterMouse is false
    // but there's no harm in playing it safe...
    if(doRegisterMouse){
      if(topLayer != null){
        if(!topLayer.stopped && !topLayer.mouseLocked){
          registerMouseEvent(topLayer.object);
        }
      }
      for(int i=0; i<layers.size(); i++){
        bfLayer thisMouseLayer = (bfLayer) layers.get(layers.size() - (i+1));
        if(!thisMouseLayer.stopped && !thisMouseLayer.mouseLocked){
          registerMouseEvent(thisMouseLayer.object);
        }
      }
      if(bottomLayer != null){
        if(!bottomLayer.stopped && !bottomLayer.mouseLocked){
          registerMouseEvent(bottomLayer.object);
        }
      }
    }
  }
   
   
// - - - - - POST - - - - - //
  // Using post avoids mouseEvents being run twice because of re-registration
  void post() {   
    if(reRegisterMouse && doRegisterMouse){
      registerMouseObjects();
      reRegisterMouse = false;     
    }
     
  }
}