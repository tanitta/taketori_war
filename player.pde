class Player implements Entity{
  EntityTypes type(){return EntityTypes.Player;}
  
  void callCollidingEvent(EntityTypes type){};
  
  Player(Earth e){
    _animation = new Animation("player", 3);
    
    _radius = e.height()/2 + height()/2;
    _earthPosition = new PVector(e.x(), e.y());
    angle(0f);
  }
  
  void update(){ }
  
  void draw(){
    pushMatrix();
    rotate(angle());
    _animation.draw();
    popMatrix();
  }
  
  boolean shouldDie(){return false;/*immotal*/};

  int width(){return _animation.width();};

  int height(){return _animation.height();};

  float x(){ return _x + _earthPosition.x; };

  float y(){ return _y + _earthPosition.y; };
  
  float angle(){return _angle;}
  
  void angle(float a){
	  _angle = a;
	  _x = sin(_angle)*_radius;
	  _y = -cos(_angle)*_radius;
  }
  
  private float _x;
  private float _y;
  
  private float _angle;
  private float _radius;
  private PVector _earthPosition;;
  
  private Animation _animation;
  private boolean _isWalking = false;
}
