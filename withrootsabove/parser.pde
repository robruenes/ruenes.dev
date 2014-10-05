class Parser{
  int k; //Number of leaf nodes
  int n; //Number of pairs of tree nodes and a child
  Node root;
  
  public Parser(String filename) {
    String buffer[];
    String lines[] = loadStrings(filename);
    buffer = split(lines[0], ',');
    k = int(buffer[0]);
    buffer = split(lines[k+1], ',');
    n = int(buffer[0]);
    
    int max = 0;
    for(int i = 1; i < n + k + 1; i++){
      if(i != k + 1){
        buffer = split(lines[i], ',');
        if(int(buffer[0]) > max){
          max = int(buffer[0]);
        }
        max++;
      }
    }
    
    Node nodes[] = new Node[max+1];
    for(int i = 1; i < k + 1; i++) {
      buffer = split(lines[i], ',');
      int index = int(buffer[0]);
      int value = int(buffer[1]);
      nodes[index] = new Node(index, value, true);
    }
    
    for(int i = k + 2; i < n + k + 2; i++){
      buffer = split(lines[i], ',');
      int index = int(buffer[0]);
      int child = int(buffer[1]);
      if(nodes[index] == null){
        nodes[index] = new Node(index, 0, false);
      }
      if(nodes[child] == null){
        nodes[child] = new Node(child, 0, false);
      }
      nodes[child].isRoot = false;
      nodes[index].addChildNode(nodes[child]);
    } 
    for(int i = k + 2; i < n + k + 2; i++){
      buffer = split(lines[i], ',');
      int index = int(buffer[0]);
      if(nodes[index].isRoot){
        root = nodes[index];
      }
    }
  }
  
  public Node getRoot(){
    return root;
  }
}
