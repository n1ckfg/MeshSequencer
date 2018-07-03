PShader shader_d2c, shader_c2d;

PVector shaderMousePos = new PVector(0,0);
PVector shaderMouseClick = new PVector(0,0);

void setupShaders() {
  shader_c2d = loadShader("color_depth.glsl"); 
  shader_d2c = loadShader("depth_color.glsl"); 
  
  shaderSetSize(shader_c2d);
  shaderSetSize(shader_d2c);
}

void updateShaders() {
    shaderSetTexture(shader_d2c, "tex0", depth);
    shaderSetTexture(shader_c2d, "tex0", depth);
}

//void drawShaders() {
  //filter(shader);
//}

// ~ ~ ~ ~ ~ ~ ~

void shaderSetVar(PShader ps, String name, float val) {
    ps.set(name, val);
}

void shaderSetSize(PShader ps) {
  ps.set("iResolution", float(width), float(height), 1.0);
}

void shaderSetMouse(PShader ps) {
  if (mousePressed) shaderMousePos = new PVector(mouseX, height - mouseY);
  ps.set("iMouse", shaderMousePos.x, shaderMousePos.y, shaderMouseClick.x, shaderMouseClick.y);
}

void shaderSetTime(PShader ps) {
  ps.set("iGlobalTime", float(millis()) / 1000.0);
}

void shaderMousePressed() {
  shaderMouseClick = new PVector(mouseX, height - mouseY);
}

void shaderMouseReleased() {
  shaderMouseClick = new PVector(-shaderMouseClick.x, -shaderMouseClick.y);
}

void shaderSetTexture(PShader ps, String name, PImage tex) {
  ps.set(name, tex);
}
