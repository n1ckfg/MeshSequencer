String fileName = "test.ply"; // obj or ply
String rgbFilename = "rgb.png";
String depthFilename = "depth.png";
PShape result; // note this only works with obj
boolean viewResult = false;

void setup() {
  size(800, 600, P3D);
  exportObj(fileName, loadImage(depthFilename), loadImage(rgbFilename));
  
  if (viewResult) {
    cam = new PeasyCam(this, 400);
    println("Loading result...");
    result = loadShape(fileName);
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
  
  shape(result, 0, 0);
  
  popMatrix();
  
  surface.setTitle(""+frameRate);
}
