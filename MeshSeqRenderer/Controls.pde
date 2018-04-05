void keyPressed() {
  if (key=='r'||key=='R') {
    isPlaying = false;
    jr.render(); //Press 'r' key to start rendering.
    isRendering = true;  
  }
  
  if (!isRendering && (key == 'p' || key == 'P')) {
    isPlaying = !isPlaying;
  }
  
}
