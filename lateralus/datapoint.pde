class DataPoint {
  String string_data;
  float num_value, x, y, radius;
  
  public DataPoint(String _string_data, float _num_value){
    num_value = _num_value;
    string_data = _string_data;
    radius = (height + width) * .01;
  }
  
  public boolean intersect(){
    float distance = sqrt((mouseX - x) * (mouseX - x) +
                          (mouseY - y) * (mouseY - y));
    return (distance <= radius*2);
  }
  
  public void drawPointN(float _x, float _y){
    x = _x;
    y = _y;
    radius = (height + width) * .001;
    
    fill(100, 149, 237);
    ellipse(x, y, radius*2, radius*2);
  }
  
  public void drawPointH(float _x, float _y){
    x = _x;
    y = _y;
    radius = (height + width) * .001;
    
    fill(0, 206, 209);
    ellipse(x, y, radius*2, radius*2);
    
    fill(0);
    textSize(12);
    textAlign(LEFT);
    text(string_data + ", " + num_value + "", mouseX, mouseY);
  }  
  
  public String getStr(){
    return string_data;
  }
  
  public float getVal(){
    return num_value;
  }
  
  public float getX(){
    return x;
  }
  
  public float getY(){
    return y;
  }
}
