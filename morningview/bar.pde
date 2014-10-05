/*Each instance of this class holds information pertaining to
 *a vertical series of points, representing all of the
 *information about the river at one particular timestep.
 */

class Bar{
  float x;         
  float barSum;    //Total of all values in the bar.
  float maxBarSum; //Max of all the bars, used for scaling.
  float bheight;   
  float pointVals[]; //Data values for currents at this timestep.
  int numStreams;
  Points[] points;
  
  public Bar(int _numStreams, float[] _vals, float _max, float _x){
    numStreams = _numStreams;
    pointVals = _vals;
    maxBarSum = _max;
    x = _x;

    barSum = 0;
    points = new Points[numStreams];
    for(int i = 0; i < numStreams; i++){      
      points[i] = new Points(pointVals[i]);
      barSum += pointVals[i];
    }
    if(barSum == 0){
      barSum = 1;
      /*Because BarSum is used as a denominator, it cannot
        be set to zero*/
    }
    initializeBar();
  }
  
  public void initializeBar(){
    bheight = (barSum / maxBarSum) * (height * .6);
    float startY = ((height * .9) / 2.0) - (bheight * .5);
    for(int i = 0; i < numStreams; i++) {
      points[i].x = x;
      points[i].hiY = startY;
      startY = startY + ((points[i].pointValue / barSum)
               * bheight);
      points[i].loY = startY;
    }
  }
  
  public float gethiY(int index){
    return points[index].hiY;
  }
  
  public float getloY(int index){
    return points[index].loY;
  }
  
  public float getValue(int index){
    return points[index].pointValue;
  }  
}

