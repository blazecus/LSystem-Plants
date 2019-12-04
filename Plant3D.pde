class Plant3D extends LSystem {
  Stack transform = new Stack();
  
  int steps = 0;
  float somestep = 0.1;
  float xoff = 0.01;
  float wid = 40.0;
  
  Plant3D() {
    axiom = "X";
    rule = new HashMap<String, String>();
    rule.put("X", "F+[[X+]-X]-F[-FX]+X-[+X+[X+]]");
    rule.put("F", "FF");
    startLength = 10.0;
    theta = radians(25);  
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
    translate(0,0,0);
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
        transform.push(getMatrix());
      } 
      else if (step == ']') {
        setMatrix((PMatrix)transform.pop());
      }
    }
  }
  void renderAtFinal(){
    //translate(width/2, height-200);
    
    for (int i = 0; i < production.length(); i++) {
      char step = production.charAt(i);
      if (step == 'F' || step == 'G') {
        noFill();
        stroke(255);
        //line(0, 0, 0, -drawLength);
        if(wid > 5){
          wid -= .8;
        }
        box(wid, -drawLength, wid);
        translate(0, -drawLength,0);
      } 
      else if (step == '+') {
        rotateZ(theta);
        rotateX(1.5 * theta);
      } 
      else if (step == '-') {
        rotateZ(-theta);
        rotateX(-1.5 * theta);
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
