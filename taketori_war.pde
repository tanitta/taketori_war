interface Entity{
  void update();
  void draw();
  boolean shouldDie();
  // void shouldDie(boolean b);
  
  int width();
  int height();
  
  float x();
  float y();
}


class Moon implements Entity{
  Moon(){
    _animation = new Animation("moon");
  }
  
  void update(){}
  
  void draw(){
    _animation.draw();
  }
  
  int width(){return _animation.width();};
  
  int height(){return _animation.height();};
  
  float x(){ return 0f; };
  
  float y(){ return 0f; };
  
  boolean shouldDie(){return false;/*immotal*/};
  private Animation _animation;
}

class Usagi implements Entity{
  int width(){return 32;};
  int height(){return 32;};
  
  float x(){ return 0f; };
  float y(){ return 0f; };
  
  void update(){}
  void draw(){}
  boolean shouldDie(){return _shouldDie;};
  
  private boolean _shouldDie = false;
}

class Player implements Entity{
  
  void update(){}
  void draw(){}
  boolean shouldDie(){return false;/*immotal*/};
  
  int width(){return 16;};
  int height(){return 16;};
  
  float x(){ return 0f; };
  float y(){ return 0f; };
}

class Takeyari implements Entity{
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
    _moon = new Moon();
    _player = new Player();
  };
  
  void update(){
    updateEntities();
  }
  
  void draw(){
    _moon.draw();
    drawEntities();
  }
  private void drawEarth(){}
  private void drawSpace(){}
  // private void drawMoon(){}
  
  private void updateEntities(){
    
  }
  
  private void drawEntities(){
  }
  
  private Entity[] _entities;
  private Player _player;
  private Moon _moon;
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
