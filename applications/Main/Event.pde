// TODO: move this an abstract class, move implementations into subclasses
class Event {
  private ArrayList<Observer> observers;

  public Event() {
    this.observers = new ArrayList<Observer>();
  }

  public void addObserver(Observer observer) {
    observers.add(observer);
  }

  public void removeObserver(Observer observer) {
    observers.remove(observer);
  }
  public void notifyEvent() {
    for (Observer observer : observers) {
      observer.onNotify(this);
    }
  }
}

class PlayerDeadEvent extends Event {
  public PlayerDeadEvent() {
    super();
  }
}

class PlayerStepsOnRockEvent extends Event {
  RockModel rockModel;
  
  public PlayerStepsOnRockEvent() {
    super();
  }

  public void notifyEvent(RockModel rockModel) {
    this.rockModel = rockModel;
    super.notifyEvent();
  }
}