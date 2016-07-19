class Animation{
  //
  Animation(String imagePrefix){
    this(imagePrefix, 1);
  }

  //
  Animation(String imagePrefix, int count){
    _imagePrefix = imagePrefix;
    _maxImages = count;
  }


  int maxImages(){
    return _maxImages;
  }


  void draw(){
    draw(0);
  }
  //
  void draw(int frame){
    resources.draw(getFileName(_imagePrefix, frame));
  }

  //
  int width(){return resources.width(getFileName(_imagePrefix, 0));}

  //    
  int height(){return resources.height(getFileName(_imagePrefix, 0));}

  private String _imagePrefix;

  private int _maxImages;

  private String getFileName(String imagePrefix, int count){
    if(_maxImages == 1){
      return imagePrefix + ".png";
    }else{
      return imagePrefix + nf(count+1) + ".png";
    }
  }
}
