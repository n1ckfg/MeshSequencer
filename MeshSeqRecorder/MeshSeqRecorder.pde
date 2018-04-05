import peasy.PeasyCam;
import nervoussystem.obj.*;

boolean alwaysOn = true;
int fps = 12;

PeasyCam cam;

MeshObj battlePod;

String fileName = "pod";
int fileCounter = 0;

void setup() {
  size(640, 480, P3D);
  if (alwaysOn) frameRate(fps);
  cam = new PeasyCam(this, 400);
  battlePod = new MeshObj(loadShape("battle_pod_tri.obj"));
  
  if (alwaysOn) isRecording = true;
}

void draw() {
  background(0);
  lights();
  
  pushMatrix();
  translate(width/2, height/2, -500);
  scale(1000, 1000, 1000);
  rotateX(radians(180));
  rotateY(radians(90));
      
  if(isRecording) {
    beginRecord("nervoussystem.obj.OBJExport", "render/" + fileName + "_" + zeroPadding(fileCounter, 1000) + ".obj"); 
  }  
  
  battlePod.draw();
  
  if (isRecording) {
    endRecord();
    fileCounter++;
    if (!alwaysOn) isRecording = false;
  }
  
  popMatrix();
  
  surface.setTitle(""+frameRate);
}

String zeroPadding(int _val, int _maxVal){
  String q = ""+_maxVal;
  return nf(_val,q.length());
}
