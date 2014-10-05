/* Comp150VIZ HW5 - Force Directed Node Link Diagram
   Robert Ruenes
   3/12/2013 */

Parser parser;
Circle circles[];
PGraphics backbuffer;
int canvas_size;
float system_energy;
boolean updating;

float Kt = 0.01; //Minimum system energy
float Ke = 10000; //Coulomb's constant
float Ks = 1; // Hooke's constant
float Kd = 0.325; // Damping constant

void setup(){
  canvas_size = 500;
  size(canvas_size, canvas_size);
  backbuffer = createGraphics(canvas_size, canvas_size);
  parser = new Parser("data.csv");
  circles = parser.circles;
  for(int i = 0; i < circles.length; i++){
    if(circles[i] != null){
       circles[i].x = random(canvas_size);
       circles[i].y = random(canvas_size);
    }
  }
  updating = true;
  drawBackBuffer();
}

void draw(){
  draw_circles();
  if(updating){
    calculate_forces();
    update_positions();
  }
}

//Draws everything.
public void draw_circles(){
 
  background(0);
  stroke(204, 255, 153);
  smooth();
  
  //Draw the lines connecting the circles.
  for(int i = 0; i < circles.length; i++){
    if(circles[i] != null){
      float x1 = circles[i].x;
      float y1 = circles[i].y;
      for(int j = 0; j < circles[i].edges.size(); j++){
        Edge edge = (Edge) circles[i].edges.get(j);
        float x2 = circles[edge.neighborID].x;
        float y2 = circles[edge.neighborID].y;
        line(x1, y1, x2, y2);
      }
    }
  }
  
  //Then draw the circles.
  for(int i = 0; i < circles.length; i++){
    fill(0);
    if(circles[i] != null){  
      //Highlighted
      if(circles[i].selected){
        fill(204, 255, 153);
        ellipse(circles[i].x, circles[i].y,
                width * .05, height * .05);
        fill(0);
        text(i, mouseX, mouseY);
      }
      else{
        ellipse(circles[i].x, circles[i].y,
                width * .05, height * .05);
      }
    }
  }
}

//Calculates forces if minimum energy has not been reached.
public void calculate_forces(){  
  float total_force_x;
  float total_force_y;
  system_energy = 0;
  
  for(int i = 0; i < circles.length; i++){
    total_force_x = 0;
    total_force_y = 0;
    if(circles[i] != null && !circles[i].selected){  
      
      //Calculate all of the spring forces.
      for(int j = 0; j < circles[i].edges.size(); j++) {
        Edge neighbor = (Edge) circles[i].edges.get(j);
        int nID = neighbor.neighborID;
        total_force_x += x_spring_force(circles[i], circles[nID], neighbor.strength);
        total_force_y += y_spring_force(circles[i], circles[nID], neighbor.strength);
      }
      
      //Calculate all of the repulsion forces.
      for(int j = 0; j < circles.length; j++) {
        if((j != i) && (circles[j] != null) && (!circles[i].isNeighbor(j))){
          total_force_x += x_repulsion(circles[i], circles[j]);
          total_force_y += y_repulsion(circles[i], circles[j]);
        }
      }
       
      //Update velocity.
      circles[i].assignVelocity(total_force_x, total_force_y);
    }
  }
  
  //Apply damping.
  for(int i = 0; i < circles.length; i++){
    if(circles[i] != null){
      circles[i].applyDamping();
      system_energy += circles[i].getEnergy();
    }
  }

  //Stop updating if minimum energy reached.
  if(system_energy <= Kt){
    updating = false;
  }
}

//Updates coordinates of circles.
public void update_positions(){
  for(int i = 0; i < circles.length; i++){
    if(circles[i] != null){
      circles[i].setPosition();
    }
  }
}

//Calculates x spring force.
public float x_spring_force(Circle c1, Circle c2, float strength){
  float dist = distance(c1, c2);
  float delta_l = dist - strength;
  float x_distance = c2.x - c1.x;
  float spring_force = Ks * (delta_l) * (x_distance / dist);
  return spring_force;
}

//Calculates y spring force.
public float y_spring_force(Circle c1, Circle c2, float strength){
  float dist = distance(c1, c2);
  float delta_l = dist - strength;
  float y_distance = c2.y - c1.y;
  float spring_force = Ks * (delta_l) * (y_distance / dist);
  return spring_force;
}

//Calculates x repulsion force.
public float x_repulsion(Circle c1, Circle c2){ 
  float repulsion_force;
  float dist = distance(c1, c2);
  float x_distance = c2.x - c1.x;
  repulsion_force =  -(Ke / (dist * dist)) * 
                      (x_distance / dist);
  return repulsion_force;
}

//Calculates y repulsion force.
public float y_repulsion(Circle c1, Circle c2){ 
  float repulsion_force;
  float dist = distance(c1, c2);
  float y_distance = c2.y - c1.y;
  repulsion_force = -(Ke / (dist * dist)) * 
                     (y_distance / dist);
  return repulsion_force;
}

//Calculates actual distance between two nodes.
public float distance(Circle c1, Circle c2){
 float dist;
 float xDiff = c2.x - c1.x;
 float yDiff = c2.y - c1.y;
 dist = sqrt((xDiff * xDiff) + (yDiff * yDiff));
 return dist;
}

void drawBackBuffer(){
  backbuffer.beginDraw();
  backbuffer.background(255);
  backbuffer.noStroke();
  for(int i = 0; i < circles.length; i++){
    if(circles[i] != null) {
      backbuffer.fill(red(i), green(i), blue(i));
      backbuffer.ellipse(circles[i].x, circles[i].y,
                         width * .05, height * .05);
    }
  }
  backbuffer.endDraw();
}

void mouseDragged(){
  for(int i = 0; i < circles.length; i++){
   if(circles[i] != null && circles[i].selected == true){
    if(mouseX >= 0 && mouseX <= width && mouseY >= 0 && mouseY <= height){
      circles[i].x = mouseX;
      circles[i].y = mouseY; 
      circles[i].xVel = 0;
      circles[i].yVel = 0;
      updating = true;
    }
   }
  }
}

void mouseMoved(){
 drawBackBuffer();
 int c = backbuffer.get(mouseX, mouseY);
 int testID = c & 0xFFFFFF;
 for(int i = 0; i < circles.length; i++){
   if(circles[i] != null){
     if(circles[i].intersect(testID)){
       circles[i].selected = true;
     }
     else{
       circles[i].selected = false;
     }
   }
 }
}


 
