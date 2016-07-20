class Takeyari implements Entity{
  EntityTypes type(){return EntityTypes.Takeyari;}
  
  void callCollidingEvent(EntityTypes type){
    if(type == EntityTypes.Usagi){
      _remainingLife--;
      if(_remainingLife==0){
        _shouldDie = true;
      }
    }
  };
  
  Takeyari(Earth e, Moon m, PVector from, PVector to){
    _earthPosition = new PVector(e.x(), e.y());
    _earthMass = e.mass();
    _moonPosition = new PVector(m.x(), m.y());
    _moonMass = m.mass();
    
    _position = from;
    _velocity = PVector.mult(to.sub(from), 0.8f).limit(110);
    
    _animation = new Animation("takeyari");
  }

  void update(){
    if(PVector.dist(_moonPosition, _position) < 32f){
      _shouldDie = true;
    }

    if(PVector.dist(_earthPosition, _position) < 32f){
      _shouldDie = true;
    }
    
    _age = _age + 1f;
    if(_age < 10){
      PVector direct = _velocity.copy();
      direct.normalize();
      // addForce(PVector.mult(direct, _age*0.4f));
      addForce(PVector.mult(direct, 19));
    }
    
    if(_age > 92 && _age < 102){
      PVector direct = _velocity.copy();
      direct.normalize();
      addForce(PVector.mult(direct, 15));
    }
    
    if(_age > 500){
      _shouldDie = true;
    }
    
    addGravity(_position, _earthPosition, _mass, _earthMass);
    addGravity(_position, _moonPosition, _mass, _moonMass);
    _position.add(PVector.mult(_velocity, _deltaT));
  }
  
  private void addGravity(PVector from, PVector to, float massFrom, float massTo){
   float r = PVector.dist(from, to);
   float invr = 1f/pow(r,3f);
   float grav = 1f;
   addForce(PVector.mult(PVector.sub(to, from),(grav*massFrom*massTo*invr)));
  }
  
  private void addForce(PVector f){
    _velocity = PVector.add(_velocity, PVector.mult(f, 1f/_mass));
  }
  
  void draw(){
    pushMatrix();
    if(_velocity.x < 0f){
      rotate(-PVector.angleBetween(new PVector(0, -1), _velocity) );
    }else{
      rotate(PVector.angleBetween(new PVector(0, -1), _velocity) );
    }
    _animation.draw();
    popMatrix();
    
  }
  
  boolean shouldDie(){return _shouldDie;};

  int width(){return _animation.width();};

  int height(){return _animation.width();};

  float x(){ return _position.x; };

  float y(){ return _position.y; };

  private Animation _animation;
  
  private boolean _shouldDie = false;
  
  private float _mass = 1.0;
  
  private PVector _moonPosition;
  private float _earthMass;
  private PVector _earthPosition;
  private float _moonMass;
  
  private PVector _position;
  private PVector _velocity;
  
  private float _age;

  private float _deltaT = 1f/30f;
  private int _remainingLife = 3;
}
