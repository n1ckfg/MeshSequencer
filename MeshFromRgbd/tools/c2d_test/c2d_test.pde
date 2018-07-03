String depthFilename = "depth3.png";
PImage depth;

void setup() {
  size(640, 360, P2D);
  
  depth = loadImage(depthFilename);
  
  setupShaders();
  updateShaders();
}

void draw() {
  filter(shader_c2d);
  saveFrame("output.png");
  exit();
}
