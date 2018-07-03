import peasy.PeasyCam;

PeasyCam cam;

String fileName = "test.ply"; // obj or ply
String rgbFilename = "rgb.png";
String depthFilename = "depth3.png";
MeshImg result;
PImage rgb, depth;
PShader d2c_shader, c2d_shader;

void setup() {
  size(1280, 720, P3D);
  setupShaders();

  rgb = loadImage(rgbFilename);
  depth = loadImage(depthFilename);
  
  depth = get(0,0,width,height);
  
  cam = new PeasyCam(this, 400);
  println("Loading result...");
  result = new MeshImg(depth, rgb);

  //exportObj(fileName, depth, rgb);
}

void draw() {
  
  background(0, 0, 127);
  lights();
  pushMatrix();
  translate(width/2, height/2, -500);
  scale(1000,1000,1000);
  rotateX(radians(180));
  rotateY(radians(90));
  fill(255,0,0);
  stroke(255);
  strokeWeight(10);
  result.draw();
  
  popMatrix();
  
  surface.setTitle(""+frameRate);
}

PImage depthToColor(PImage img) {
  PGraphics gfx = createGraphics(img.width, img.height, P2D);
  gfx.beginDraw();
  gfx.image(img, 0, 0);
  gfx.filter(d2c_shader);
  gfx.endDraw();
  return gfx.get(0, 0, gfx.width, gfx.height);
}

PImage colorToDepth(PImage img) {
  PGraphics gfx = createGraphics(img.width, img.height, P2D);
  gfx.beginDraw();
  gfx.image(img, 0, 0);
  gfx.filter(c2d_shader);
  gfx.endDraw();
  return gfx.get(0, 0, gfx.width, gfx.height);
}
