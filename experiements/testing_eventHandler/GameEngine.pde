import java.awt.event.MouseEvent;

public class GameEngine {

    GameEngine(){
      registerDraw(this);
      registerMouseEvent(this);

    }
    
  
    void mouseEvent(MouseEvent event) {
      switch (event.getID()) {
        case MouseEvent.MOUSE_PRESSED:
          // mouse pressed
        break;
        case MouseEvent.MOUSE_RELEASED:
         // mouse button pressed
        break;
        case MouseEvent.MOUSE_DRAGGED:
      // mouse button released
        break;
    }
  }
    void draw() {
     fill(baseGray);
    stroke(255);     
    if (pressed != true) { 
      rect(x, y, size, size);
       image(baseImage,x,y);
    }
    else {
      rect(x, y, size, size);
      image(pressImage,x,y);
     
    }
    }
  
}