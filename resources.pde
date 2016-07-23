  
import java.util.Map;
import ddf.minim.*;
class Resources{
  Minim minim;
  
  void draw(String name){
    if(!_images.containsKey(name)){
      _images.put(name, loadImage(name));
    }
    
    PImage image = _images.get(name);
		int shiftX = -image.width/2;
		int shiftY = -image.height/2;
    image(_images.get(name), shiftX, shiftX);
  };
  
  void draw(String name, int x, int y){
    if(!_images.containsKey(name)){
      _images.put(name, loadImage(name));
    }
    
    PImage image = _images.get(name);
    image(_images.get(name), x, y);
  };
  
  int width(String name){
    if(!_images.containsKey(name)){
      _images.put(name, loadImage(name));
    }
    return _images.get(name).width;
  }
  
  int height(String name){
    if(!_images.containsKey(name)){
      _images.put(name, loadImage(name));
    }
    return _images.get(name).height;
  }
  
  private HashMap<String, PImage> _images = new HashMap<String, PImage>();
  
  void play(String name){
    try{
      if(!_sounds.containsKey(name)){
        _sounds.put(name, minim.loadFile(name, 2048));
      }
      _sounds.get(name).loop();
    }catch(Exception e){
      
    }
  }
  
  void close(String name){
    try{
    if(!_sounds.containsKey(name)){
      _sounds.put(name, minim.loadFile(name, 2048));
    }
      _sounds.get(name).close();
    }catch(Exception e){
      
    }
  }
  
  void trigger(String name){
    try{
    if(!_samples.containsKey(name)){
      _samples.put(name, minim.loadSample(name, 2048));
    }
      _samples.get(name).trigger();
    }catch(Exception e){
      
    }
  }
  
  private HashMap<String, AudioSample> _samples = new HashMap<String, AudioSample>();
  private HashMap<String, AudioPlayer> _sounds = new HashMap<String, AudioPlayer>();
  
  void close(){
    try{
      for (Map.Entry o : _sounds.entrySet()) {
        _sounds.get(o.getKey()).close();
      }

      minim.stop();
      
    }catch(Exception e){

    }
  }
}
