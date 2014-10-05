/*Comp150VIZ HW4 - Squarified Treemaps
  Robert Ruenes
  2/28/2013*/
  
Parser parser;
Node root;

void setup(){
  size(600, 600);
  parser = new Parser("hierarchy.csv");
  root = parser.getRoot();
  root.setValues();
  root.sortChildren();
//  frame.setResizable(true);
}

void draw(){
  background(255);
  root.setUpRectangles(width, height, 0, 0);
  root.drawMap();
}
