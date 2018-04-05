MeshObj[] objs;

int playbackCounter = 0;
float playbackFps = 12.0;
float playbackInterval = 0.0;
int lastMillis = 0;
boolean isPlaying = false;

void setup() {
  size(800, 600, P3D);

  fileSetup();
  joonsSetup();
  
  objs = new MeshObj[imgNames.size()];
  for(int i=0; i<objs.length; i++) {
    objs[i] = new MeshObj(loadShape(""+imgNames.get(i)));
  }
  
  playbackFps = 1.0/playbackFps;
  lastMillis = millis();
}

void draw() {
  joonsBeginRender();
  
  pushMatrix();
  translate(-40, -100, -140);
  jr.fill("light", 0, 5, 0);
  sphere(20);
  popMatrix();
  
  pushMatrix();
  translate((width/2) - 200, (height/2) - 300, -1500);
  scale(800, 800, 800);
  rotateX(radians(180));
  rotateY(radians(90));

  jr.fill("shiny", 50, 255, 255);
  objs[playbackCounter].draw();
  
  popMatrix();
  joonsEndRender();
  
  if (isPlaying) {
    playbackInterval += (float) ((millis() - lastMillis) / 1000.0);
    if (playbackInterval > playbackFps) {
      playbackInterval = 0.0;
      playbackCounter++;
      if (playbackCounter > objs.length-1) playbackCounter = 0;
    }
  }

  surface.setTitle(""+frameRate);
  lastMillis = millis();
}
