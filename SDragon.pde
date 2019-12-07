class SDragon extends LSystem {
  Stack transform = new Stack();
  
  int steps = 0;
  float somestep = 0.1;
  float xoff = 0.01;
  float wid = 40.0;
  float theta2;
  
  float[] drawRange = {.5, 1.3};
  float[] thetaRange = {.7, 1.3};
  float[] theta2Range = {.7, 1.3};
  
  //float fChance = .7;
  
  HashMap<String, Float> chanceRule = new HashMap<String, Float>();
  
  PImage tex = loadImage("wood.png");

  SDragon() {
    axiom = "FX";
    rule = new HashMap<String, String>();
    rule.put("X", "[0F5X][1F6X][2F7X][3F8X][4F9X]");
    chanceRule.put("F", .7);
    chanceRule.put("X", .9);
    rule.put("F", "FF");
    startLength = 10.0;
    theta = radians(72);  
    theta2 = radians(60);
    reset();
    //transform.push("hello");
  }
  void reset() {
    production = axiom;
    drawLength = startLength;
    generations = 0;
  }
  void renderAtFinal(){
    for (int i = 0; i < production.length(); i++) {
      char step = production.charAt(i);
      if (step == 'F' || step == 'G') {
        noFill();
        //noStroke();
        stroke(255);
        if(wid > 5){
          wid -= .8;
        }
        TexturedCube(tex, wid, -drawLength, wid);
        translate(0, -drawLength,0);
      } 
      else if (step == '[') {
        transform.push(getMatrix());
      } 
      else if (step == ']') {
        setMatrix((PMatrix)transform.pop());
      }
      else if (step != 'X'){
        int tempplace = Character.getNumericValue(step) + 1;
        if (tempplace <= 5){
          rotateY(theta * tempplace);
          rotateZ(theta2);
        }
        else{
          rotateZ(TWO_PI - theta2);
          rotateY(TWO_PI - (theta * (tempplace - 5)));
        }
      }
    }
  }
}
