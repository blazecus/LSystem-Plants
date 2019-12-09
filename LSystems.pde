import java.util.Map;
import java.util.Stack;

QueasyCam cam;

int w,h;
int twidth, theight;
float[][] terrain;
int scl;

int numtrees = 80;

int[] xtree = new int[numtrees];
int[] ytree = new int[numtrees];

PentigreeLSystem ps;
Koch test;
Serpinski serp;
Dragon drag;
Plant pl;
StochasticPlant spl;
Plant3D test3d;
DragonTree testdragon;
Cherry cher;
SDragon s;
SDZ[] sr = new SDZ[numtrees];

//Stack rendertransform = new Stack();
//boolean lock = false;
//float[] lockpos = {0.0,0.0};

float[] currentcampos = {0.0, 0.0, -50};



void setup() {
  size(2000, 1500, P3D);
  
  //ps = new PentigreeLSystem();
  //ps.simulate(3);
  //test = new Koch();
  //test.simulate(3);
  //serp = new Serpinski();
  //serp.simulate(5);
  //drag = new Dragon();
  //drag.simulate(12);
  cam = new QueasyCam(this);
  
  cam.speed = 20;
  cam.sensitivity = .5;
  cam.position = new PVector(-200.0,-300,0.0);
  
  setupTerrain();
  
  //pl = new Plant();
  //pl.simulate(5);
  //cher = new Cherry();
  //cher.simulate(4);
  
  //test3d = new Plant3D();
  //test3d.simulate(4);
  
  //testdragon = new DragonTree();
  //testdragon.simulate(4);
  
  //s = new SDragon();
  //s.simulate(4);
  for(int i = 0; i < numtrees; i++){
      SDZ tempr = new SDZ();
      tempr.simulate(3);
      sr[i] = tempr;
      xtree[i] = (int)random(50, 150);
      ytree[i] = (int)random(50, 150);
  }

  //print(testdragon.production);
  //pl.renderAtFinal();
  //spl = new StochasticPlant();
  //spl.simulate(5);
  //background(0);
  //spl.renderAtFinal();
  background(0);


}

void draw() {
  background(135,206,235);
  //noStroke();
  //directionalLight(255,255,255,1, 1, 1);
  drawTerrain();
  //pointLight(170, 250, 200, 500, 500, 500);
  //test3d.renderAtFinal();
  //testdragon.renderAtFinal();
  //cher.renderAtFinal();
  //drawManyLeaves(10);
  //pl.renderAtFinal();
  pushMatrix();
  translate(width/2, height/2 + 50);
  rotateX(PI/2);
  
  translate(-w/2, -h/2);
  
  //rotateX(-PI/2);
  for(int i = 0; i < numtrees; i++){

    pushMatrix();
    translate(xtree[i] * scl, ytree[i] * scl, terrain[xtree[i]][ytree[i]]);
    sr[i].renderAtFinal();
    popMatrix();
  }
  popMatrix();
  //ps.render();
  //test.render();
  //serp.render();
  //drag.render();
  //camera(currentcampos[0], currentcampos[1], currentcampos[2], 0,0,0, 0,1,0);
}
//void mousePressed(){
//  if(!lock){
//    lock = true;
//    lockpos =  {mouseX, mouseY};
//  }
//}
//void mouseDragged(){
  
//}
//void mouseReleased(){
  
//}


void TexturedCube(PImage tex, float x, float y, float z) {
  beginShape(QUADS);
  texture(tex);  
  textureMode(NORMAL);
  // +Z "front" face
  vertex(-x, 0,  z, 0, 0);
  vertex( x, 0,  z, 1, 0);
  vertex( x, y,  z, 1, 1);
  vertex(-x, y,  z, 0, 1);

  // -Z "back" face
  vertex( x, 0, -z, 0, 0);
  vertex(-x, 0, -z, 1, 0);
  vertex(-x, y, -z, 1, 1);
  vertex( x, y, -z, 0, 1);

  // +2 * y "bottom" face
  vertex(-x, y,  z, 0, 0);
  vertex( x, y,  z, 1, 0);
  vertex( x, y, -z, 1, 1);
  vertex(-x, y, -z, 0, 1);

  // -Y "top" face
  vertex(-x, 0, -z, 0, 0);
  vertex( x, 0, -z, 1, 0);
  vertex( x, 0,  z, 1, 1);
  vertex(-x, 0,  z, 0, 1);

  // +X "right" face
  vertex( x, 0,  z, 0, 0);
  vertex( x, 0, -z, 1, 0);
  vertex( x,  y, -z, 1, 1);
  vertex( x,  y,  z, 0, 1);

  // -X "left" face
  vertex(-x, 0, -z, 0, 0);
  vertex(-x, 0,  z, 1, 0);
  vertex(-x,  y,  z, 1, 1);
  vertex(-x,  y, -z, 0, 1);

  endShape();
}

void drawLeaf(){
  fill(0,255,100);
  stroke(50, 70, 100);
  beginShape();
  //texture(loadImage("leaf.jpg"));  
  //textureMode(NORMAL);
  vertex(-5,0,3, 1, 0);
  vertex(-3,0,8, 0, 1);
  vertex(0,0,11, 0, 0);
  vertex(3,0, 8, 0, 1);
  vertex(5,0,3, 1, 0);
  vertex(0,0,0, 1, 1);
  endShape();
}

void drawManyLeaves(int numL){
  for(int i = 0; i < numL; i++){
    pushMatrix();
    rotateX(.3 * pow(i,2));
    rotateY(.5 * pow(i,2));
    rotateZ(2 * pow(i,2));
    drawLeaf();
    popMatrix();
  }
}

void setupTerrain(){
  w = 10000;
  h = 10000;
  scl = 50;
  twidth = w/scl;
  theight = h/scl;
  terrain = new float[twidth][theight];
  float yoff = 0;
  for (int i = 0; i < twidth; i++) {
    float xoff = 0;
    for (int j = 0; j < theight; j ++) {
      terrain[i][j] = map(noise(xoff, yoff), 0, 1, -300, 300);
      xoff += .1;
    }
    yoff += .1;  
  }
}

void drawTerrain(){
  noStroke();
  pushMatrix();
  translate(width/2, height/2 + 50);
  rotateX(PI/2);
  
  translate(-w/2, -h/2);
  
  for (int i = 0; i < twidth-1; i++) {
    beginShape(TRIANGLE_STRIP);
    for (int j = 0; j < theight-1; j ++) {
      fill(0, map(terrain[j][i], -200, 200, 0, 255), 100);
      vertex(j * scl, i * scl, terrain[j][i]);
      fill(0, map(terrain[j][i+1], -200, 200, 0, 255), 100);
      vertex(j * scl, (i+1) * scl, terrain[j][i+1]);
    }
    endShape();
  }
  translate(width/2, height/2);
  rotateX(PI/2);
  popMatrix();
}
