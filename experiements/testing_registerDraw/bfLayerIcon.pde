/*  bfLayerIcon
    by blindfish
    www.blindfish.co.uk
    january 2010
     
    Used to display layer icons in bfLayerManager
     
*/
 
public class bfLayerIcon{
  bfLayerManager parent;
  float y;
  int originIndex;
  float originY;
  boolean pressed;
  boolean mouseOver;
   
   
  bfLayerIcon(float y, int originIndex, bfLayerManager parent){
    this.y = y;
    this.originY = y;
    this.originIndex = originIndex;
    this.parent = parent;
    registerDraw(this);
    registerMouseEvent(this);
  }
   
   
  void draw(){
    bfLayer thisLayer = (bfLayer) parent.managedLayers.layers.get(originIndex);
    strokeWeight(1);
    if(pressed){
      stroke(255);
    }
    else if(mouseOver){
      stroke(150);
    }
    else {
      stroke(0);
    }
    fill(thisLayer.colour);
    rect(parent.x,y,parent.w,parent.rowHeight);
    if(thisLayer.stopped) {
      fill(0);
    }
    else if(thisLayer.mouseLocked){
      fill(100);
    }
    else{
      fill(255);
    }
    rect(parent.x,y,parent.rowHeight,parent.rowHeight);
  }
   
  boolean isMouseover(int mx, int my) {
    mouseOver = mx > parent.x && mx < parent.x+parent.w && my > y && my < y+parent.rowHeight;
   return mouseOver;
  }
   
  void mouseEvent(MouseEvent event) {
    if((parent.selectedIcon == null && isMouseover(mouseX, mouseY)) || parent.selectedIcon == this){
      switch(event.getID()){
        case MouseEvent.MOUSE_PRESSED:
          pressed = true;
          parent.selectedIcon = this;
          if(mouseButton == LEFT){
              parent.layerIcons.bringToFront(this);
          }
          else if(mouseButton == RIGHT){
            bfLayer thisLayer = (bfLayer) parent.managedLayers.layers.get(originIndex);
            if(event.getModifiers() != 6){
              thisLayer.stopped = !thisLayer.stopped;
              parent.managedLayers.updateLayerOrder();
            }
            else {
              parent.managedLayers.setAsOnlyActiveMouseLayer(thisLayer.object, true);
            }
          }
        break;
        case MouseEvent.MOUSE_DRAGGED:
          if (mouseButton == LEFT) {
            if(mouseY > 0 && mouseY < parent.h+parent.rowHeight){
               y = mouseY-(parent.rowHeight/2);
             }
          }
        break;
        case MouseEvent.MOUSE_RELEASED:
            parent.selectedIcon = null;
            pressed = false;
            if(mouseButton ==LEFT && event.getModifiers() != 18){
               int newIndex = int(parent.managedLayers.registeredLayerCount() -((y+parent.rowHeight/2)/(parent.rowHeight+1)));
               parent.managedLayers.sendLayerTo(newIndex,parent.managedLayers.registeredObjects.get(originIndex));
               y = originY;
               parent.layerShifted = true;
            }
        break;
         
        default:
          parent.selectedIcon = null;
          pressed = false;
        break;
         
         
      }
    }
    else {
      mouseOver = false;
      pressed = false;
      y = originY;
    }
  }
   
   
   
}