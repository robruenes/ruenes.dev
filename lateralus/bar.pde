class Bar{
 String string_data;
 float num_value, x, y, bwidth, bheight;
 
 public Bar(String _string_data, float _num_value){
   string_data = _string_data;
   num_value = _num_value;
 }
 
 public void update(float _x, float _y, 
                    float _bwidth, float _bheight){
   x = _x;
   y = _y;
   bwidth = _bwidth;
   bheight = _bheight;
 }
 
 public void drawBarN(){
   fill(100, 149, 237);
   rect(x, y, bwidth, bheight);
 }
 
 public void drawBarH(){
   fill(0, 206, 209);
   rect(x, y, bwidth, bheight);
 }
 
 public void drawText(){
   fill(0);
   textAlign(LEFT, BOTTOM);
   textSize(12);
   text(string_data + ", " + num_value + "", mouseX, mouseY);
 }
 
 public boolean intersect(){
    return ((mouseX >= x) && (mouseX <= (x + bwidth)) &&
    (mouseY >= y) && (mouseY <= (y + bheight)));
 }
 
 public float getVal(){
   return num_value;
 }

 public String getStr(){
   return string_data;
 }
}
