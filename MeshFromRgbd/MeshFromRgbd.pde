import peasy.PeasyCam;

PeasyCam cam;

String fileName = "test.ply"; // obj or ply
String rgbFilename = "rgb.png";
String depthFilename = "depth.png";
MeshImg result;
PImage rgb, depth;

void setup() {
  size(1280, 720, P3D);
  rgb = loadImage(rgbFilename);
  depth = loadImage(depthFilename);
  
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
