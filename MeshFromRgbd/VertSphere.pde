class VertSphere {
  
  PShape ps;
  PImage tex_rgb;
  PImage tex_depth;
  float normLineLength = 20;
  int detail = 15;
  int radius = 200;
  ArrayList<Vert> verts;
  color tintCol = color(255);
  boolean drawEndLines = false;
  boolean drawSourceSphere = false;
 
  float _Displacement = 620;
  float _BaselineLength = 1800;
  float _SphericalAngle = 3.142;
  float _Maximum = 303.65;
  
  VertSphere(PImage _rgb, PImage _depth) {
    init(_rgb, _depth);
  }
  
  VertSphere(PImage _rgb, PImage _depth, int _detail) {
    detail = _detail;
    init(_rgb, _depth);
  }
  
  void init(PImage _rgb, PImage _depth) {
    sphereDetail(detail);
    tex_rgb = _rgb;
    tex_depth = _depth;
    tex_rgb.loadPixels();
    tex_depth.loadPixels();
    ps = createShape(SPHERE, radius);
    ps.setTexture(tex_rgb);  
    verts = initVerts(ps);
  }
  
  ArrayList<Vert> initVerts(PShape shape) {
    ArrayList<Vert> returns = new ArrayList<Vert>();
    for (int i = 0 ; i < shape.getVertexCount(); i ++) {
      Vert v = new Vert(shape.getVertex(i));
      v.col = getPixelFromUv(tex_rgb, v.uv);
      v.depth = getPixelFromUv(tex_depth, v.uv);
      v.co = reprojectEqr(v);
      returns.add(v);
    }
    return returns;
  }
  
  void draw() {
    if (drawSourceSphere) {
      fill(tintCol);
      stroke(0);
      strokeWeight(4);
      shape(ps);
    }
    stroke(255);
    strokeWeight(2);
    draw_points();
  }

  void draw_points() {
    for (int i = 0; i < verts.size(); i++) {
      Vert v = verts.get(i);
      
      stroke(v.col);
      strokeWeight(10);
      point(v.co.x + v.n.x, v.co.y + v.n.y, v.co.z + v.n.z);
      
      if (drawEndLines) {
        PVector end = v.co.copy().add(v.n.copy().mult(normLineLength));
        strokeWeight(2);
        line(v.co.x, v.co.y, v.co.z, end.x, end.y, end.z);
      }
    }
  }

  color getPixelFromUv(PImage img, PVector uv) {   
    int x = int(uv.x * img.width);
    int y = int(uv.y * img.height);
    int loc = x + y * img.width;
    loc = constrain(loc, 0, img.pixels.length - 1);
    return img.pixels[loc];
  }
  
  float getDepthSpherical(float d) {
      return asin(_BaselineLength * sin(_SphericalAngle)) / asin(d);
  }
          
  PVector reprojectEqr(Vert v) {
    PVector returns = v.n.copy().mult(constrain(getDepthSpherical(red(v.depth)/255.0), -_Maximum, 0) * _Displacement);
    return new PVector(returns.x, returns.y, returns.z);
  }

}


class Vert {
  
  PVector co;
  PVector uv;
  PVector n;
  color col;
  color depth;
  
  Vert() {
    co = new PVector(0,0,0);
    col = color(0);
    depth = color(0);
    n = co.copy().normalize();
    uv = getUv(co);
  }
  
  Vert(PVector _co) {
    co = _co;
    col = color(0);
    depth = color(0);
    n = co.copy().normalize();
    uv = getUv(co);
  }
  
  Vert(PVector _co, color _col) {
    co = _co;
    col = _col;
    depth = color(0);
    n = co.copy().normalize();
    uv = getUv(co);
  }
  
  Vert(PVector _co, PVector _uv) {
    co = _co;
    col = color(0);
    depth = color(0);
    n = co.copy().normalize();
    uv = _uv;
  }

  Vert(PVector _co, PVector _uv, color _col) {
    co = _co;
    col = _col;
    depth = color(0);
    n = co.copy().normalize();
    uv = _uv;
  }
  
  Vert(float x, float y, float z) {
    co = new PVector(x, y, z);
    col = color(0);
    depth = color(0);
    n = co.copy().normalize();
    uv = getUv(co);
  }
  
  Vert(float x, float y, float z, color _col) {
    co = new PVector(x, y, z);
    col = _col;
    depth = color(0);
    n = co.copy().normalize();
    uv = getUv(co);
  }
  
  Vert(float x, float y, float z, float u, float v) {
    co = new PVector(x, y, z);
    col = color(0);
    depth = color(0);
    n = co.copy().normalize();
    uv = new PVector(u, v);
  }

  Vert(float x, float y, float z, float u, float v, color _col) {
    co = new PVector(x, y, z);
    col = _col;
    depth = color(0);
    n = co.copy().normalize();
    uv = new PVector(u, v);
  }
  
  PVector getUv(PVector p) {
    p = new PVector(p.z, p.y, p.x).normalize();
    float u = 0.5 + (atan2(p.x, p.z) / (2 * PI)); 
    float v = 0.5 - (asin(p.y) / PI);

    return new PVector(0.5 + u, v);
  }
  
  PVector getXyz(float u, float v) {
    float theta = u * 2.0 * PI;
    float phi = (v - 0.5) * PI;
    float c = cos(phi);
    return new PVector(c * cos(theta), sin(phi), c * sin(theta));
  }
  
}
