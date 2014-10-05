/*Comp150VIZ Homework 2 - Line and Bar Graphs
  Robert Ruenes
  2/8/2013 */

Graph chart;
Button myButton = new Button();
Parser parser;
String L1, L2;

void setup()
{
  parser = new Parser("data.csv");
  chart = new Graph(parser.getnumValues(), parser.getOrdinal(),
              parser.getQuant(), 
              (parser.getminVal() - (parser.getminVal() * .15)),
              parser.getmaxVal());
  L1 = parser.getxLabel();
  L2 = parser.getyLabel();
  size(1100, 800);
}

void draw()
{

  background(119, 136, 153);  
  chart.render();
  
  textSize((height + width) * .01);
  textAlign(LEFT);
  text(L2 + " vs. " + L1, (width * .5), height  * .065);
  
  textAlign(LEFT, BOTTOM);
  text(L1, width * .5, height - chart.y);
  
  textAlign(LEFT);
  text(L2, chart.x, height/2);
  
  if(myButton.intersect()){
    myButton.renderH();
  } 
  else{
    myButton.renderN();
  }
  
  if(!myButton.getBool()){
   chart.renderLine();
  }
  else{
   chart.renderBar();
  }
}


void mouseClicked(){
  if(myButton.intersect()){
    myButton.updateBool();
  }
}
