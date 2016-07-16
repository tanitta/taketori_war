class Player implements Entity{
  EntityTypes type(){return EntityTypes.Player;}
  
  void update(){}
  void draw(){}
  boolean shouldDie(){return false;/*immotal*/};

  int width(){return 16;};
  int height(){return 16;};

  float x(){ return 0f; };
  float y(){ return 0f; };
}

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

class Game{
  Game(){}

  void setup(){
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
    
    _moon.draw();
    _earth.draw();
    _usagi.draw();
    
    drawEntities();
  }
  private void drawEarth(){}
  private void drawSpace(){}

  private void updateEntities(){

  }

  private void drawEntities(){
  }

  private Entity[] _entities;
  private Player _player;
  private Moon _moon;
  private Earth _earth;
  
  private Usagi _usagi;
}

Game game = new Game();

void setup(){
  size(480, 320);
  surface.setResizable(true);
  game.setup();
}

void draw(){
  game.update();
  game.draw();
}
