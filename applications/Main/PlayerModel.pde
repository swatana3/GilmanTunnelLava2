class PlayerModel {
  private PlayerDeadEvent playerDeadEvent = new PlayerDeadEvent();

  static final int MAX_SHIELD = 1000;
  // raw x and y coordinates
  private int mLX, mRX, mLY, mRY;
  private float distanceScalarL,  distanceScalarR;
//  private float leftLerpX, leftLerpY, rightLerpX, rightLerpY;
  private float leftLastX, leftLastY, rightLastX, rightLastY;
  // player id
  private int id;
  private int health;
  // shield provides some tolerance of time before a player
  // starts taking damage to their health
  private int shield;
  // if colliding with lava
  private boolean collidingWithLava = false;
  private boolean dead = false;
  final private int max_health = 105;
  private int framesPressed = 0;
  
  private boolean inStandingZone = false;
  

  PlayerModel(int id) {
    this.shield = MAX_SHIELD;
    this.health = 105;
    this.id = id;
//    this.leftLerp = 0.0;
//    this.leftLerpY= 0.0;
//    this.rightLerpX = 0.0;
//    this.rightLerpY = 0.0;
    this.leftLastX = 0.0;
    this.leftLastY = 0.0;
    this.rightLastX = 0.0;
    this. rightLastY = 0.0;
    
  }
  
  /* Resets health and shield - for use in between levels */
  void resetHealth(){
    this.health = 105;
    this.shield = MAX_SHIELD;  
  }
  
  int getMaxHealth(){
    return this.max_health;
  }

  void update() {
    if (collidingWithLava) {
      if (this.shield <= 0) {
        if (this.health > 0) {
          this.health -= 1;
        } else {
          playerDeadEvent.notifyEvent();
          this.dead = true;
        }
      } else {
        this.shield -= 1;
      }      
    } else {
      this.shield = min(this.shield + 1, MAX_SHIELD);
    } 
  }
  
  public void setCollidingWithLava(boolean collide) {
    this.collidingWithLava = collide;
  }

  public void setRawLX(int x) {
    this.mLX = x;
  }
  public void setRawRX(int x) {
    this.mRX = x;
  }
    public void setRawLY(int y) {
    this.mLY = y;
  }
  public void setRawRY(int y) {
    this.mRY = y;
  }
  public void setDistanceScalarL (float l){
    this.distanceScalarL = l;
  }
  public void setDistanceScalarR (float r){
    this.distanceScalarR = r;
  }
  //to know last location of users for smoothness
  public void setLeftLastX(float lx){
    this.leftLastX = lx;
  }
  public void setLeftLastY(float ly){
    this.leftLastY = ly;
  }
  public void setRightLastX(float rx){
    this.rightLastX = rx;
  }
  public void setRightLastY(float ry){
    this.rightLastY = ry;
  }
  public void setInStandingZone(boolean s){
    inStandingZone = s;
  }
  //for framesPressed in another thing
  public void incrementFramesPressed(){
    framesPressed++;
  }
  public void resetFramesPressed(){
    framesPressed = 0;
  }
  public int getFramesPressed(){
    return framesPressed;
  }
  
  
  public int getRawLX() {
    return mLX;
  }
  public int getRawRX() {
    return mRX;
  }
  public int getRawLY() {
    return mLY;
  }
  public int getRawRY() {
    return mRY;
  }
  public float getDistanceScalarL (){
    return distanceScalarL;
  }
  public float getDistanceScalarR (){
    return distanceScalarR;
  }
 public float getLeftLastX(){
    return leftLastX;
  }
  public float getLeftLastY(){
    return leftLastY;
  }
  public float getRightLastX(){
    return rightLastX;
  }
  public float getRightLastY(){
    return rightLastY;
  }
  public boolean getInStandingZone(){
    return inStandingZone;
  }
  
  PlayerDeadEvent playerDeadEvent() {
    return playerDeadEvent; 
  }

  int getRemainingFrames() {
    return health;
  }
}

