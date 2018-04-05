import peasy.PeasyCam;

PeasyCam cam;

PShape[] objs;

int playbackCounter = 0;
float playbackFps = 12.0;
float playbackInterval = 0.0;
int lastMillis = 0;
boolean isPlaying = false;

void setup() {
  size(800, 600, P3D);
  cam = new PeasyCam(this, 400);

  fileSetup();
  joonsSetup();
  
  objs = new PShape[imgNames.size()];
  for(int i=0; i<objs.length; i++) {
    objs[i] = loadShape(""+imgNames.get(i));
  }
  
  playbackFps = 1.0/playbackFps;
  lastMillis = millis();
}

void draw() {
  joonsBeginRender();
  
  pushMatrix();
  translate(width/2, height/2, -500);
  scale(1000, 1000, 1000);
  rotateX(radians(180));
  rotateY(radians(90));

  shape(objs[playbackCounter], 0, 0);
  
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
