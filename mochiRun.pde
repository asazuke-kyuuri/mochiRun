float sanpoX=1100;
float moveSpeed=10;
float foodPlace=175;
float moveXLimit=1000;


void setup(){
  size(1300,700);
  background(85,107,47);
  rectMode(CENTER);
  frameRate(60);
}

void draw(){
  background(85,107,47);
  stroke(255,248,220);
  line(0,100,1300,100);
  line(0,250,1000,250);
  line(0,400,1000,400);
  line(0,550,1000,550);
  
  fill(255,250,240);
  ellipse(700,175,100,50);
  ellipse(900,475,80,50);
  fill(255,140,0);
  ellipse(300,625,30,30);
  fill(245,222,179);
  rect(sanpoX,475,150,20);
  rect(sanpoX,505,90,40);
}
