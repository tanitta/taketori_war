class Earth implements Entity{
  EntityTypes type(){return EntityTypes.Earth;}
  
  void callCollidingEvent(EntityTypes type){};
  
  Earth(){
    _animation = new Animation("earth");
    _x = 0f;
    _y = 600f;
  }

  void update(){}

  void draw(){
    _animation.draw();
  }

  int width(){return _animation.width();};

  int height(){return _animation.height();};

  float x(){ return _x; };

  float y(){ return _y; };

  boolean shouldDie(){return false;/*immotal*/};
  private Animation _animation;
  
  private float _x;
  private float _y;
}
