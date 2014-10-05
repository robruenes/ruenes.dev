/*River class draws all of the currents and the backbuffer
 *for those currents. Keeps track of intersections, and 
 *outputs hover-over information
 */
  
class River{
  Bar[] bars;
  boolean isects[];
  color highlight;
  float tempBarSum, maxBarSum;
  float[][] quant_data;
  int id[];
  int numSteps, numThemes;
  String[] ord_data;
  String[] timesteps;
  
  public River(int _numSteps, int _numThemes, String[] _times, 
               float[][] _quant, String[] _ord){
                 
    numSteps = _numSteps;
    numThemes = _numThemes;
    timesteps = _times;
    quant_data = _quant;
    ord_data = _ord;
    highlight = color(220, 20, 60);
    
    bars = new Bar[numSteps];
    id = new int[numThemes];
    isects = new boolean[numThemes];
    float tempVals[] = new float[numThemes];
    
    //Calculates the max bar sum so every "bar" in the river
    //is correctly scaled.
    for(int i = 0; i < numSteps; i++){
      tempBarSum = 0;
      for(int j = 0; j < numThemes; j++){
        tempBarSum += quant_data[j][i];
      }
      if(tempBarSum > maxBarSum){
        maxBarSum = tempBarSum;
      }
    }
    
    //For the backbuffer test.
    for(int i = 0; i < numThemes; i++){
      id[i] = i*1000 + 1;
      isects[i] = false;
    }
    
    //Initializes the bars, which are reflections of the river
    //at one particular timestep.
    float startX = 0;
    float xDist = width/float(numSteps - 1); 
    
    for(int i = 0; i < numSteps; i++) { 
      for(int j = 0; j < numThemes; j++) {
        tempVals[j] = quant_data[j][i];
      }
      bars[i] = new Bar(numThemes, tempVals, maxBarSum, startX);
      startX += xDist;
    }
  }

  public void drawRiver(){
    int streamNumber = 0;
    boolean intersection = false;
    
    //Updates all of the bars to reflect window size.
    float tickDist = width/float(numSteps - 1);
    float startX = 0;
    for(int i = 0; i < numSteps; i++){
      bars[i].initializeBar();
      bars[i].x = startX;
      startX += tickDist;
    }

    //Draws the river and detects intersection.
    for(int i = 0; i < numThemes; i++){
      beginShape();
      curveVertex(bars[0].x, bars[0].gethiY(i));
      
      //Draws top of a current.
      for(int j = 0; j < numSteps; j++){
        curveVertex(bars[j].x, bars[j].gethiY(i));
      }
      
      //Corrects issue of incorrect lines being drawn.
      curveVertex(bars[numSteps-1].x + tickDist, height/2);
      
      //Draws bottom of a current.
      for(int j = numSteps - 1; j >= 0; j--){
        curveVertex(bars[j].x, bars[j].getloY(i));
      }
      curveVertex(bars[0].x, bars[0].getloY(i));
            
      if(isects[i] == true){
        intersection = true;
        streamNumber = i;
        fill(highlight);
      }
      
      else {
          fill((95 + (15/numThemes) * i), 
               (5 + (250/numThemes) * i), 
               (45 + (210/(numThemes) * i)));
      }
      endShape();
      
      if(intersection == true){
        printHover(streamNumber);
      }
    }
  }
   
  public void renderBackBuffer(PGraphics pg){
    float xDist = width/float(numSteps - 1);
    pg.noStroke();
    for(int i = 0; i < numThemes; i++){
      pg.beginShape();
      //Gives every current a unique color that 
      //can be detected.
      pg.fill(red(id[i]), green(id[i]), blue(id[i]));
      
      //Same drawing algorithm used in drawRiver function.
      pg.curveVertex(bars[0].x, bars[0].gethiY(i));
      for(int j = 0; j < numSteps; j++){
        pg.curveVertex(bars[j].x, bars[j].gethiY(i));
      }
      pg.curveVertex(bars[numSteps-1].x + xDist, height/2);
      for(int j = numSteps - 1; j >= 0; j--){
        pg.curveVertex(bars[j].x, bars[j].getloY(i));
      }
      pg.curveVertex(bars[0].x, bars[0].getloY(i));
      pg.endShape();
    }
  }

  public void isectTest(int testID){
    for(int i = 0; i < numThemes; i++){
      if(testID == id[i]){
        isects[i] = true;
      }
      else{
        isects[i] = false;
      }
    }
  }
  
  public void printHover(int i){
    float xDist = width / float(numSteps-1);
    int month = int(mouseX / xDist);
    float monthF = mouseX / xDist;
    
    //Calculation is done to determine which timestep
    //the mouse is closest to.
    if(monthF >= (month + .5) && month <= numSteps){
      month++;
    }
    float value = bars[month].getValue(i);
    fill(0);
    
    //Ensures text is always readable and not drawn 
    //out of bounds.
    if(mouseX < (width/2)){
      textAlign(LEFT);
    }
    else{
      textAlign(RIGHT);
    }
    
    textSize((height + width) * .015);
    text(ord_data[i] + ", " + timesteps[month] +  ", "
         + value, mouseX, mouseY);
  }
}


