import java.util.Map;
import java.util.Stack;

PentigreeLSystem ps;
Koch test;
Serpinski serp;
Dragon drag;
Plant pl;
StochasticPlant spl;
Plant3D test3d;
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
  pl = new Plant();
  pl.simulate(5);
  
  test3d = new Plant3D();
  test3d.simulate(4);
  

  //pl.renderAtFinal();
  //spl = new StochasticPlant();
  //spl.simulate(5);
  //background(0);
  //spl.renderAtFinal();
  background(0);


}

void draw() {
  //background(0);
  translate(width/2, height/2, 0);
  rotateX(map(mouseY, 0, height, -PI, PI));
  rotateY(map(mouseX, 0, width, -PI, PI));
  test3d.renderAtFinal();

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
    print(currentcampos);
  }
} 
