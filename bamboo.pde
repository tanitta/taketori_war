class Bamboo implements Entity{
  EntityTypes type(){return EntityTypes.Bamboo;}
  
  void callCollidingEvent(EntityTypes type){
    if(type == EntityTypes.Player && _age >= 200){
      _shouldDie = true;
      game.addTakeyariRemaining();
      
      if(_isLighting){
        game.addBonusPrincess();
      }
    }
    
  };
  
  Bamboo(PVector p){
    _animation = new Animation("bamboo", 2);
    _animation_light = new Animation("bamboo_light", 8);
    _x = p.x;
    _y = p.y;
  }

  void update(){
    _age++;
    
    if(_age == 400){
      if(random(10)>8){
        _isLighting = true;
      }
    }
  }

  void draw(){
    if(_isLighting){
      _animation_light.draw(int(_age*0.1)%8);
    }else{
      if(_age < 200){
        _animation.draw(0);
      }else{
        _animation.draw(1);
      }
    }
  }
  
  int width(){return _animation.width();};

  int height(){return _animation.height();};

  float x(){ return _x; };

  float y(){ return _y; };

  boolean shouldDie(){return _shouldDie;};
  
  private boolean _shouldDie = false;
  private Animation _animation;
  
  private boolean _isLighting = false;
  private Animation _animation_light;
  
  private float _x;
  private float _y;
  private float _age;
}
