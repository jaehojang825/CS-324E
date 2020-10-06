void setup() {
  size(1000,1000);
  background(240);
}

void draw() {
  //the sky
  noStroke();
  fill(color(51.0,153.0,255));
  rect(0,0,1000,700);
  
  //the sand
  fill(color(153.0,102.0,0));
  rect(0,700,1000,1000);
  
  //the wheels
  stroke(0);
  strokeWeight(3);
  fill(color(102.0,102.0,102.0));
  ellipse(300,600,200,200);
  
  fill(color(102.0,102.0,102.0));
  ellipse(700,600,200,200);
  
  //the lower body of the tank
  stroke(0);
  strokeWeight(7);
  fill(color(255.0,51.0,51.0));
  quad(200,300,50,500,950,500,800,300);
  
  //the upper body of the tank
  fill(color(255.0,0.0,0));
  rect(250,200,500,100);
  
  //the gun
  fill(color(255,51,51));
  rect(25,250,225,25);
  
  //the lid
  fill(color(255,102,0));
  triangle(500,160,300,200,700,200);
  
  //the windows
  noStroke();
  fill(color(51,204,255));
  quad(300,225,275,275,475,275,475,225);
  
  fill(color(51,204,255));
  quad(525,225,525,275,725,275,700,225);
  
  //the sun in the dessert
  stroke(0);
  strokeWeight(2);
  fill(color(255,204,51));
  ellipse(1000,0,300,300);
  
  //the sunbeams
  noStroke();
  rect(700,10,200,15);
  quad(810,200,825,225,900,10,875,5);
  rect(950,125,25,200);
}
  
