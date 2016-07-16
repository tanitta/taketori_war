class Moon implements Entity{
  EntityTypes type(){return EntityTypes.Moon;}
  Moon(){
    _animation = new Animation("moon");
    _x = 100f;
    _y = 100f;
  }

  void update(){}

  void draw(){
    pushMatrix();
      translate(_x, _y);
    _animation.draw();
    popMatrix();
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
