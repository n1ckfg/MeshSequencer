import peasy.PeasyCam;

PeasyCam cam;

//String fileName = "test.ply"; // obj or ply
//String rgbFilename = "eqr-rgb-small.jpg"; //output-rgb.png";
//String depthFilename = "eqr-depth-small.jpg"; //"output-depth.png";
boolean isEqr = true;

MeshImg result;
VertSphere resultEqr;
int detail = 100;
PImage rgb, depth;
PShader c2d_shader;

void setup() {
  size(1280, 720, P3D);
  fileSetup();
  processResult();
}

void processResult() {
  rgb = img.get(0, 0, img.width, img.height/2); //loadImage(rgbFilename);
  depth = img.get(0, img.height/2, img.width, img.height/2); //loadImage(depthFilename);
  cam = new PeasyCam(this, 400);
  println("Loading result...");
  
  if (!isEqr) {
    setupShaders(640, 480);   
    updateShaders();
  
    if (isColorDepth(depth)) {  
      PGraphics gfx = createGraphics(depth.width, depth.height, P2D);
      gfx.beginDraw();
      gfx.image(depth, 0, 0);
      gfx.filter(shader_c2d);
      gfx.endDraw();
      depth = gfx.get(0, 0, gfx.width, gfx.height);
    }
    
    if (doInpainting) {         
      initMask();
      processMask();
      targetImg.save("render/depth_test.png");
      depth = targetImg.get(0, 0, targetImg.width, targetImg.height);
    }

    result = new MeshImg(depth, rgb);
    exportObj(fileName, depth, rgb);
  } else {
    //rgb.save("rgb.png");
    //depth.save("depth.png");
    resultEqr = new VertSphere(rgb, depth, detail);
    exportObjEqr(fileName, depth, rgb);
  }
}

void draw() {
  background(0, 0, 127);
  lights();
  pushMatrix();
  if (!isEqr) {
    translate(width/2, height/2, -500);
    scale(1000,1000,1000);
    rotateX(radians(180));
    rotateY(radians(90));
    fill(255,0,0);
    stroke(255);
    strokeWeight(10);
    result.draw();
  } else {
    resultEqr.draw();
  }
  popMatrix();
  
  fileLoop();
  
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
