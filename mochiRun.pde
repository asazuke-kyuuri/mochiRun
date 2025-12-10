player sanpo;
something someLine1;
something someLine2;
something someLine3;
something someLine4;
observer obLine1;
observer obLine2;
observer obLine3;
observer obLine4;
boolean hit,hit1,hit2,hit3,hit4;
int hitThing;

void setup(){
  //基本設定
  size(1300,700);
  background(85,107,47);
  frameRate(60);
  rectMode(CENTER);
  imageMode(CENTER);
  
  //三方，みかん，衝突判定作ってみる
  sanpo=new player();
  someLine1=new something(175);
  someLine2=new something(325);
  someLine3=new something(475);
  someLine4=new something(625);
  obLine1=new observer(sanpo,someLine1);
  obLine2=new observer(sanpo,someLine2);
  obLine3=new observer(sanpo,someLine3);
  obLine4=new observer(sanpo,someLine4);
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
  someLine1.update();
  someLine2.update();
  someLine3.update();
  someLine4.update();
  hit1=obLine1.update();
  hit2=obLine2.update();
  hit3=obLine3.update();
  hit4=obLine4.update();
  
  hitThing=judge(hit1,hit2,hit3,hit4);
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

//総合的な衝突判定かつ，どのLineのが当たったのか
int judge(boolean hit1,boolean hit2,boolean hit3,boolean hit4){
  int Line1=someLine1.sc;
  int Line2=someLine2.sc;
  int Line3=someLine3.sc;
  int Line4=someLine4.sc;
  if(hit1||hit2||hit3||hit4){
    hit=true;
    if(hit1){
      return Line1;
    }
    else if(hit2){
      return Line2;
    }
    else if(hit3){
      return Line3;
    }
    else{
      return Line4;
    }
  }
  else{
    hit=false;
    return -1;
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
  int sc; //s-choice
  
  something(float iny){
    sx=100;
    sy=iny;
    sv=5;
    sc=2;
  }
  
  void update(){
    sx+=sv;
    if(sc==0){
      noFill();
      noStroke();
    }
    else if(sc==1){
      fill(255,140,0);
    }
    else if(sc==2){
      fill(255,255,240);
      stroke(0,0,0);
    }
    ellipse(sx,sy,30,30);
    if(sx>=1000){
      sx=0;
      sc=int(random(3));
    }
  }
  
  //何かsomethingに機能追加するならここから
}

//衝突判定クラス
class observer{
  player sanpo;
  something some;
  
  observer(player _sanpo,something _some){
    sanpo=_sanpo;
    some=_some;
  }
  
  boolean update(){
    if(sanpo.py==some.sy&&some.sc!=0&&dist(sanpo.px,sanpo.py,some.sx,some.sy)<=300){
      return true;
    }
    else{
      return false;
    }
  }
  
}
