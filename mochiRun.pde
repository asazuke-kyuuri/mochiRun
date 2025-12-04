float sanpoX=1100;
float sanpoY=475;
float moveSpeed=10;
float foodPlace=175;
float moveXLimit=1000;

PShape sanpoShape;

void setup(){
  //基本設定
  size(1300,700);
  background(85,107,47);
  frameRate(60);
  rectMode(CENTER);
  
  
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
  
  //三方の図形グループ
  sanpoShape=createShape(GROUP);
  
  PShape plate=createShape(RECT,1100,sanpoY,200,20);
  plate.setFill(color(245,222,179));
  sanpoShape.addChild(plate);
  
  PShape stand=createShape(RECT,1100,sanpoY+35,100,50);
  stand.setFill(color(245,222,179));
  sanpoShape.addChild(stand);
  
  PShape hole=createShape(ELLIPSE,1100,sanpoY+35,25,25);
  hole.setFill(color(85,107,47));
  sanpoShape.addChild(hole);
  shape(sanpoShape,0,0);
}

class Player{

}
