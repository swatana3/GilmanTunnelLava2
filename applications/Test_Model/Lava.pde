public class Lava{

  private float x;
  private float y;
  private float speedAnimation;

  public Lava(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  public float getX() {
    return x;
  }
  public float getY() {
    return y;
  }
  public void setSpeedAnimation(float speedAnimation){
    this.speedAnimation = speedAnimation; 
  }
  public void getSpeedAnimation(){
    return speedAnimation; 
  }
}