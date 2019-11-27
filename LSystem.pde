class LSystem {

  int steps = 0;

  String axiom;
  HashMap<String, String> rule;
  String production;

  float startLength;
  float drawLength;
  float theta;

  int generations;

  LSystem() {

    axiom = "F";
    rule = new HashMap<String, String>();
    rule.put("F", "F+F-F");
    startLength = 90.0;
    theta = radians(120.0);
    reset();
  }

  void reset() {
    production = axiom;
    drawLength = startLength;
    generations = 0;
  }

  int getAge() {
    return generations;
  }
  
  void render() {
    translate(width/2, height/2);
    steps += 5;          
    if (steps > production.length()) {
      steps = production.length();
    }
    for (int i = 0; i < steps; i++) {
      char step = production.charAt(i);
      if (step == 'F') {
        rect(0, 0, -drawLength, -drawLength);
        noFill();
        translate(0, -drawLength);
      } 
      else if (step == '+') {
        rotate(theta);
      } 
      else if (step == '-') {
        rotate(-theta);
      } 
      else if (step == '[') {
        pushMatrix();
      } 
      else if (step == ']') {
        popMatrix();            
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

    //println(rule);
    for (int i = 0; i < prod_.length(); i++){
      String t = prod_.substring(i, i+1);
      if(rule.containsKey(t)){
        newProduction += rule.get(t);
      }
      else{
        newProduction += t;
      }
    }
    return newProduction;
  }
}
