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
    
    _takeyariRemaining = 20;
    
    spawnPrincess(0f);
    
    _vibratorX = new Vibrator();
    _vibratorX.mass = 0.01f;
    _vibratorX.spring = 20f;
    _vibratorX.damper= 0.02f;
    _vibratorY = new Vibrator();
    _vibratorY.mass = 0.01f;
    _vibratorY.spring = 20f;
    _vibratorY.damper= 0.02f;
    
    stroke(255, 0, 0);
    noFill();
    strokeWeight(2);
    //sound
    // resources.play("opening.mp3");
    resources.play("opening.mp3");
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
    translate(_vibratorX.x, _vibratorY.x);
    if(_state == GameStatus.Opening){
      drawOpening();
    }
    
    if(_state == GameStatus.Playing){
      drawPlaying();
      
      pushMatrix();
      // translate(-width/2, 0);
      drawInfo();
      popMatrix();
    }
    
    if(_state == GameStatus.Gameover){
      drawGameover();
      pushMatrix();
      translate(width/2-16*8, 160);
      drawScore();
      popMatrix();
    }
    popMatrix();
  }
  private void drawInfo(){
    drawScore();

    pushMatrix();
    translate(_earth.x()-8*5, _earth.y()-16);
    resources.draw("remain.png", 0, 0);
    translate(16*2, 0);
    drawNumber(_takeyariRemaining, 3);
    popMatrix();
  }
  
  private void drawScore(){
      pushMatrix();
      translate(-width/2+16, 16);
      resources.draw("score.png", 0, 0);
      translate(16*6, 0);
      drawNumber(_score, 8);
      popMatrix();
  }
  
  void addScore(int score){
    _score += score * int(1f+_level);
  };
  
  private void drawNumber(int num, int d){
    String str = nf(num, d);
    for(int i = 0; i<d; ++i){
      int a = Integer.valueOf(str.substring(i, i+1));
      resources.draw("number"+nf(a+1)+".png", i*16, 0);
    }
  }
  
  void mousePressed(){
    if(_state == GameStatus.Playing){
      launchTakeyari();
    }
    if(_state == GameStatus.Opening){
      resources.close("opening.mp3");
      _state = GameStatus.Playing;
      resources.play("battle.mp3");
    }
  };
  
  private void launchTakeyari(){
    if(_takeyariRemaining > 0) {
      float radius = _earth.height()/2 + _player.height()/2;
      PVector from = new PVector(_earth.x()+sin(_player.angle())*radius, _earth.y()-cos(_player.angle())*radius);
      PVector to = new PVector(mouseX-width/2, mouseY);
      _entities.add(new Takeyari(
            _earth, _moon,
            from, 
            to
            ));
      _takeyariRemaining--;
      addVibration(PVector.mult(PVector.random2D().normalize(), 20f));
      // addVibration(PVector.mult(to.sub(from).normalize(), 100f));
      resources.trigger("launch.mp3");
    }else{
      resources.trigger("noremain.mp3");
    }
  }
  
  
  void updatePlaying(){
    _timer++;
    updatePlayer();
    updateEntities();
    updateEffects();
    _level += 0.00007;
    if(_princesses == 0){
      _state = GameStatus.Gameover;
    }
    _vibratorX.update();
    _vibratorY.update();
  }
  
  void addTakeyariRemaining(){
    _takeyariRemaining+=2;
  };
  
  void addBonusTake(){
    _bonusSpawningTake+=1;
  };
  
  void addBonusPrincess(){
    _bonusSpawningPrincess++;
  };
  
  float level(){
    return _level;
  }
  
  void addVibration(PVector f){
    _vibratorX.addForce(f.x);
    _vibratorY.addForce(f.y);
  }

  void drawOpening(){
    pushMatrix();
    translate(0, height/2);
    _openingAnimation.draw();
    popMatrix();
  }
  void drawGameover(){
    pushMatrix();
    translate(0, height/2);
    resources.draw("gameover.png");
    popMatrix();
  }
  
  private void updatePlayer(){
    float radius = _earth.height()/2 + _player.height()/2;
    float walkingSpeed = 0.07;
    if(keyPressed && key=='a'){
      _player.angle(_player.angle()-walkingSpeed);
    }
    if(keyPressed && key=='d'){
      _player.angle(_player.angle()+walkingSpeed);
    }
  }
  
  
  private void drawPlaying(){
      float radius = _earth.height()/2 + _player.height()/2;
    PVector from = new PVector(_earth.x()+sin(_player.angle())*radius, _earth.y()-cos(_player.angle())*radius);
    PVector to = new PVector(mouseX-width/2, mouseY);
    
    PVector v = PVector.mult(to.sub(from), 0.8f).limit(110);
    line(from.x, from.y, from.x + v.x*0.8f, from.y + v.y*0.8f);
    v.normalize();
    ellipse(from.x + v.x*110f*0.8f, from.y + v.y*110f*0.8f, 4, 4);
    
    // println(_level);
    pushMatrix();
    translate(_moon.x(), _moon.y());
    _moon.draw();
    popMatrix();

    pushMatrix();
      translate(_earth.x(), _earth.y());
      _earth.draw();
    popMatrix();

    drawEntities();
    drawEffects();
  }
  
  private void drawEffects(){
    for(Effect effect: _effects){
      pushMatrix();
      // translate(int(effect.x()), int(effect.y()));
      translate(int(effect.x()), int(effect.y()));
      effect.draw();
      popMatrix();
    }
  }

  private void spawnTake(){
      float angle = random(-PI, PI);
      float radius = _earth.height()/2 + 16;
      _entities.add(new Bamboo(new PVector(_earth.x()+sin(angle)*radius, _earth.y()-cos(angle)*radius)));
  }
  
  void addLevel(float l){
    _level += l;
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
    
    // if(random(30)>29 && random(10)>8){
    if(_timer%int(30f*20f/(1f+_level*0.15))==0){
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
  
  private void updateEffects(){
    removeEffects();
    for(Effect effect: _effects){
      effect.update();
    }
  }
  
  private void removeEntities(){
    List<Entity> newList = new ArrayList<Entity>();
    for(Entity entity: _entities){
      //
      
      if(!entity.shouldDie()){
        newList.add(entity);
      }else{
        if(entity.type() == EntityTypes.Usagi){
          _effects.add(new Bomb(new PVector(entity.x(), entity.y())));
          resources.trigger("bomb.mp3");
          addVibration(PVector.mult(PVector.random2D().normalize(), 80f));
        }
      }
    }
    _entities = newList;
  }
  
  private void removeEffects(){
    List<Effect> newList = new ArrayList<Effect>();
    for(Effect effect: _effects){
      //
      
      if(!effect.shouldDie()){
        newList.add(effect);
      }
    }
    _effects = newList;
  }

  private void drawEntities(){
    Collections.reverse(_entities);
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
    Collections.reverse(_entities);
  }
  
  private CollisionDetector _collisionDetector;
  private List<Entity> _entities = new ArrayList<Entity>();
  private List<Effect> _effects = new ArrayList<Effect>();
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
  
  private Vibrator _vibratorX;
  private Vibrator _vibratorY;
  
  private int _score = 0;
  private long _timer = 0;
}

Resources resources = new Resources();
Game game = new Game();

void setup(){
  size(900, 900);
  resources.minim = new Minim(this);
  game.setup();
}

void draw(){
  game.update();
  game.draw();
}
void mousePressed() {
  game.mousePressed();
}
void stop()
{
  resources.close();
}
