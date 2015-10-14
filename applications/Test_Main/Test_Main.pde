//What starts off the program. 
//Contains Threads 
//Contains EventHandler

//Controller control = new Controller();<--figures out what to 
//do with event

class Test_Main implements Runnable {

  private static final long serialVersionUID = -2472397668493332423L;

  public void start() {
    new Thread(this).start();
  }

  void run() {

    long delta = 0l;
    
    //create model to make intial array of rocks, lava
    //create view contructor 
    
    // Game loop.
    while (true) {
       
      //control.updateModel(); <--updates the Model
      //control.viewRedraw();<--Call view to redraw
      
      // Lock the frame rate
    }
  }

  public boolean handleEvent(Event e) {
    //return control.handleEvenet(e); 
    return false; 
  }
}