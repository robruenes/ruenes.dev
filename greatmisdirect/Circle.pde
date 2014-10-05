/*Circle class: Used to represent nodes in the visualization*/
class Circle{
  int ID;
  float x, y;
  float radius;
  float xVel, yVel;
  boolean selected;
  ArrayList edges; //
  
  public Circle(int _ID, int neighborID, float strength){
    ID = _ID;
    Edge first_neighbor = new Edge(neighborID, strength);
    edges = new ArrayList();
    edges.add(first_neighbor);
    radius =  width * .025;
    xVel = 0;
    yVel = 0;
  }
  
  public void addEdge(int neighborID, float strength){
    for(int i = 0; i < edges.size(); i++){
      Edge neighbor = (Edge) edges.get(i);
      if (neighbor.neighborID == neighborID){
        return;
      }
    }
    Edge new_neighbor = new Edge(neighborID, strength);
    edges.add(new_neighbor);
  }
  
  public void assignVelocity(float xForce, float yForce){
    xVel = (xVel + xForce);
    yVel = (yVel + yForce);
  }
  
  public void applyDamping(){
    xVel = xVel * Kd;
    yVel = yVel * Kd;
  }
 
  public void setPosition(){
    x = x + xVel;
    y = y + yVel; 
  
    //Keep the visualization within the bounds 
    //of the canvas.  
    if(x - radius <= 0){
      x = 0 + radius;
    }
    if(x + radius >= width){
      x = width - radius;
    }
    if(y - radius <= 0){
      y = 0 + radius;
    }
    if(y + radius >= height){
      y = height - radius;
    }
  }
  
  public boolean isNeighbor(int neighborID){
    for(int i = 0; i < edges.size(); i++){
      Edge edge = (Edge) edges.get(i);
      if (edge.neighborID == neighborID){
        return true;
      }
    }
    return false;
  }
   
  public float getEnergy(){
    float velocity_squared = (xVel * xVel) + (yVel * yVel);
    return velocity_squared; 
  }
  
  public boolean intersect(int testID){
    if(testID == ID){
      return true;
    }
    return false;
  }
}

    
  
