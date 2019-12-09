import java.util.Map;
import java.util.Stack;
import queasycam.*;

QueasyCam cam;

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
SDragonRandom sr;

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
  cam.speed = 5;
  cam.sensitivity = .5;
  cam.position = new PVector(-200.0,-300,0.0);
  pl = new Plant();
  pl.simulate(5);
  cher = new Cherry();
  cher.simulate(4);
  
  test3d = new Plant3D();
  test3d.simulate(4);
  
  testdragon = new DragonTree();
  testdragon.simulate(4);
  
  s = new SDragon();
  s.simulate(4);
  
  sr = new SDragonRandom();
  sr.simulate(5);
  //print(testdragon.production);
  //pl.renderAtFinal();
  //spl = new StochasticPlant();
  //spl.simulate(5);
  //background(0);
  //spl.renderAtFinal();
  background(0);


}

void draw() {
  background(0);
  //noStroke();
  //directionalLight(1000, 1000000, 1000, -1, -1, 0);
  //pushMatrix();
  //translate(0,500,0);
  //box(10000.0,4.0,100000.0);
  //popMatrix();
  //pointLight(170, 250, 200, 500, 500, 500);
  fill(255);
  //test3d.renderAtFinal();
  //testdragon.renderAtFinal();
  //cher.renderAtFinal();
  sr.renderAtFinal();
  //drawManyLeaves(10);
  //pl.renderAtFinal();

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

void keyPressed(){
  //if(event.key == ){
    
  //}
  println(key);
  if(key == 'w'){
    float[] temp = {currentcampos[0], currentcampos[1] + 40,currentcampos[2]};
    currentcampos = temp;
    //print(currentcampos);
  }
} 


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
