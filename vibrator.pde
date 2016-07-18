class Vibrator{
  float mass = 1f;
  float spring = 1f;
  float damper = 1f;
  float deltaT= 1f/30f;
  float x = 0;
  float v = 0;
  
  void addForce(float f){
    v = v + f/mass*deltaT;
  }
  
  void update(){
    addForce(-x * spring);
    addForce(-v * damper);
    x = x + v*deltaT;
  };
}
