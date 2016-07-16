interface Entity{
  void update();
  void draw();
  boolean shouldDie();
  // void shouldDie(boolean b);

  int width();
  int height();

  float x();
  float y();
  
  EntityTypes type();
}
