class Dragon extends LSystem {

  int steps = 0;
  float somestep = 0.1;
  float xoff = 0.01;

  Dragon() {
    axiom = "FX";
    rule = new HashMap<String, String>();
    rule.put("X", "X+YF+");
    rule.put("Y", "-FX-Y");
    startLength = 30.0;
    theta = radians(90);  
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
    translate(width/4, height/2);
    steps += 3;          
    if (steps > production.length()) {
      steps = production.length();
    }

    for (int i = 0; i < steps; i++) {
      char step = production.charAt(i);
      if (step == 'F' || step == 'G') {
        noFill();
        stroke(255);
        line(0, 0, 0, -drawLength);
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

}
