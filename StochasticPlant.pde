class StochasticPlant extends LSystem {
  Stack transform = new Stack();
  
  int steps = 0;
  float somestep = 0.1;
  float xoff = 0.01;
  float ran;
  StochasticPlant() {
    axiom = "X";
    rule = new HashMap<String, String>();
    rule.put("X", "F+[[X+]-X]-F[-FX]+X-[+X+[X+]]");
    rule.put("F", "FF");
    startLength = 10.0;
    theta = 25;  
    ran = .4;
    reset();
    //transform.push("hello");
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
    translate(width/2, height-200);
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
        rotate(radians(random((1-ran) * theta, (1+ran) * theta)));
      } 
      else if (step == '-') {
        rotate(-radians(random((1-ran) * theta, (1+ran) * theta)));
      } 
      else if (step == '[') {
        transform.push(getMatrix());
      } 
      else if (step == ']') {
        setMatrix((PMatrix)transform.pop());
      }
    }
  }
  void renderAtFinal(){
    translate(width/2, height-200);

    for (int i = 0; i < production.length(); i++) {
      char step = production.charAt(i);
      if (step == 'F' || step == 'G') {
        noFill();
        stroke(255);
        float leng = -drawLength * random(1-ran, 1+ran);
        line(0, 0, 0, leng);
        translate(0, leng);
      } 
      else if (step == '+') {
        rotate(radians(random(1-ran, 1+ran) * theta));
      } 
      else if (step == '-') {
        rotate(-radians(random(1-ran, 1+ran) * theta));
      } 
      else if (step == '[') {
        transform.push(getMatrix());
      } 
      else if (step == ']') {
        setMatrix((PMatrix)transform.pop());
      }
    }
  }
}
