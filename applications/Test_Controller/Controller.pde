//has to see where the user clicked on the
//screen is where a rock is on the grid 
//has grid thing
//send to viewer where on screen to draw rock without 

class Controller{

  /** handle the Event passed from the main applet **/
  public boolean handleEvent(Event e) {
    switch (e.id) {
    case Event.MOUSE_DOWN:
      // mouse button pressed
      break;
    case Event.MOUSE_UP:
      // mouse button released
      break;
    }
    return false;
  }
  
  /** the update method with the deltaTime in seconds **/
  public void update(float deltaTime) {
    // empty
  }
  
  /** this will render the whole world **/
  public void render(Graphics g) {
    // empty
  }
}