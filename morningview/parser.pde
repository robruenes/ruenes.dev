/*Parses information from the csv file*/
class Parser{
  String buffer[];
  String timesteps[];
  String ord_data[]; 
  float quant_data[][]; 
  int quantWidth, quantHeight;
  int numThemes;
  
  public Parser(String filename) {
    String lines[] = loadStrings(filename);
    numThemes = lines.length - 1; 
    ord_data = new String[numThemes]; //hold the themes
    
    quantHeight = numThemes;
    buffer = split(lines[0], ',');
    quantWidth = buffer.length - 1;   
    timesteps = new String[quantWidth]; 
    quant_data = new float[quantHeight][quantWidth];

    for(int i = 1; i < buffer.length; i++){
      timesteps[i-1] = buffer[i];
    }    
    for(int i = 1; i < lines.length; i++){
      buffer = split(lines[i], ',');
      ord_data[i-1] = buffer[0];
      for(int j = 1; j < buffer.length; j++) {
      quant_data[i-1][j-1] = float(buffer[j]);
          //i-1 because there is an extra label level in csv file
          //j-1 because we ignore the first spot in each row
      }
    }
  } 
  
  public int getnumThemes(){
    return numThemes;
  }
  
  public String[] getTimesteps(){
    return timesteps;
  }
  
  public int numTimesteps(){
    return timesteps.length;
  }
  
  public String[] getOrdinal(){
    return ord_data;
  }
  
  public float[][] getQuantitative(){
    return quant_data;
  }
}
