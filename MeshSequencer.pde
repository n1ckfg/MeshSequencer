import peasy.PeasyCam;

PeasyCam cam;

MeshObj battlePod;

void setup() {
  size(640, 480, P3D);
  cam = new PeasyCam(this, 400);
  battlePod = new MeshObj(loadShape("battle_pod_tri.obj"));
}

void draw() {
  background(0);
  lights();
  
  pushMatrix();
  translate(width/2, height/2, -500);
  scale(1000, 1000, 1000);
  rotateX(radians(180));
  rotateY(radians(90));
  battlePod.draw();
  popMatrix();
}
