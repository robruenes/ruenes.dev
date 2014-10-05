class Graph{
  Bar dbars[];
  DataPoint dpoints[];
  String ordinal[];
  public float x, y, gwidth, gheight;   //To draw inner box
  float vertX, vertStartY, vertEndY;    //Info for Y axis
  float horizStartX, horizEndX, horizY; //Info for X axis
  float xLen, yLen;                     //Axes lengths
  float xtickSpread, xtickHeight;       //X axis tick marks
  float ytickSpread, ytickWidth;        //Y axis tick marks
  float loVal, hiVal;                   //Values for Y axis
  int numValues;                        

  
  public Graph(int _numValues, String _ord[], 
               float _quant[], float _lo, float _hi){
                 
    numValues = _numValues;
    loVal = _lo;
    hiVal = _hi;
    dpoints = new DataPoint[numValues];
    dbars = new Bar[numValues];
    
    for(int i = 0; i < numValues; i++) {
      dpoints[i] = new DataPoint(_ord[i], _quant[i]);
      dbars[i] = new Bar(_ord[i], _quant[i]);
    }
    ordinal = _ord;
    
    updateGraph();
  }
  
  public void updateGraph(){    
    x = width * .0875;
    y = height * .0875;
    gwidth = width * .825;
    gheight = height * .825;
    updateAxes();
    xtickSpread = (xLen * .85) / (float)numValues;
    xtickHeight = horizY - 3;
    ytickSpread = (yLen * .95) / 4.0;
    ytickWidth = vertX + 3;
  }
  
  public void updateAxes(){
    vertX = (gwidth * .1) + x;
    vertStartY = y;
    vertEndY = (gheight * .85) + y;
    horizStartX = vertX;
    horizEndX = gwidth + x;
    horizY = vertEndY;
    xLen = horizEndX - horizStartX;
    yLen = vertEndY - vertStartY;
  }
  
  public void render(){
    updateGraph();
    fill(255);
    rect(x, y, gwidth, gheight); //Draws inner rectangle
    stroke(0);
    line(vertX, vertStartY, vertX, vertEndY);     //Draws X axis
    line(horizStartX, horizY, horizEndX, horizY); //Draws Y axis
    
    //Sets up tick marks and labels on Y axis
    float startY = horizY;
    float difference = (hiVal - loVal)/4;
    float startnum = loVal;
    fill(0);
    for(int i = 0; i < 5; i++) {
      line(vertX, startY, ytickWidth, startY);
      textAlign(RIGHT, CENTER);
      textSize((gheight + gwidth) * .0075);
      text(startnum, vertX, startY);
      startY = startY - ytickSpread;
      startnum = startnum + difference;
    }
    
    float startX = vertX + (xtickSpread/2);
    for(int i = 0; i < numValues; i++) { 
      textAlign(CENTER);
      textSize((gheight + gwidth) * .0075);
      text(ordinal[i], startX, horizY + (((gheight-horizY)/2)), xtickSpread, xtickSpread);
      startX = startX + xtickSpread;
    }
  }
  
  public void renderBar(){
    float barwidth = (xLen/numValues) * .4;
    float startX = vertX + xtickSpread - (barwidth * .5);
   
    for(int i = 0; i < numValues; i++){   
      float yCoord = horizY - 
                    ((dbars[i].getVal() - loVal)/(hiVal - loVal))
                     * ytickSpread * 4;
      
      /*The y coordinate is calculated by finding the correct
       ratio between the datapoint's value and the highest value,
       adjusting it based on the distance and number of tick 
       marks, and subtracting it from the x-axis' y coordinate*/
      
      float barheight = horizY - yCoord;
      dbars[i].update(startX, yCoord, barwidth, barheight);  
      dbars[i].drawBarN();
      if(dbars[i].intersect()){
        dbars[i].drawBarH();
      }
      startX = startX + xtickSpread;
    }
    
    for(int i = 0; i < numValues; i++){
      if(dbars[i].intersect()){
        dbars[i].drawText();
      }
    }
  }
    
  public void renderLine(){    
    float startX = vertX + xtickSpread;      
    for(int i = 0; i < numValues; i++) {
      float yCoord = horizY - 
                   ((dpoints[i].getVal() - loVal)/(hiVal - loVal))
                   * ytickSpread * 4; 
      /*Y coordinate calculation is the same as above function*/
                    
      dpoints[i].drawPointN(startX, yCoord);     
      if(dpoints[i].intersect()){
        dpoints[i].drawPointH(startX, yCoord);
      }
       
      line(startX, xtickHeight, startX, horizY);//Draws tick mark    
      startX = startX + xtickSpread;
    }
    
    for(int i = 0; i < numValues - 1; i++){
      line(dpoints[i].getX(), dpoints[i].getY(), 
      dpoints[i+1].getX(), dpoints[i+1].getY());
    }
  }
}
