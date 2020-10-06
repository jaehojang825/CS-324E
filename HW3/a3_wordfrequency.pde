//import hashmap to be used for the reading and visualization
import java.util.Map;
HashMap<Float,Float> hm = new HashMap<Float,Float>();

void setup() {
  //set up the canvas
  size(600,600);
  
  //load in the file
  String[] lines = loadStrings("wordfrequency.txt");
  
  //load the file in as a dictionary with floats
  for (int i = 0; i < lines.length; i++) {
    String split_freq[] = split(lines[i], ':');
    hm.put(Float.parseFloat(split_freq[0]), Float.parseFloat(split_freq[1]));
  }
  

}

void draw(){
  
  //set up the background
  rectMode(CENTER);
  
  //less frequent range is in the lightest color
  fill(250, 222, 222);
  rect(300, 100, 600, 200);
  
  //medium frequent range is in the medium color
  fill(250, 124, 124);
  rect(300, 300, 600, 200);
  
  //very frequent range is in the deepest color
  fill(245, 40, 40);
  rect(300, 500, 600, 200);

 // draw axes
  stroke(85, 92, 108);
  strokeWeight(5);
  line(0, height, width, height);
  line(0, 0, 0, height);
  
  //label axes
  fill(255);
  //x axis
  textAlign(CENTER);
  text("# Words w/ Frequency", 300, 595);
  //y axis, make it rotate to be vertical
  float x = 30;
  float y = 300;
  pushMatrix();
  translate(x,y);
  rotate(-HALF_PI);
  text("Frequency",0,0);
  popMatrix();
  

  
  // begin making graph
  //set up design of graph
  strokeWeight(1);
  fill(175, 196, 245);
  stroke(85, 92, 108);
  
  //create bar for each frequency and value
  for (Float k: hm.keySet()){
    rect(300, 585 - (k * (700/hm.size())) , hm.get(k)/10, 2);
  }
    noLoop();
}
