class Player implements Entity{
  EntityTypes type(){return EntityTypes.Player;}
  
  Player(){
    _animation = new Animation("player", 3);
  }
  
  void update(){ }
  
  void draw(){
    _animation.draw();
  }
  
  boolean shouldDie(){return false;/*immotal*/};

  int width(){return 16;};
  
  int height(){return 16;};

  float x(){ return _x; };

  float y(){ return _y; };
  
  float angle(){ return _angle; }
  
  void angle(float a, float r){
	  _angle = a;
	  _x = sin(_angle)*r;
	  _y = cos(_angle)*r;
  }
  
  private float _x;
  private float _y;
  
  private float _angle = 0f;
  
  private Animation _animation;
  private boolean _isWalking = false;
}
