player sanpo;
something someLine1,someLine2,someLine3,someLine4;
observer obLine1,obLine2,obLine3,obLine4;

boolean hit,hit1,hit2,hit3,hit4;
int hitThing;

static PImage sanpoImg,mikanImg,mochiImg,kabiMikanImg;
int count=0;
boolean ending;

String scene="start";
int startTime;
final int gameFinish=10000;//120000;

int buttonX,buttonY,buttonW = 200,buttonH = 70; 

void setup(){
  //基本設定
  size(1300,700);
  background(85,107,47);
  frameRate(60);
  rectMode(CENTER);
  imageMode(CENTER);
  textSize(50);
  textAlign(CENTER, CENTER);
  
  //画像読み込み
  sanpoImg = loadImage("sanpo.png"); 
  sanpoImg.resize(140, 105);
  mikanImg = loadImage("mikan.png"); 
  mikanImg.resize(45, 40);
  mochiImg = loadImage("mochi.png");
  mochiImg.resize(75, 40);
  kabiMikanImg = loadImage("kabiMikan.png");
  kabiMikanImg.resize(45,40);
  
  //クラスのインスタンス作ってみる
  sanpo=new player();
  someLine1=new something(175);
  someLine2=new something(325);
  someLine3=new something(475);
  someLine4=new something(625);
  obLine1=new observer(sanpo,someLine1);
  obLine2=new observer(sanpo,someLine2);
  obLine3=new observer(sanpo,someLine3);
  obLine4=new observer(sanpo,someLine4);
  
  //ボタン定義する
  buttonX = width/2 - buttonW/2;
  buttonY = height/2 + 100 - buttonH/2;
}

void draw(){
  common();
  if(scene=="start"){
    startScene();
  }
  else if(scene=="game"){
    gameScene();
  }
  else if(scene=="result"){
    resultScene();
  }
}

//毎フレーム必ずdrawされる
void common(){
  background(85,107,47);
}

//スタート画面
void startScene(){
  fill(0);
  textSize(50);
  text("MOTHI RUN", width/2, height/2); 

  // --- Draw Start Button ---
  fill(50, 200, 50); 
  rect(buttonX, buttonY, buttonW, buttonH, 10); 

  fill(255); 
  textSize(32);
  String buttonText = "START";
  text(buttonText, buttonX + buttonW/2, buttonY + buttonH/2);
}

//ゲーム画面
void gameScene(){
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
  
  judge(hit1,hit2,hit3,hit4);
  
  //経過時間の判定
  int nowTime=millis()-startTime;
  boolean timeUp=(nowTime>=gameFinish);
  if(timeUp){
    scene="result";
  }
}

//リザルト画面
void resultScene(){
  fill(0);
  textSize(50);
  text("CLEAR!!!!!!!!!!", width/2, height/2 - 30); // 終了メッセージ
  
  textSize(30); 
  fill(50);
  text("[Click to return to Title]", width/2, height/2 + 60);
}

//開始などのボタンが押されたときに動く関数
void mousePressed(){
  if(scene == "start"){
    //スタートボタンの範囲判定
    if (mouseX >= buttonX && mouseX <= buttonX + buttonW &&
        mouseY >= buttonY && mouseY <= buttonY + buttonH) {
      
      scene = "game"; 
      startTime = millis(); //ゲーム開始時にタイマーをリセット
    }
  }
  else if(scene == "game"){
    // ゲーム中はクリックしても何も起こらない
  }
  else if(scene == "clear"){
    // リザルトからタイトルへ戻る
    scene = "start";
  }
}

//矢印ボタンが押されたタイミングでのみ動く関数
void keyPressed(){
  if(keyCode==UP){
    sanpo.up();
  }
  else if(keyCode==DOWN){
    sanpo.down();
  }
}

//総合的な衝突判定かつ，どのLineのが当たったのか
void judge(boolean hit1,boolean hit2,boolean hit3,boolean hit4){
  something currentThing=null;
  if(hit1||hit2||hit3||hit4){
    hit=true;
    
    if(hit1){
      currentThing=someLine1;
    }
    else if(hit2){
      currentThing=someLine2;
    }
    else if(hit3){
      currentThing=someLine3;
    }
    else if(hit4){
      currentThing=someLine4;
    }
    
    sanpo.thingsRegulate(currentThing.sc); //警告無視でいい
    currentThing.sc=0;
  }
  else{
    hit=false;
  }
  
}

//プレイヤークラス
class player{
  //属性
  float px;
  float py;
  ArrayList<Integer> catchThings; //ラッパークラスの使用(int<->Integer)
  
  //初期状態の設定
  player(){
    px=1150;
    py=475;
    catchThings=new ArrayList<Integer>();
  }
  
  //情報を更新して三方を表示
  void update(){
    image(sanpoImg,px,py+25);
    float nowHeight=py+25-(sanpoImg.height/2)+10; //+10は調整
    for(int i=0;i<count;i++){
      int nowThing=catchThings.get(i);
      switch(nowThing){
        case 1:
              nowHeight=nowHeight-(mikanImg.height/2);
              image(mikanImg,px,nowHeight);
              nowHeight=nowHeight-(mikanImg.height/2);
              break;
        case 2:
              nowHeight=nowHeight-(mochiImg.height/2);
              image(mochiImg,px,nowHeight);
              nowHeight=nowHeight-(mochiImg.height/2);
              break;
        default:
                break;
      }
    }
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
  
  //ArrayListの管理
  void thingsRegulate(int choice){
    switch(choice){
      case 1:
            ending=true;
            if(count>=10){
              catchThings.remove(count-1);
              count--;
            }
            catchThings.add(count,choice);
            count++;
            break;
      case 3:
            if(count!=0){
              catchThings.remove(count-1);
              count--;
            }
            break;
      default:
            if(count>=10){
              catchThings.remove(count-1);
              count--;
            }
            catchThings.add(count,choice);
            count++;
            break;
    }
  }
  //
  
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
    sv=7;
    sc=2;
  }
  
  void update(){
    sx+=sv;
    if(sc==0){
      noFill();
      noStroke();
      ellipse(sx,sy,1,1);
    }
    else if(sc==1){
      image(mikanImg,sx,sy);
    }
    else if(sc==2){
      image(mochiImg,sx,sy);
    }
    else if(sc==3){
      image(kabiMikanImg,sx,sy);
    }
    
    if(sx>=1000){
      sx=0;
      sv=int(random(5,10));
      sc=int(random(4));
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
    if(sanpo.py==some.sy&&some.sc!=0&&dist(sanpo.px,sanpo.py,some.sx,some.sy)<=250){
      return true;
    }
    else{
      return false;
    }
  }
  
}
