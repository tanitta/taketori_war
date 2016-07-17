class Takeyari implements Entity{
  EntityTypes type(){return EntityTypes.Takeyari;}
  
  void callCollidingEvent(EntityTypes type){};

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
    
    _collisionDetector = new CollisionDetector();

    _moon   = new Moon();
    _earth  = new Earth();
    _player = new Player();
    // _usagi= new Usagi();
    
    _entities.add(new Usagi(_moon.x()+random(-32f, 32f), _moon.y()+random(-32f, 32f)));
    // _entities.add(new Usagi(_moon.x(), _moon.y()-100f));
    // _entities.add(_moon.x(), _moon.y()-100f);
    _entities.add(_moon);
  };

  void update(){
    updateEntities();
  }
  void draw(){
    background(0x1B2632);
    
    pushMatrix();
    translate(width/2, 0);
    drawPlaying();
    popMatrix();
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


    drawEntities();
  }

  private void drawEarth(){}

  private void drawSpace(){}

  private void updateEntities(){
    removeEntities();
    if(random(30)>29 && random(10)>9){
      _entities.add(new Usagi(_moon.x()+random(-32f, 32f), _moon.y()+random(-32f, 32f)));
    }
    
    for(Entity entity: _entities){
      entity.update();
    }
    
    _collisionDetector.update(_entities);
  }
  
  private void removeEntities(){
    // _entities.removeIf(p -> p.shouldDie());
    List<Entity> newList = new ArrayList<Entity>();
    for(Entity entity: _entities){
      if(!entity.shouldDie()){
        newList.add(entity);
      }
    }
    _entities = newList;
  }

  private void drawEntities(){
    for(Entity entity: _entities){
      pushMatrix();
      translate(int(entity.x()), int(entity.y()));
      entity.draw();
      popMatrix();
    }
  }
  
  private CollisionDetector _collisionDetector;

  private List<Entity> _entities = new ArrayList<Entity>();
  private Player _player;
  private Moon _moon;
  private Earth _earth;

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
