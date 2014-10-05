int numCircles;
Circle circles[];

void setup() {
  size(500, 500);
  numCircles =(int)random(1, 12);
  circles = new Circle[numCircles];
  for (int i = 0; i < numCircles; i++) {
    float radius = (int)random(15, 85);
    float x = (int)random(radius, width - radius);
    float y = (int)random(radius, height - radius);
    int r = (int)random(0, 255);
    int g = (int)random(0, 255);
    int b = (int)random(0, 255);
    float velX, velY;
    do{
      velX = random(-6, 6);
    }while(abs(velX) < 2);
    do{
      velY = random(-6, 6);
    }while(abs(velY) < 2); 
    circles[i] = new Circle(x, y, radius, r, g, b, velX, velY);
  }
}

void draw () {
  background(255, 255, 255);
  for(int i = 0; i < numCircles; i++) {
    circles[i].moveCircle();
    circles[i].drawCircle();
    }
  }


void mouseClicked() {
  for(int i = 0; i < numCircles; i++) {
      if(circles[i].intersection() == true) {
      circles[i].changeVariables();
      }
  }
}
