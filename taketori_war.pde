enum GameStatus{
  Opening, 
  Playing, 
  Gameover, 
}

class Game{
  Game(){}

  void setup(){
    _state = GameStatus.Opening;
    _openingAnimation = new Animation("opening");
    
    _collisionDetector = new CollisionDetector();

    _moon   = new Moon();
    _earth  = new Earth();
    _player = new Player(_earth);
    // _usagi= new Usagi();
    
    _entities.add(new Usagi(_moon.x()+random(-32f, 32f), _moon.y()+random(-32f, 32f)));
    // _entities.add(new Usagi(_moon.x(), _moon.y()-100f));
    // _entities.add(_moon.x(), _moon.y()-100f);
    _entities.add(_moon);
    _entities.add(_player);
    
    _takeyariRemaining = 10;
    
    spawnPrincess(0f);
  };

  void update(){
    
    if(_state == GameStatus.Playing){
      updatePlaying();
    }
  }
  void draw(){
    background(0x1B2632);
    
    pushMatrix();
    translate(width/2, 0);
    if(_state == GameStatus.Opening){
      drawOpening();
    }
    
    if(_state == GameStatus.Playing){
      drawPlaying();
    }
    popMatrix();
  }
  
  void mousePressed(){
    if(_state == GameStatus.Playing){
      launchTakeyari();
    }
    if(_state == GameStatus.Opening){
      _state = GameStatus.Playing;
    }
  };
  
  private void launchTakeyari(){
    if(_takeyariRemaining > 0) {
      float radius = _earth.height()/2 + _player.height()/2;
      _entities.add(new Takeyari(
            _earth, _moon,
            new PVector(_earth.x()+sin(_player.angle())*radius, _earth.y()-cos(_player.angle())*radius), 
            new PVector(mouseX-width/2, mouseY)
            ));
      _takeyariRemaining--;
    }
  }
  
  
  void updatePlaying(){
    updateEntities();
    _level += 0.0005;
    if(_princesses == 0){
      _state = GameStatus.Gameover;
    }
  }
  
  void addTakeyariRemaining(){
    _takeyariRemaining++;
  };
  
  void addBonusTake(){
    _bonusSpawningTake+=2;
  };
  
  void addBonusPrincess(){
    _bonusSpawningPrincess++;
  };
  
  float level(){
    return _level;
  }

  void drawOpening(){
    
    pushMatrix();
    translate(0, height/2);
    _openingAnimation.draw();
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
    popMatrix();
    
    float radius = _earth.height()/2 + _player.height()/2;
    
    if(keyPressed && key=='a'){
      _player.angle(_player.angle()-0.03);
    }
    if(keyPressed && key=='d'){
      _player.angle(_player.angle()+0.03);
    }

    drawEntities();
  }

  private void drawEarth(){}

  private void drawSpace(){}

  private void spawnTake(){
      float angle = random(-2f, 2f);
      float radius = _earth.height()/2 + 16;
      _entities.add(new Bamboo(new PVector(_earth.x()+sin(angle)*radius, _earth.y()-cos(angle)*radius)));
  }
  
  void incPrincesses(){
    _princesses++;
  }
  
  void decPrincesses(){
    _princesses--;
  }
  
  private void spawnPrincess(PVector p){
      _entities.add(new Princess(p));
  }
  
  private void spawnPrincess(float a){
      float angle = a;
      float radius = _earth.height()/2 + 16;
      spawnPrincess(
          new PVector(_earth.x()+sin(angle)*radius, _earth.y()-cos(angle)*radius)
      );
  }
  
  private void spawnPrincess(){
      spawnPrincess(random(-3.2f, 3.2f));
  }
  
  private void updateEntities(){
    removeEntities();
    
    if(random(30)>29 && random(10)>8){
      for(int i = 0; i < 1+(int)_level; i++){
        _entities.add(new Usagi(_moon.x()+random(-32f, 32f), _moon.y()+random(-32f, 32f)));
      }
    }
    
    for(int i = 0; i < _bonusSpawningTake; i++){
      spawnTake();
    }
    _bonusSpawningTake = 0;
    
    for(int i = 0; i < _bonusSpawningPrincess; i++){
      spawnPrincess();
    }
    _bonusSpawningPrincess = 0;
    
    if(random(30)>29 && random(10)>8){
      spawnTake();
    }
    
    for(Entity entity: _entities){
      entity.update();
    }
    
    _collisionDetector.update(_entities);
  }
  
  private void removeEntities(){
    List<Entity> newList = new ArrayList<Entity>();
    for(Entity entity: _entities){
      //
      
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
      if(entity.type() == EntityTypes.Bamboo || entity.type() == EntityTypes.Princess){
        PVector localPosition = new PVector(entity.x()-_earth.x(), entity.y()-_earth.y());
        // rotate(PVector.angleBetween(localPosition, new PVector(0f, -1f)));
        
        if(localPosition.x < 0f){
          rotate(-PVector.angleBetween(new PVector(0, -1), localPosition) );
        }else{
          rotate(PVector.angleBetween(new PVector(0, -1), localPosition) );
        }
      }
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
  
  private int _takeyariRemaining;
  private int _bonusSpawningTake = 0;
  private int _bonusSpawningPrincess = 0;
  
  private int _princesses = 0;
  private float _level = 0;
  
  private Animation _openingAnimation;
}

Game game = new Game();

void setup(){
  size(900, 900);
  // surface.setResizable(true);
  game.setup();
}

void draw(){
  game.update();
  game.draw();
}
void mousePressed() {
  game.mousePressed();
}
