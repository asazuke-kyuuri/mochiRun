player sanpo;

void setup(){
  //基本設定
  size(1300,700);
  background(85,107,47);
  frameRate(60);
  rectMode(CENTER);
  
  //三方作ってみる
  sanpo=new player();
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
  
  sanpo.update();
}

void keyPressed(){
  if(keyCode==UP){
    sanpo.up();
  }
  else if(keyCode==DOWN){
    sanpo.down();
  }
}

class player{
  //属性
  float px;
  float py;
  
  //初期状態の設定
  player(){
    px=1100;
    py=475;
  }
  
  //情報を更新して三方を表示
  void update(){
    fill(245,222,179);
    rect(px,py,200,20);
  }
  
  //いっこあがる
  void up(){
    if(py==175){
      py=625;
    }
    else{
      py-=150;
    }
  }
  
  //いっこさがる
  void down(){
    if(py==625){
      py=175;
    }
    else{
      py+=150;
    }
  }
  
  //何かplayerに機能追加するならここから
}
