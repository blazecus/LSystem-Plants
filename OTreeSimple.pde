class OTreeSimple extends LSystem {
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

  float[] wids = {1.0, .6, .4, .3, .2, .1};

  //float fChance = .7;

  HashMap<String, Float> chanceRule = new HashMap<String, Float>();

  HashMap<Integer, Float> tchance = new HashMap<Integer, Float>();
  HashMap<Integer, Float> t2chance = new HashMap<Integer, Float>();
  HashMap<Integer, Float> drawchance = new HashMap<Integer, Float>();

  HashMap<Integer, Float> bendX = new HashMap<Integer, Float>();
  HashMap<Integer, Float> bendY = new HashMap<Integer, Float>();
  HashMap<Integer, Float> bendZ = new HashMap<Integer, Float>();





  PImage tex = loadImage("wood.png");

  OTreeSimple() {
    axiom = "X";
    rule = new HashMap<String, String>();
    rule.put("X", "F[1X]F[2X][3X]F[1X][2X]X");
    chanceRule.put("F", .6);
    chanceRule.put("X", .7);
    rule.put("F", "FF");
    startLength = 10.0;
    theta = radians(120);  
    theta2 = radians(30);
    reset();
    //transform.push("hello");
  }
  void reset() {
    production = axiom;
    drawLength = startLength;
    generations = 0;
  }
  void renderAtFinal() {
    for (int i = 0; i < production.length(); i++) {
      char step = production.charAt(i);


      //moving forward
      if (step == 'F') {
        noFill();
        //noStroke();
        //stroke(255);
        float newl;
        if (drawchance.containsKey(i)) {
          newl = drawchance.get(i);
        } else {
          newl = random(drawRange[0], drawRange[1]) * drawLength;
          drawchance.put(i, newl);
        }

        //drawing and translating
        noStroke();
        if(i > 20){
          if (!bendX.containsKey(i)) {
            bendX.put(i, random(-.05, .05));
            bendY.put(i, random(-.05, .05));
            bendZ.put(i, random(-.05, .05));
          }
          rotateX(bendX.get(i));
          rotateY(bendY.get(i));
          rotateZ(bendZ.get(i));
        }
        TexturedCube(tex, wids[widcount], -newl, wids[widcount]);
        translate(0, -newl, 0);
      } 


      //saving spots
      else if (step == '[') {
        transform.push(getMatrix());
        widcount++;
      } else if (step == ']') {
        setMatrix((PMatrix)transform.pop());
        widcount--;
      } else if (step == 'X') {
        drawManyLeaves(7);
        //drawLeaf();
        //continue;
      }
      //recursive step
      else if (step != 'X') {
        int tempplace = Character.getNumericValue(step) + 1;
        float newt, newt2;

        //getting angles
        if (tchance.containsKey(i)) {
          newt = tchance.get(i);
          newt2 = t2chance.get(i);
        } else {
          newt = random(thetaRange[0], thetaRange[1]) * theta;
          newt2 = random(theta2Range[0], theta2Range[1]) * theta2;
          tchance.put(i, newt);
          t2chance.put(i, newt2);
        }

        //rotation
        if (tempplace <= 5) {
          rotateY(newt * tempplace);
          rotateZ(newt2);
        } else {
          rotateZ(TWO_PI - newt2);
          rotateY(TWO_PI - (newt * (tempplace - 5)));
        }
      }
    }
  }

  void simulate(int gen) {
    wids = new float[] {wids[0] * gen, wids[1] * gen, wids[2] * gen, wids[3] * gen, wids[4] * gen, wids[5] * gen};
    while (getAge() < gen) {
      production = iterate(production);
    }
  }

  String iterate(String prod_) {
    //drawLength = drawLength * 0.6;
    generations++;
    String newProduction = "";  

    int wcount = 0;
    for (int i = 0; i < prod_.length(); i++) {
      String t = prod_.substring(i, i+1);

      if (t.equals("[")) {
        wcount++;
      } else if (t.equals("]")) {
        wcount--;
      }
      if (rule.containsKey(t)) {
        if (chanceRule.containsKey(t)) {
          if (random(1) < chanceRule.get(t) + wcount/25) {
            newProduction += rule.get(t);
          } else {
            newProduction += t;
          }
        } else {
          newProduction += rule.get(t);
        }
      } else {
        newProduction += t;
      }
    }
    return newProduction;
  }
}
