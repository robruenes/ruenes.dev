class Circle {
  int r, g, b, t;
  float x, y, radius;
  float velX, velY;

  public Circle(float _x, float _y, float _radius, 
  int _r, int _g, int _b, float _velX, float _velY) {
    circlePos(_x, _y, _radius);
    circleColor(_r, _g, _b, 128);
    circleVel(_velX, _velY);
  }

  public void circlePos(float _x, float _y, float _radius) {
    x = _x;
    y = _y;
    radius = _radius;
  }

  public void circleColor(int _r, int _g, int _b, int _t) {
    r = _r;
    g = _g;
    b = _b;
    t = _t;
  }

  public void circleVel(float _velX, float _velY) {
    velX = _velX;
    velY = _velY;
  }

  public void moveCircle() {
    x = x + velX;
    y = y + velY;

    if ((x < 0) || (x > width)) {
      velX = -velX;
    }
    if ((y < 0) || (y > height)) {
      velY = -velY;
    }
  }

  public void drawCircle() {
      stroke(r,g,b);
      fill(r,g,b,t);
      ellipse(x, y, radius*2, radius*2);
      fill(0);
  }
  
  public boolean intersection() {
    float distance = sqrt((mouseX - x) * (mouseX - x) +
                          (mouseY - y) * (mouseY - y));
    return (distance <= radius*2);
  }

  
  public void changeVariables() {
    r = (int)random(0, 255);
    g = (int)random(0, 255);
    b = (int)random(0, 255);
    velX = -(random(0, 6));
    velY = -(random(0, 6));
  }
}

