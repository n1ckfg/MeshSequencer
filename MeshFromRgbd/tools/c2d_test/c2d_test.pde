String depthFilename = "depth3.png";
PImage depth;

void setup() {
  size(1280, 720, P2D);
  
  depth = loadImage(depthFilename);
  
  setupShaders();
  updateShaders();
}

void draw() {
  filter(shader_c2d);
}
