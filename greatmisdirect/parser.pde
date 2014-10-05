/*Parser class: parses user input*/
class Parser{
  int num_edges;
  Circle circles[];
  ArrayList circleslist;

  public Parser(String filename){
   
    String buffer[];
    String lines[] = loadStrings(filename);
    int max = 0;
    int num_edges = lines.length;
   
    for(int i = 0; i < lines.length; i++){
      buffer = split(lines[i], ',');
      if(int(buffer[0]) > max){
        max = int(buffer[0]);
      }
      if(int(buffer[1]) > max){
        max = int(buffer[1]);
      }
    }
    
    circleslist = new ArrayList();
    circles = new Circle[max+1];
    for(int i = 0; i < lines.length; i++){
      int firstID, secondID;
      float strength;
      buffer = split(lines[i], ',');
      firstID = int(buffer[0]);
      secondID = int(buffer[1]);
      strength = float(buffer[2]);
      
      if(circles[firstID] == null){
        circles[firstID] = new Circle(firstID, secondID, strength);
      }
      else{
        circles[firstID].addEdge(secondID, strength);
      }
      
      if(circles[secondID] == null){
        circles[secondID] = new Circle(secondID, firstID, strength);
      }
      else{
        circles[secondID].addEdge(firstID, strength);
      }
    }
  }

    
  
}
      
      
      
    
    
  
  


