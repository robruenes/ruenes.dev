class Node{
  int ID;
  int value;
  float area;
  float x, y, nWidth, nHeight;
  boolean isLeaf;
  boolean isRoot;
  ArrayList childNodes;
  
  public Node(int _ID, int _value, boolean _isLeaf){
    ID = _ID;
    if(_isLeaf){
      isLeaf = true;
      value = _value;
    }
    else{
      isLeaf = false;
    }
    isRoot = true; //This gets changed almost immediately.
    childNodes = new ArrayList();
  }
  
  public void addChildNode(Node child){
      childNodes.add(child);
  }
  
  public int setValues(){
    if(isLeaf) {
      return value;
    }
    for(int i = 0; i < childNodes.size(); i++){
      Node child = (Node) childNodes.get(i);
      value += child.setValues();
    }
    return value;
  }
  
  public void sortChildren(){
    for(int i = 0; i < childNodes.size(); i++){
      Node temp = (Node) childNodes.get(i);
      temp.sortChildren();
    }
    
    int size = childNodes.size();
    Node[] tempArray = new Node[size];
    for(int i = 0; i < size; i++){
      tempArray[i] = (Node) childNodes.get(i);
    }
    childNodes.clear();
    for(int i = 1; i < size; i++){
      Node newNode = tempArray[i];
      int newVal = tempArray[i].value;
      int j = i;
      while(j > 0 && tempArray[j-1].value < newVal){
        tempArray[j] = tempArray[j-1];
        j--;
      }
      tempArray[j] = newNode;
    }
    for(int i = 0; i < size; i++){
      childNodes.add(i, tempArray[i]);
    }
  }
  
  public void setUpRectangles(float canvas_width, float canvas_height, 
                              float canvas_x, float canvas_y){
    if(childNodes.isEmpty()){
      return;
    }
    
    float canvas_area = canvas_width * canvas_height;
    float total_value = value; 
    float VA_ratio = canvas_area / total_value; 
    float short_side;
    boolean width_is_shorter;
   
    if(canvas_width < canvas_height){
      short_side = canvas_width;
      width_is_shorter = true;
    }
    else{
      short_side = canvas_height;
      width_is_shorter = false;
    }
   
    ArrayList nodes_to_draw = new ArrayList(childNodes);
    ArrayList row = new ArrayList();

    Node c1 = (Node) nodes_to_draw.remove(0);
    row.add(c1);
   
   
    /*Sets up the first rectangle, c1, based on dimensions
     *of the canvas*/
    c1.x = canvas_x; 
    c1.y = canvas_y; 
    c1.area = c1.value * VA_ratio;
    float ratio_c1;
    if(width_is_shorter){
      c1.nWidth = short_side;
      c1.nHeight = c1.area / c1.nWidth;
    }
    else{
      c1.nHeight = short_side;
      c1.nWidth = c1.area / c1.nHeight;
    }
    
    /*Does comparisons for every rectangle that has yet
     *to be drawn*/
    while(nodes_to_draw.size() >= 1) { 
      ratio_c1 = c1.nWidth / c1.nHeight; 
      
      Node c2 = (Node) nodes_to_draw.remove(0);
      c2.area = c2.value * VA_ratio;
      float ratio_c2;
      
      float row_sum = c2.value;
      for(int i = 0; i < row.size(); i++){
        Node row_member = (Node) row.get(i);
        row_sum += row_member.value;
      }
      
      /*Determines what the width and height of rectangle
       * c2 would be if it was added to the current row*/
      float possible_c2_width;
      float possible_c2_height;
      if(width_is_shorter){
        possible_c2_height = (row_sum * VA_ratio) / short_side;
        possible_c2_width = c2.area / possible_c2_height;
      }
      else{
        possible_c2_width = (row_sum * VA_ratio) / short_side;
        possible_c2_height = c2.area / possible_c2_width;
      }
      ratio_c2 = possible_c2_width / possible_c2_height;
      
      /*If rectange c2 is more square than rectangle c1,
       *c2 gets added to the row, and all rectangles in
       *that row get updated*/
      if(checkAspect(ratio_c1, ratio_c2)){ 
        c2.nWidth = possible_c2_width;
        c2.nHeight = possible_c2_height;
        c2.x = c1.x;
        c2.y = c1.y;
        updateRow(c1, c2, width_is_shorter, row);
      }
      
      /*Otherwise, we leave the row as is, and use the 
       *remaining area as a new canvas to add c2 to*/
      else{    
        c1 = c2;
        Node last_in_row = (Node) row.get(row.size() - 1);
        if(width_is_shorter){
          c1.x = last_in_row.x;
          c1.y = last_in_row.y + last_in_row.nHeight;
          canvas_height -= last_in_row.nHeight;
        }
        else{
          c1.x = last_in_row.x + last_in_row.nWidth;
          c1.y = last_in_row.y;
          canvas_width -= last_in_row.nWidth;
        }
        
        if(canvas_width < canvas_height){
          short_side = canvas_width;
          width_is_shorter = true;
          c1.nWidth = short_side;
          c1.nHeight = c1.area / c1.nWidth;
        }
        else{
          short_side = canvas_height;
          width_is_shorter = false;
          c1.nHeight = short_side;
          c1.nWidth = c1.area / c1.nHeight;
        }
        row.clear();
        row.add(c1);
      }
    }   
    
    /*Repeats this process for all children nodes*/
    for(int i = 0; i < childNodes.size(); i++){
      Node child = (Node) childNodes.get(i);
      child.setUpRectangles(child.nWidth, child.nHeight, child.x, child.y);
    }
  }
    
  private void updateRow(Node c1, Node c2, boolean w_shorter, ArrayList row){
    float currentX = c2.x;
    float currentY = c2.y;
    if(w_shorter){
      currentX += c2.nWidth;
    }
    else{
      currentY += c2.nHeight;
     }
        
     row.add(c2);
     for(int i = row.size() - 2; i >= 0; i--){
       Node row_member = (Node) row.get(i);
       row_member.x = currentX;
       row_member.y = currentY;
       if(w_shorter){
         row_member.nHeight = c2.nHeight;
         row_member.nWidth = row_member.area / row_member.nHeight;
         currentX += row_member.nWidth;
       }
       else{
         row_member.nWidth = c2.nWidth;
         row_member.nHeight = row_member.area / row_member.nWidth;
         currentY += row_member.nHeight;
       }     
     }
     c1 = c2;
     row.add(c1);
  }  
    
  private boolean checkAspect(float ratio_c1, float ratio_c2) {
    if(ratio_c1 > 1){
      ratio_c1 = 1 / ratio_c1;
    }
    if(ratio_c2 > 1){
       ratio_c2 = 1 / ratio_c2;
    }
    return (ratio_c2 >= ratio_c1);
  }  
  
  public void drawMap(){
    if(!isLeaf){
      strokeWeight((width + height) * .01);
    }
    else{
      strokeWeight(1);
    }
    stroke(255);
    if(nodeIntersection()){
         fill(204, 255, 204);
    }
    else{
      fill(204, 229, 255);
    }
    rect(x, y, nWidth, nHeight);
    fill(0);
    textSize((width + height) * .008);
    textAlign(CENTER);
    text(ID, (x + (nWidth/2)), (y + (nHeight/2)));
    for(int i = 0; i < childNodes.size(); i++){
      Node child = (Node) childNodes.get(i);
      child.drawMap();
    }
  }
  
  private boolean nodeIntersection(){
    return(((mouseX >= x) && (mouseX <= (x + nWidth)) && 
          (mouseY >= y) && (mouseY <= y + nHeight)));
  }
}
      
    
    

    
      

  
  

