String fileName = "test.ply"; // obj or ply
String rgbFilename = "rgb.png";
String depthFilename = "depth.png";
MeshImg result;
boolean viewResult = true;
PImage rgb, depth;

void setup() {
  size(800, 600, P3D);
  rgb = loadImage(rgbFilename);
  depth = loadImage(depthFilename);
  exportObj(fileName, depth, rgb);
  
  if (viewResult) {
    cam = new PeasyCam(this, 400);
    println("Loading result...");
    result = new MeshImg(depth);
  } else {
    exit();
  }
}

import peasy.PeasyCam;

PeasyCam cam;

void draw() {
  background(0);
  lights();
  
  pushMatrix();
  translate(width/2, height/2, -500);
  scale(1,1,1);
  rotateX(radians(180));
  rotateY(radians(90));
  
  shape(result.shape, 0, 0);
  
  popMatrix();
  
  surface.setTitle(""+frameRate);
}
