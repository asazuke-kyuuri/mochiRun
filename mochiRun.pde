player sanpo;
something orange;
observer observe;
boolean hit;

void setup(){
  //基本設定
  size(1300,700);
  background(85,107,47);
  frameRate(60);
  rectMode(CENTER);
  imageMode(CENTER);
  
  //三方，みかん，衝突判定作ってみる
  sanpo=new player();
  orange=new something();
  observe=new observer(sanpo,orange);
}

void draw(){
  //毎フレーム上書きするものたち
  background(85,107,47);
  stroke(255,248,220);
  line(0,100,1300,100);
  line(0,250,1000,250);
  line(0,400,1000,400);
  line(0,550,1000,550);
  line(1000,0,1000,700);
  
  sanpo.update();
  orange.update();
  observe.update();
}

//ボタンが押されたタイミングでのみ動く関数
void keyPressed(){
  if(keyCode==UP){
    sanpo.up();
  }
  else if(keyCode==DOWN){
    sanpo.down();
  }
}

//プレイヤークラス
class player{
  //属性
  float px;
  float py;
  
  //初期状態の設定
  player(){
    px=1200;
    py=475;
  }
  
  //情報を更新して三方を表示
  void update(){
    if(hit){
      fill(255,0,0);
    }
    else{
      fill(245,222,179);
    } 
    rect(px,py,150,20);
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

//流れてくるものクラス
class something{
  float sx;
  float sy;
  float sv;
  
  something(){
    sx=100;
    sy=475;
    sv=5;
  }
  
  void update(){
    sx+=sv;
    fill(255,140,0);
    ellipse(sx,sy,30,30);
    if(sx>=1000){
      sx=0;
      sy=175+150*int(random(0,4));
    }
  }
  
  //何かsomethingに機能追加するならここから
}

//衝突判定クラス
class observer{
  player sanpo;
  something some;
  
  observer(player _sanpo,something _orange){
    sanpo=_sanpo;
    some=_orange;
  }
  
  void update(){
    if(sanpo.py==some.sy&&dist(sanpo.px,sanpo.py,some.sx,some.sy)<=300){
      hit=true;
    }
    else{
      hit=false;
    }
  }
  
}
