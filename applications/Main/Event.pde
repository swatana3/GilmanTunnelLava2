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

