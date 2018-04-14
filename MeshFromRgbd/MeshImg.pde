class MeshImg {
  
  PImage depth, rgb;
  int downRes = 2;
  color[] depthPixels;
  PShape shape;
  
  MeshImg(PImage _depth) {
    depth = _depth;
    depthPixels = new color[int(depth.pixels.length/downRes)];
  }
  
  MeshImg(PImage _depth, PImage _rgb) {
    depth = _depth;
    rgb = _rgb;
    depthPixels = new color[int(depth.pixels.length/downRes)];
  }
  
  void initDepth() {
    depth.loadPixels();
    for (int i=0; i<depth.pixels.length; i+= downRes) {
      depthPixels[int(i/downRes)] = depth.pixels[i];
    }
    
    int counter = 0;
    // TODO fix method with meshobj
    shape.beginShape();
    for (int y=0; y<int(depth.height/downRes); y++) {
      for (int x = 0; x<int(depth.width/downRes); x++) {
        int loc = x + y * int(depth.width/downRes);
        shape.setVertex(counter++, new PVector(x, y, depthPixels[loc]));
      }
    }
    shape.endShape();
    
    shape.setTexture(rgb);
  }

}
