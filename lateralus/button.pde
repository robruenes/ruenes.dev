class Button {
  boolean line_state;
  float x, y, bwidth, bheight;
  String state;
  
  public Button(){
    line_state = false;
    state = "Bars";
    y = 0;
    updateButton();
  }
  
  public void updateButton(){
    bwidth = width * .0875;
    bheight = height * .0875;
    x = width - bwidth;
  }

  public void renderN(){
    fill(255, 0, 0);
    updateButton();
    rect(x, y, bwidth, bheight);
    drawText();
  }
  
  public void renderH(){
    fill(255, 204, 203);
    updateButton();
    rect(x, y, bwidth, bheight);
    drawText();
  }
 
  public void drawText(){
    fill(0);
    textAlign(LEFT);
    textSize((bwidth + bheight) * .1);
    text(state, (x + (bwidth/4)), ((y + bheight)/2));
  }
    
  public boolean intersect(){
    return ((mouseX >= x) && (mouseX <= (x + bwidth)) &&
    (mouseY >= y) && (mouseY <= (y + bheight)));
  }

  public boolean getBool(){
    return line_state;  
  }
  
  public void updateBool(){
    line_state = !line_state;
    if(state == "Bars"){
      state = "Lines";
    }
    else{
      state = "Bars";
    }
  }  
}
