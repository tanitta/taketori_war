class Princess implements Entity{
  EntityTypes type(){return EntityTypes.Princess;}

  void callCollidingEvent(EntityTypes type){
    if(type == EntityTypes.Usagi){
      if(!_shouldDie){
        _shouldDie = true;
        game.decPrincesses();
        resources.trigger("kidnap.mp3");
      }
    }
  };

  Princess(PVector p){
    _animation = new Animation("princess");
    _x = p.x;
    _y = p.y;
    
    game.incPrincesses();
  }

  void update(){
  }

  void draw(){
    _animation.draw();
  }

  int width(){return _animation.width();};

  int height(){return _animation.height();};

  float x(){ return _x; };

  float y(){ return _y; };

  boolean shouldDie(){return _shouldDie;};

  private boolean _shouldDie = false;
  private Animation _animation;

  private float _x;
  private float _y;
}
