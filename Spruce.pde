class Spruce extends LSystem {
  Stack transform = new Stack();

  int steps = 0;
  float somestep = 0.1;
  float xoff = 0.01;
  float wid = 40.0;
  float theta2;
  float theta3;
  float theta4;

  float[] drawRange = {.9, 1.1};
  float[] thetaRange = {.9, 1.1};
  float[] theta2Range = {.9, 1.1};

  float[] theta3Range = {.9, 1.1};
  float[] theta4Range = {.9, 1.1};

  int widcount = 0;

  float[] wids = {2.0, 1.6, 1.2, .8, .4, .2};

  //float fChance = .7;

  HashMap<String, Float> chanceRule = new HashMap<String, Float>();

  HashMap<Integer, Float> tchance = new HashMap<Integer, Float>();
  HashMap<Integer, Float> t2chance = new HashMap<Integer, Float>();

  HashMap<Integer, Float> t3chance = new HashMap<Integer, Float>();
  HashMap<Integer, Float> t4chance = new HashMap<Integer, Float>();

  HashMap<Integer, Float> drawchance = new HashMap<Integer, Float>();

  float trunk = 10.0;
  float branch = 5.0;


  PImage tex = loadImage("wood.png");

  Spruce() {
    axiom = "FFFFX";
    rule = new HashMap<String, String>();
    rule.put("X", "[1Z][2Z][3Z][4Z][5Z][6Z]FX");
    chanceRule.put("F", .6);
    chanceRule.put("X", 1.0);
    chanceRule.put("L", .03);
    ;
    chanceRule.put("Z", .5);
    ;


    rule.put("Z", "L[7Z][8Z]L[7Z][8Z]LLZ");
    rule.put("L", "LL");
    startLength = 10.0;
    theta = radians(60);  
    theta2 = radians(70);

    theta3 = radians(20);
    theta4 = radians(50);
    reset();
    //transform.push("hello");
  }
  void reset() {
    production = axiom;
    drawLength = startLength;
    generations = 0;
  }
  void renderAtFinal() {
    int fcount = 0;
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
          newl = random(drawRange[0], drawRange[1]) * trunk;
          drawchance.put(i, newl);
        }

        //drawing and translating
        noStroke();
        TexturedCube(tex, 10 - fcount * .25, -newl, 10 - fcount*.25);
        translate(0, -newl, 0);
        fcount++;
      } 

      //not forward, for leaves
      else if (step == 'L') {
        noFill();
        //noStroke();
        //stroke(255);
        float newl;
        if (drawchance.containsKey(i)) {
          newl = drawchance.get(i);
        } else {
          newl = random(drawRange[0], drawRange[1]) * branch;
          drawchance.put(i, newl);
        }

        //drawing and translating
        noStroke();
        TexturedCube(tex, .5, -newl, .5);
        translate(0, -newl, 0);
      } 

      //saving spots
      else if (step == '[') {
        transform.push(getMatrix());
        widcount++;
      } else if (step == ']') {
        setMatrix((PMatrix)transform.pop());
        widcount--;
      } else if (step == 'Z') {
        //drawLeaf();
        //continue;
      }
      //recursive step
      else if (step != 'X') {
        int tempplace = Character.getNumericValue(step);
        float newt, newt2;

        //getting angles

        if (tempplace > 0 && tempplace <= 6) {
          if (tchance.containsKey(i)) {
            newt = tchance.get(i);
            newt2 = t2chance.get(i);
          } else {
            newt = random(thetaRange[0], thetaRange[1]) * theta;
            newt2 = random(theta2Range[0], theta2Range[1]) * theta2;
            tchance.put(i, newt);
            t2chance.put(i, newt2);
          }
          rotateY(newt * tempplace);
          rotateX(theta2);
        } else {
          if (t3chance.containsKey(i)) {
            newt = t3chance.get(i);
            newt2 = t4chance.get(i);
          } else {
            newt = random(theta3Range[0], theta3Range[1]) * theta;
            newt2 = random(theta4Range[0], theta4Range[1]) * theta2;
            t3chance.put(i, newt);
            t4chance.put(i, newt2);
          }
          if (tempplace == 7) {
            rotateZ(newt2);
          } else {
            rotateZ(-newt2);
          }
          //rotateY(newt);
        }
        //rotation





        //else if (tempplace == 7) {
        //  rotateX(random(radians(75), radians(105)));
        //} else if (tempplace == 8) {
        //  rotateX(random(radians(165), radians(195)));
        //}
        //else if (tempplace == 9) {
        //  rotateX(random(radians(255), radians(265)));

        //}
        //else if (tempplace == 0) {
        //  rotateX(random(radians(345), radians(375)));

        //}
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
    int lcount = 0;
    for (int i = 0; i < prod_.length(); i++) {
      String t = prod_.substring(i, i+1);
      if (t.equals("[")) {
        wcount++;
      } else if (t.equals("]")) {
        wcount--;
      }
      else if(t.equals("L")){
        lcount++;
      }
      if (rule.containsKey(t)) {
        if (chanceRule.containsKey(t)) {
          if (random(1) < chanceRule.get(t)) {
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
