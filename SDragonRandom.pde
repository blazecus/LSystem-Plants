class SDragonRandom extends LSystem {
  Stack transform = new Stack();
  
  int steps = 0;
  float somestep = 0.1;
  float xoff = 0.01;
  float wid = 40.0;
  float theta2;
  
  float[] drawRange = {.9, 1.1};
  float[] thetaRange = {.9, 1.1};
  float[] theta2Range = {.9, 1.1};
  
  int widcount = 0;
  
  //float fChance = .7;
  
  HashMap<String, Float> chanceRule = new HashMap<String, Float>();
  
  HashMap<Integer, Float> tchance = new HashMap<Integer, Float>();
  HashMap<Integer, Float> t2chance = new HashMap<Integer, Float>();
  HashMap<Integer, Float> drawchance = new HashMap<Integer, Float>();


  
  
  PImage tex = loadImage("wood.png");

  SDragonRandom() {
    axiom = "FX";
    rule = new HashMap<String, String>();
    rule.put("X", "[0F5X][1F6X][2F7X][3F8X][4F9X]");
    chanceRule.put("F", .85);
    chanceRule.put("X", .7);
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
        float newl;
        if(drawchance.containsKey(i)){
          newl = drawchance.get(i);
        }
        else{
          newl = random(drawRange[0], drawRange[1]) * drawLength;
          drawchance.put(i, newl);
        }
        wid = 16 - 3 * widcount;
        TexturedCube(tex, wid/2, -newl, wid/2);
        translate(0, -newl,0);
      } 
      else if (step == '[') {
        transform.push(getMatrix());
        widcount++;
      } 
      else if (step == ']') {
        setMatrix((PMatrix)transform.pop());
        widcount--;
      }
      else if (step != 'X'){
        int tempplace = Character.getNumericValue(step) + 1;
        float newt, newt2;
        if(tchance.containsKey(i)){
          newt = tchance.get(i);
          newt2 = t2chance.get(i);
        }
        else{
          newt = random(thetaRange[0], thetaRange[1]) * theta;
          newt2 = random(theta2Range[0], theta2Range[1]) * theta2;
          tchance.put(i, newt);
          t2chance.put(i, newt2);
        }

        if (tempplace <= 5){
          rotateY(newt * tempplace);
          rotateZ(newt2);
        }
        else{
          rotateZ(TWO_PI - newt2);
          rotateY(TWO_PI - (newt * (tempplace - 5)));
        }
      }
    }
  }
  
  void simulate(int gen) {
    while (getAge() < gen) {
      production = iterate(production);
    }  
  }

  String iterate(String prod_) {
    //drawLength = drawLength * 0.6;
    generations++;
    String newProduction = "";  

    for (int i = 0; i < prod_.length(); i++){
      String t = prod_.substring(i, i+1);
      if(rule.containsKey(t)){
        if(chanceRule.containsKey(t)){
          if(random(1) < chanceRule.get(t)){
            newProduction += rule.get(t);
          }
          else{
            newProduction += t;
          }
        }
        else{
          newProduction += rule.get(t);
        }
      }
      else{
        newProduction += t;
      }
    }
    return newProduction;
  }
}
