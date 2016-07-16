class Usagi implements Entity{
  EntityTypes type(){return EntityTypes.Usagi;}
  Usagi(){
    _usagiAnimation = new Animation("usagi");
    _beamAnimation = new Animation("beam", 2);
    _x = 100f;
    _y = 600f;

    _isBeaming = true;
  }

  void update(){
    if(_isBeaming){
      _beamFrame = (_beamFrame + 0.1)%_beamAnimation.maxImages();
    }
  }
  void draw(){
    _usagiAnimation.draw();
    if(_isBeaming){
      drawBeam();
    }

  }

  void drawBeam(){
    pushMatrix();
    translate(0, _beamAnimation.height());
    _beamAnimation.draw(int(_beamFrame));
    popMatrix();
  };

  boolean shouldDie(){return _shouldDie;};

  int width(){return _usagiAnimation.width();};
  int height(){return _usagiAnimation.height() + _beamAnimation.height();};

  float x(){ return _x; };
  float y(){ return _y; };

  private boolean _shouldDie = false;
  private Animation _usagiAnimation;
  private Animation _beamAnimation;

  private float _x;
  private float _y;
  private boolean _isBeaming = false;
  private float _beamFrame = 0f;
}
