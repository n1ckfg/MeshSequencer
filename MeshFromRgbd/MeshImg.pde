class MeshImg {
  
  PImage depth, rgb;
  int downRes = 3;
  ArrayList<PVector> points;

  MeshImg(PImage _depth) {
    depth = _depth;
    initDepth();
  }
  
  MeshImg(PImage _depth, PImage _rgb) {
    depth = _depth;
    rgb = _rgb;
    initDepth();
  }
  
  void initDepth() {
    points = new ArrayList<PVector>();
    depth.loadPixels();
    
    for (int y=0; y<depth.height; y+=downRes) {
      for (int x=0; x<depth.width; x+=downRes) {
        int loc = x + y * depth.width;
        float xf = (float) x / (float) depth.width;
        float yf = (float) y / (float) depth.height;
        float zf = (float) depth.pixels[loc] / 255.0;
        points.add(new PVector(xf, yf, zf));
      }
    }
  }

  void draw() {
    beginShape();
    for (int i=0; i<points.size(); i++) {
      PVector p = points.get(i);
      vertex(p.x, p.y, p.z);
    }
    endShape();
    //setTexture(rgb);
  }
}
