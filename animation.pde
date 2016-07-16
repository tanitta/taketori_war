class Animation{
	//
	Animation(String imagePrefix){
		this(imagePrefix, 1);
	}

	//
	Animation(String imagePrefix, int count){
		_maxImages = count;
		_images = new PImage[count];

		if(count == 1){
			String filename = imagePrefix + ".png";
			_images[0] = loadImage(filename);
			println("loaded : "+filename);
		}else{
			for (int i = 0; i < _maxImages; i++) {
				// Use nf() to number format 'i' into four digits
				String filename = imagePrefix + "_" + nf(i, 4) + ".png";
				_images[i] = loadImage(filename);
			}
		}
		_width = _images[0].width;
		_height = _images[0].height;
	}


	void draw(){
		draw(0);
	}
	//
	void draw(int frame){
		int shiftX = -_width/2;
		int shiftY = -_height/2;
		image(_images[frame], shiftX, shiftY);
	};

	//
	int width(){return _width;};

	//
	int height(){return _height;};

	private PImage[] _images;
	private int _maxImages;
	private int _width;
	private int _height;
}
