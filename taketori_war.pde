class Takeyari implements Entity{
  EntityTypes type(){return EntityTypes.Takeyari;}

  void update(){}
  void draw(){}
  boolean shouldDie(){return _shouldDie;};

  int width(){return 32;};
  int height(){return 96;};

  float x(){ return 0f; };
  float y(){ return 0f; };

  private boolean _shouldDie = false;
}

enum GameStatus{
  Opning, 
  Playing, 
  Gameover, 
}

class Game{
  Game(){}

  void setup(){
    _state = GameStatus.Opning;

    _moon   = new Moon();
    _earth  = new Earth();
    _player = new Player();
    _usagi= new Usagi();
  };

  void update(){
    _usagi.update();

    updateEntities();
  }
  void draw(){
    background(0x1B2632);
    
    drawPlaying();
  }

  private void drawPlaying(){
    pushMatrix();
    translate(_moon.x(), _moon.y());
    _moon.draw();
    popMatrix();

    pushMatrix();
      translate(_earth.x(), _earth.y());
      _earth.draw();
      float radius = _earth.height()/2 + _player.height()/2;
      _player.angle( _player.angle()+0.01f, radius);
      pushMatrix();
        rotate(_player.angle());
        translate(0f, -radius);
        _player.draw();
      popMatrix();
    popMatrix();

    pushMatrix();
    translate(_usagi.x(), _usagi.y());
    _usagi.draw();
    popMatrix();

    drawEntities();
  }

  private void drawEarth(){}

  private void drawSpace(){}

  private void updateEntities(){}

  private void drawEntities(){}

  private Entity[] _entities;
  private Player _player;
  private Moon _moon;
  private Earth _earth;

  private Usagi _usagi;
  private GameStatus _state;
}

Game game = new Game();

void setup(){
  size(480, 700);
  surface.setResizable(true);
  game.setup();
}

void draw(){
  game.update();
  game.draw();
}
