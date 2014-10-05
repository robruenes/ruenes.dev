/*Comp150VIZ HW3 - ThemeRiver
  Robert Ruenes
  2/18/2013 */

Parser parser;
String[] timesteps;
int numSteps, numThemes;
River river;
PGraphics pickbuffer;
int buffWidth, buffHeight;

void setup(){
  size(500,500);
  parser = new Parser("data.csv");
  buffWidth = width;
  buffHeight = height;
  pickbuffer = createGraphics(buffWidth, buffHeight);
  timesteps = parser.getTimesteps();
  numSteps = parser.numTimesteps();
  numThemes = parser.getnumThemes();
  river = new River(numSteps, numThemes, timesteps, 
                    parser.getQuantitative(),
                    parser.getOrdinal());  
  drawBackBuffer();
//  frame.setResizable(true);  
}

void draw(){
  smooth();
  background(255);
  
  //Sets up x-axis
  fill(0);
  line(0, height * .9, width, height * .9);
  textSize((height + width) * .01);
  
  float startX = 0;
  float tickDist = width/float(numSteps - 1);

  for(int i = 0; i < numSteps; i++) {
    if(i == 0){ 
      textAlign(LEFT); //So you can see the leftmost timestep
    }
    else if (i == numSteps -1 ) { 
      textAlign(RIGHT); //So you can see the rightmost timestep
    } 
    else{ 
      textAlign(CENTER);
      
    }
    //Draws tick marks and labels them
    line(startX, height * .895, startX, height * .905);  
    text(timesteps[i], startX, height * .95);
    startX = startX + tickDist;   
  } 
  river.drawRiver();
}

void drawBackBuffer() {
  pickbuffer.beginDraw();
  pickbuffer.background(255);
  river.renderBackBuffer(pickbuffer);
  pickbuffer.endDraw();
}

void mouseMoved(){
  if(width != buffWidth || height != buffHeight){ 
    buffWidth = width;
    buffHeight = height;
    pickbuffer = createGraphics(buffWidth, buffHeight);
    drawBackBuffer();
  }
  int c = pickbuffer.get(mouseX, mouseY);
  int testID = c & 0xFFFFFF;
  river.isectTest(testID);
}
