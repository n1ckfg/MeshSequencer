import peasy.PeasyCam;

PeasyCam cam;

String fileName = "test.ply"; // obj or ply
String rgbFilename = "output-rgb.png";
String depthFilename = "output-depth.png";
MeshImg result;
PImage rgb, depth;
PShader c2d_shader;

void setup() {
  size(1280, 720, P3D);
  setupShaders();

  rgb = loadImage(rgbFilename);
  depth = loadImage(depthFilename);
  
  if (isColorDepth(depth)) {
    //
  }
   
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

boolean isColorDepth(PImage img) {
  int colorCount = 0;
  img.loadPixels();
  for (int i=0; i<10; i++) {
    int x = (int) random(img.width);
    int y = (int) random(img.height );
    int loc = x + y * img.width;
    color c = img.pixels[loc];
    if (red(c) != green(c) && red(c) != blue(c)) colorCount++; 
  }
  if (colorCount>5) {
    println("Found color depth image.");
    return true;
  } else {
    println("Found grayscale depth image.");
    return false;
  }
}

PImage colorToDepth(PImage img) {
  PGraphics gfx = createGraphics(img.width, img.height, P2D);
  gfx.beginDraw();
  gfx.image(img, 0, 0);
  gfx.filter(c2d_shader);
  gfx.endDraw();
  return gfx.get(0, 0, gfx.width, gfx.height);
}
