class MeshImg {
  
  PImage depth, rgb;
  int downRes = 1;
  PShape s;
  boolean calcFaces = true;

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
    s = createShape();
    depth.loadPixels();
    
    if (!calcFaces) {
      s.beginShape(POINTS);
      s.strokeWeight(4);
      for (int y=0; y<depth.height; y+=downRes) {
        for (int x=0; x<depth.width; x+=downRes) {
          int loc = x + y * depth.width;
          float xf = (float) x / (float) depth.width;
          float yf = (float) y / (float) depth.height;
          float zf = (float) red(depth.pixels[loc]) / 255.0;
          if (rgb != null) {
            s.stroke(rgb.pixels[loc]);
          } else {
            s.stroke(255);
          }
          s.vertex(xf, yf, -zf);
        }
      }
      s.endShape();
    } else {
      PVector points[] = new PVector[depth.width * depth.height];
     
      for (int y=0; y<depth.height; y+=downRes) {
        for (int x=0; x<depth.width; x+=downRes) {
          int loc = x + y * depth.width;
          float xf = (float) x / (float) depth.width;
          float yf = (float) y / (float) depth.height;
          float zf = (float) red(depth.pixels[loc]) / 255.0;
          points[loc] = new PVector(xf, yf, -zf);
        }
      }
      
      s.beginShape(TRIANGLES);
      s.strokeWeight(4);
      for (int y = 0; y < depth.height -1; y++) {
        for (int x = 0; x < depth.width -1 ; x++) {
          int b = y * depth.width + x ;
          int a = b + 1;
          int c = (y + 1)* depth.width + x ;
          int d = c + 1 ;
          
          if (rgb != null) {
            s.stroke(rgb.pixels[a]);
            s.fill(rgb.pixels[a]);
          } else {
            s.stroke(255);
            s.fill(127);
          }
          s.vertex(points[a].x, points[a].y, points[a].z);            
          s.vertex(points[b].x, points[b].y, points[b].z);            
          s.vertex(points[c].x, points[c].y, points[c].z);            
          
          s.vertex(points[a].x, points[a].y, points[a].z);
          s.vertex(points[c].x, points[c].y, points[c].z);
          s.vertex(points[d].x, points[d].y, points[d].z);
        }
      }
      s.endShape();
  }
    
    if (rgb != null) s.setTexture(rgb);
  }

  void draw() {
    shape(s, 0, 0);
  }
}
