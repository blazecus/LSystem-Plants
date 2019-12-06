class SDragon extends LSystem {
  Stack transform = new Stack();
  
  int steps = 0;
  float somestep = 0.1;
  float xoff = 0.01;
  float wid = 40.0;
  float theta2;
  SDragon() {
    axiom = "FX";
    rule = new HashMap<String, String>();
    rule.put("X", "[0F5X][1F6X][2F7X][3F8X][4F9X]");
    rule.put("F", "FF");
    startLength = 10.0;
    theta = radians(72);  
    theta2 = radians(70);
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
        stroke(255);
        //line(0, 0, 0, -drawLength);
        if(wid > 5){
          wid -= .8;
        }
        box(wid, -drawLength, wid);
        translate(0, -drawLength,0);
      } 
      //else if (step == '1') {
      //  rotateY(theta);
      //  rotateZ(theta2);
      //} 
      //else if (step == '2') {
      //  rotateY(theta * 2);
      //  rotateZ(theta2);
      //} 
      //else if (step == '3'){
      //  rotateY(theta * 3);
      //  rotateZ(theta2);
      //}
      else if (step == '[') {
        transform.push(getMatrix());
      } 
      else if (step == ']') {
        setMatrix((PMatrix)transform.pop());
      }
      else if (step != 'X'){
        int tempplace = Character.getNumericValue(step);
        if (tempplace <= 4){
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