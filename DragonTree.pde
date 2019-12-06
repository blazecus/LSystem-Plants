class DragonTree extends LSystem {
  Stack transform = new Stack();
  
  int steps = 0;
  float somestep = 0.1;
  float xoff = 0.01;
  float wid = 2;
  float theta2;
  
  float drawLength = 40.0;
  
  DragonTree() {
    axiom = "FX";
    rule = new HashMap<String, String>();
    rule.put("X", "[1X][2X][3X][4X][5X]");
    rule.put("F", "FF");
    
    rule.put("1", "11");
    rule.put("2", "22");
    rule.put("3", "33");
    rule.put("4", "44");
    rule.put("5", "55");
    startLength = 10.0;
    theta = radians(72);  
    theta2 = radians(70);
    reset();
    //transform.push("hello");
  }
  void reset() {
    production = axiom;
    drawLength = (float)startLength;
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

        if (tempplace <= 5){
          //pushMatrix();
          //PMatrix temp = getMatrix();
          //resetMatrix();
          //rotateY(theta * tempplace);
          //rotateZ(theta2);
          //PMatrix rotate = getMatrix();
          //rotate.invert();
          //setMatrix(temp);
          
          
          rotateY(theta * tempplace);
          rotateZ(theta2);
          noFill();
          stroke(255);
          //line(0, 0, 0, -drawLength);

          box(wid, -drawLength, wid);
          translate(0, -drawLength, 0);
          //print(rotate);
          //print(getMatrix());
          //PMatrix t = getMatrix().preApply(rotate);
          //setMatrix(getMatrix().apply(rotate));

          //popMatrix();
          //translate(sin(theta * (tempplace -1)) * sin(theta2) * -drawLength, cos(theta2) * -drawLength, cos(theta * (tempplace -1)) * sin(theta2) * -drawLength);
        }

      }
    }
  }
}
