class Moon implements Entity{
  EntityTypes type(){return EntityTypes.Moon;}
  
  Moon(){
    _animation = new Animation("moon");
    _x = 0f;
    _y = 150f;
  }

  void update(){}

  void draw(){
    _animation.draw();
  }
  
  void callCollidingEvent(EntityTypes type){};

  int width(){return _animation.width();};

  int height(){return _animation.height();};

  float x(){ return _x; };

  float y(){ return _y; };

  boolean shouldDie(){return false;/*immotal*/};
  
  float mass(){return 70000f;};
  
  private Animation _animation;
  
  private float _x;
  
  private float _y;
}
