class Bomb implements Effect{
  Bomb(PVector p){
    _position = p;
    _age = 0f;
    _animation = new Animation("bomb", 8);
  }
  
  boolean shouldDie(){return _age>7;}
  
  void  draw(){
    _animation.draw(int(_age));
  };
  
  void  update(){_age+=0.3f;};
  
  float x(){return _position.x;}
  
  float y(){return _position.y;}
  
  private PVector _position;
  private Animation _animation;
  private float _age;
  
}
