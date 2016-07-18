class Usagi implements Entity{
  EntityTypes type(){return EntityTypes.Usagi;}
  
  Usagi(float x, float y){
    _usagiAnimation = new Animation("usagi");
    _beamAnimation = new Animation("beam", 2);
    _x = x;
    _y = y;

    _isBeaming = false;
    _motionCounter = random(0f, 3f);
  }
  
  Usagi(){
    this(100f, 600f);
  }

  void update(){
    if(_isBeaming){
      _beamFrame = (_beamFrame + 0.1)%_beamAnimation.maxImages();
    }
    _motionCounter += 0.01;
    _x = _x + sin(_motionCounter)*(_motionCounter*0.1+1.0);
    _y = _y + 0.1f*(1f + game.level()) + cos(_motionCounter*2.0)*1.0;
    
    if(_y > 800f){
      _shouldDie = true;
    }
  }
  void draw(){
    _usagiAnimation.draw();
    if(_isBeaming){
      drawBeam();
    }

  }
  
  void callCollidingEvent(EntityTypes type){
    // println(type);
    if(type == EntityTypes.Takeyari){
      // println("detect : Usagi");
      _shouldDie = true;
      
      if(_shouldDie &&_y <= 800f){
        game.addBonusTake();
      }
    }
  };

  void drawBeam(){
    pushMatrix();
    translate(0, _beamAnimation.height());
    _beamAnimation.draw(int(_beamFrame));
    popMatrix();
  };

  boolean shouldDie(){return _shouldDie;};

  int width(){return _usagiAnimation.width();};
  int height(){return _usagiAnimation.height();};

  float x(){ return _x; };
  float y(){ return _y; };

  private boolean _shouldDie = false;
  private Animation _usagiAnimation;
  private Animation _beamAnimation;

  private float _x;
  private float _y;
  private boolean _isBeaming = false;
  private float _beamFrame = 0f;
  
  private float _motionCounter = 0f;
}
