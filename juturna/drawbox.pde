//Robert Ruenes
//Comp150VIZ
//Assignment 1 - Draw Box

int counter = 0;
float dimension1, dimension2, rectwidth, rectheight;
float canvas = 400;
color c1 = color(204, 102, 0);
color c2 = color(0, 102, 204);

void setup() {
  size((int)canvas, (int)canvas);
}

void draw() {
  background(255);
  if((counter % 2) == 0) {
    rectwidth = 150;
    rectheight = 50;
    dimension1 = (canvas * .5) - (rectwidth * .5);
    dimension2 = (canvas * 0.5) - (rectheight * 0.5);
    fill(c1);
    rect(dimension1, dimension2, rectwidth, rectheight);
    fill(0);
    text("Orange!", dimension1, dimension2);
  }
  else {
    rectwidth = 75;
    rectheight = 25;
    dimension1 = (canvas * .5) - (rectwidth * .5);
    dimension2 = (canvas * .5) - (rectheight * .5);
    fill(c2);
    rect(dimension1, dimension2, rectwidth, rectheight);
    fill(0);
    text("Blue!", dimension1, dimension2);
  }
} 
  
void mouseClicked() {
  if((mouseX >= dimension1) && 
     (mouseX <= (canvas-dimension1)) && (mouseY >= dimension2) &&
     (mouseY <= (canvas-dimension2))) {
       counter++;
     }
}
  
