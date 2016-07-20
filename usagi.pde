class Usagi implements Entity{
  EntityTypes type(){return EntityTypes.Usagi;}
  
  Usagi(float x, float y){
    _usagiAnimation = new Animation("usagi");
    _beamAnimation = new Animation("beam", 2);
    _x = x;
    _y = y;

    _isBeaming = false;
    _motionCounter = random(-3000f, 3000f);
  }
  
  Usagi(){
    this(100f, 600f);
  }

  void update(){
    if(_isBeaming){
      _beamFrame = (_beamFrame + 0.1)%_beamAnimation.maxImages();
    }
    _motionCounter += 0.005;
    // _x = _x + sin(_motionCounter*1f)*(_motionCounter*(1f + game.level())*0.1);
    _x = _x + (noise(_motionCounter)-0.5f)*5f;
    
    _x = _x + (0-_x)*0.001;
    _y = _y + (700-_y)*0.001;
    
    // _y = _y +l 0.1f*(1f + game.level()) 
    _y = _y + 0.5f*(1f + game.level()*0.1)+ cos(_motionCounter*5.0)*1f;
    
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
      game.addScore(100);
      game.addLevel(map(height-_y, 150f, 600f, 0f, 1f)*0.6f/(1f+game.level()));
      
      if(_shouldDie &&_y <= 800f){
        if(random(0f, 100f)<33f){
          game.addBonusTake();
        }
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
