class Parser{
  String buff[];
  String xLabel, yLabel;
  String ordinal_data[];
  float quantitative_data[];
  int numValues;
  
  public Parser(String filename) {
    String lines[] = loadStrings(filename);
    numValues = lines.length - 1;
    ordinal_data = new String[numValues];
    quantitative_data = new float[numValues];
   
    for(int i = 0; i < lines.length; i++){
      buff = split(lines[i], ',');
      if(i == 0){
        xLabel = buff[0];
        yLabel = buff[1];
      }
      else{
        ordinal_data[i-1] = buff[0];
        quantitative_data[i-1] = float(buff[1]);
      }
    }  
  }
  
  public int getnumValues(){
    return numValues;
  }
  
  public float[] getQuant(){
    return quantitative_data;
  }
  
  public String[] getOrdinal(){
    return ordinal_data;
  }
  
  public String getxLabel(){
    return xLabel;
  }
  
  public String getyLabel(){
    return yLabel;
  }
  
  public float getminVal(){
    float minVal = quantitative_data[0];
    for(int i = 1; i < numValues; i++){
      if(quantitative_data[i] < minVal){
        minVal = quantitative_data[i];
      }
    }
    return minVal;
  }
  
  public float getmaxVal(){
    float maxVal = quantitative_data[0];
    for(int i = 1; i < numValues; i++){
      if(quantitative_data[i] > maxVal){
        maxVal = quantitative_data[i];
      }
    }
    return maxVal;
  }
}
