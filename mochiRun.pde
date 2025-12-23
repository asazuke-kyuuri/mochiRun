player sanpo;
something someLine1,someLine2,someLine3,someLine4;
observer obLine1,obLine2,obLine3,obLine4;

boolean hit,hit1,hit2,hit3,hit4;
boolean ending=true;
int count=0,countLmt=20;
static PImage sanpoImg,mikanImg,mochiImg,kabiMikanImg,baconImg,eggImg,hamburgerImg,lettuceImg,tomatoImg,omuImg,macaronImg;


String scene="start";
int startTime;
final int gameFinish=10000;//120000;
boolean timeUp;

int buttonX,buttonY,buttonW = 200,buttonH = 70; 
int ruleBtnX, ruleBtnY,ruleBtnW = 150,ruleBtnH = 70;
int backBtnX, backBtnY,backBtnW = 150,backBtnH = 70;

PFont myFont;


void setup(){
  //基本設定
  size(1300,700);
  background(#6e7955);
  frameRate(60);
  rectMode(CENTER);
  imageMode(CENTER);
  textSize(50);
  textAlign(CENTER, CENTER);
  myFont = createFont("MS Gothic", 50, true); 
  textFont(myFont);
  
  //画像読み込み
  sanpoImg = loadImage("sanpo.png"); 
  sanpoImg.resize(140, 105);
  mikanImg = loadImage("mikan.png"); 
  mikanImg.resize(45, 40);
  mochiImg = loadImage("mochi.png");
  mochiImg.resize(75, 40);
  kabiMikanImg = loadImage("kabiMikan.png");
  kabiMikanImg.resize(45,40);
  baconImg = loadImage("bacon.png");
  baconImg.resize(75, 20);
  eggImg = loadImage("egg.png");
  eggImg.resize(75, 30);
  hamburgerImg = loadImage("hamburger.png");
  hamburgerImg.resize(75, 40);
  lettuceImg = loadImage("lettuce.png");
  lettuceImg.resize(75, 40);
  tomatoImg = loadImage("tomato.png");
  tomatoImg.resize(75, 40);
  omuImg = loadImage("omu.png");
  omuImg.resize(75, 40);
  macaronImg = loadImage("macaron.png"); 
  macaronImg.resize(45, 40);
  
  //クラスのインスタンス作成
  sanpo=new player();
  someLine1=new something(175);
  someLine2=new something(325);
  someLine3=new something(475);
  someLine4=new something(625);
  obLine1=new observer(sanpo,someLine1);
  obLine2=new observer(sanpo,someLine2);
  obLine3=new observer(sanpo,someLine3);
  obLine4=new observer(sanpo,someLine4);
  
  //ボタン定義
  buttonX = width/2;
  buttonY = height/2+200;
  ruleBtnX = 100;
  ruleBtnY = 50;
  backBtnX = width/2;
  backBtnY = height/2+300;
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
    resultScene(sanpo);
  }
  else if(scene=="rule"){
    ruleScene();
  }
}


/*毎フレーム実行*/
void common(){
  background(85,107,47);
}


/*スタート画面*/
void startScene(){
  //タイトル
  fill(#1f3134);
  textSize(250);
  text("もちばしり", width/2, height/2); 

  //スタートボタン
  fill(#95859c); 
  rect(buttonX, buttonY, buttonW, buttonH, 10); 
  fill(#e7e7eb); 
  textSize(32);
  String buttonText = "はじまり";
  text(buttonText,buttonX, buttonY);
  
  //ルールボタン
  fill(#705b67);
  rect(ruleBtnX, ruleBtnY, ruleBtnW, ruleBtnH, 10);
  fill(#e7e7eb);
  textSize(24);
  text("きまりごと", ruleBtnX, ruleBtnY);
}


/*ルール画面*/
void ruleScene(){
  //タイトル
  fill(0);
  textSize(40);
  text("きまりごと", width/2, 150);
  
  //説明
  textSize(30);
  text("自分だけの鏡餅を作ろう！\n道に落ちているアイテム", width/2, height/2);
  
  // 戻るボタンの描画
  fill(100);
  rect(backBtnX, backBtnY, backBtnW, backBtnH, 10);
  fill(255);
  textSize(24);
  text("戻る", backBtnX, backBtnY);
}


/*ゲーム画面*/
void gameScene(){
  //レーンの生成
  stroke(#dcd3b2);
  line(0,100,1300,100);
  line(0,250,1000,250);
  line(0,400,1000,400);
  line(0,550,1000,550);
  line(1000,0,1000,700);
  
  //各インスタンス更新
  sanpo.update(sanpo.px,sanpo.py);
  someLine1.update();
  someLine2.update();
  someLine3.update();
  someLine4.update();
  hit1=obLine1.update();
  hit2=obLine2.update();
  hit3=obLine3.update();
  hit4=obLine4.update();
  
  //当たり判定の実行
  judge(hit1,hit2,hit3,hit4);
  
  //経過時間の表示
  String timerString=timer();
  textSize(35);
  text(timerString,1150,50);
  if(timeUp){
    scene="result";
  }
}


/*リザルト画面*/
void resultScene(player sanpo){
  //終了メッセージ
  fill(0);
  textSize(50);
  text("完走!!!!!!!!!!", width/2, height/2 - 200);
  textSize(30); 
  fill(50);
  text("[押すとはじめにもどる]", width/2, height/2 + 200);
  
  //作成かがみもち
  sanpo.update(75,640);
  
  //かがみもちresult
  String NameStart="そなたのかがみもちは...";
  text(NameStart,width/2-200, height/2 - 100);
  String fullName="";
  int fullScore=0;
  //特殊かがみもち
  if(count==3&&sanpo.catchThings.get(0)==2&&sanpo.catchThings.get(1)==2&&sanpo.catchThings.get(2)==1){
    fullName="かがみもち";
    fullScore=100000;
  }
  //一般かがみもち
  else{
    fullName+="かがみ";
    for(int i=0;i<count;i++){
      int id=sanpo.catchThings.get(i);
      String itemName="";
      int score=0;
      switch(id){
        case 1:  
              itemName = "みかん";
              score=3;
              break;
        case 2:  
              itemName = "もち";
              score=2;
              break;
        case 4:  
              itemName = "ベーコン";
              score=4;
              break;
        case 5:  
              itemName = "たまご";
              score=3;
              break;
        case 6:  
              itemName = "バーガー";
              score=4;
              break;
        case 7:  
              itemName = "レタス";
              score=3;
              break;
        case 8:  
              itemName = "とまと";
              score=3;
              break;
        case 9:  
              itemName = "オムレツ";
              score=4;
              break;
        case 10: 
              itemName = "マカロン";
              score=4;
              break;
        default:
              break;
       }
      fullName+=" "+itemName;
      fullScore+=score;
    }
    fullName+=" もち";
  }
  //結果の表示
  textSize(35);
  fill(#e2041b);
  text(fullName,width/2,height/2,1000,40);
  text("得点："+fullScore+"点",width/2,height/2+100);
}


/*newGame時リセット*/
void reset() {
  ending=true;
  someLine1.sx = 0;
  someLine1.sc = 2;
  someLine2.sx = 0;
  someLine2.sc = 2;
  someLine3.sx = 0;
  someLine3.sc = 2;
  someLine4.sx = 0;
  someLine4.sc = 2;
}


/*開始などのボタンが押されたときに動く関数*/
void mousePressed(){
  //スタート画面
  if(scene == "start"){
    //スタートボタンの範囲判定
    if (abs(mouseX-buttonX)<=50&&abs(mouseY-buttonY)<=50) {
      scene = "game"; 
      
      //リセットする
      count = 0;
      sanpo.catchThings.clear();
      reset();
      startTime = millis();
    }
    
    //ルール説明ボタンの範囲判定
    if (abs(mouseX-ruleBtnX)<=50&&abs(mouseY-ruleBtnY)<=50) {
      scene = "rule"; 
    }
  }
  
  //ルール表示画面
  else if(scene=="rule"){
    if(abs(mouseX-backBtnX)<=50&&abs(mouseY-backBtnY)<=50){
      scene="start";
    }
  }
  
  //ゲーム画面中
  else if(scene == "game"){
    // ゲーム中はクリックしても何も起こらない
  }
  
  //リザルト画面
  else if(scene == "result"){
    // リザルトからタイトルへ戻る
    scene = "start";
  }
}

/*矢印ボタンが押されたタイミングでのみ動くsanpo移動関数*/
void keyPressed(){
  if(keyCode==UP){
    sanpo.up();
  }
  else if(keyCode==DOWN){
    sanpo.down();
  }
}


/*終了前強制ミカン*/
void ending(){
  someLine1.sx = 0;
  someLine1.sc = 1;
  someLine1.sv=27;
  someLine2.sx = 0;
  someLine2.sc = 1;
  someLine2.sv=27;
  someLine3.sx = 0;
  someLine3.sc = 1;
  someLine3.sv=27;
  someLine4.sx = 0;
  someLine4.sc = 1;
  someLine4.sv=27;
}


/*タイマー表示*/
String timer(){
  int elapsedTime = millis() - startTime; 
  timeUp = (elapsedTime >= gameFinish);
  int totalSeconds = ceil((gameFinish - elapsedTime) / 1000.0);
  if (totalSeconds < 0){
    totalSeconds = 0;
  }
  int m = totalSeconds / 60; // 分
  float ss = totalSeconds % 60; // 秒
  int s=int(ss);
  
  //ミカンエンディングの判定
  if(m==0&&ss<=1.2&&ending){
    ending=false;
    ending();
  }
  
  //return文字列
  String timeString = m + ":" + nf(s, 2);
  return timeString;
}


/*総合的な衝突判定かつ，どのLineのが当たったのか*/
void judge(boolean hit1,boolean hit2,boolean hit3,boolean hit4){
  //当たり判定->どのラインで当たったかのインスタンス保存
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
    
    //sanpoの現在のリストと照らし合わせ
    sanpo.thingsRegulate(currentThing.sc); //警告無視でいい
    //衝突したものは非表示に
    currentThing.sc=0;
  }
  else{
    hit=false;
  }
  
}


/*プレイヤークラス*/
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
  
  /*情報を更新して三方を表示*/
  void update(float nowX,float nowY){
    image(sanpoImg,nowX,nowY+25);
    float nowHeight=nowY+25-(sanpoImg.height/2)+10; //+10は調整
    for(int i=0;i<count;i++){
      int nowThing=catchThings.get(i);
      //もち重ね用の変数
      int beforeThing;
      if(i!=0){
        beforeThing=catchThings.get(i-1);
      }
      else{
        beforeThing=1;
      }
      //積み重ねアクション
      switch(nowThing){
        case 1:
              nowHeight=nowHeight-(mikanImg.height/2);
              image(mikanImg,nowX,nowHeight);
              nowHeight=nowHeight-(mikanImg.height/2);
              break;
        case 2:
              nowHeight=nowHeight-(mochiImg.height/2);
              if(beforeThing==2){
                nowHeight=nowHeight+15;
              }
              image(mochiImg,nowX,nowHeight);
              nowHeight=nowHeight-(mochiImg.height/2);
              break;
        case 4:
              nowHeight=nowHeight-(baconImg.height/2);
              image(baconImg,nowX,nowHeight);
              nowHeight=nowHeight-(baconImg.height/2);
              break;
        case 5:
              nowHeight=nowHeight-(eggImg.height/2);
              image(eggImg,nowX,nowHeight);
              nowHeight=nowHeight-(eggImg.height/2);
              break;
        case 6:
              nowHeight=nowHeight-(hamburgerImg.height/2)+10;
              image(hamburgerImg,nowX,nowHeight);
              nowHeight=nowHeight-(hamburgerImg.height/2);
              break;
        case 7:
              nowHeight=nowHeight-(lettuceImg.height/2);
              image(lettuceImg,nowX,nowHeight);
              nowHeight=nowHeight-(lettuceImg.height/2);
              break;
        case 8:
              nowHeight=nowHeight-(tomatoImg.height/2);
              image(tomatoImg,nowX,nowHeight);
              nowHeight=nowHeight-(tomatoImg.height/2);
              break;
        case 9:
              nowHeight=nowHeight-(omuImg.height/2)+10;
              image(omuImg,nowX,nowHeight);
              nowHeight=nowHeight-(omuImg.height/2);
              break;
        case 10:
              nowHeight=nowHeight-(macaronImg.height/2);
              image(macaronImg,nowX,nowHeight);
              nowHeight=nowHeight-(macaronImg.height/2);
              break;
        default:
                break;
      }
    }
  }
  
  /*いっこあがる*/
  void up(){
    if(py==175){
      py=625;
    }
    else{
      py-=150;
    }
  }
  
  /*いっこさがる*/
  void down(){
    if(py==625){
      py=175;
    }
    else{
      py+=150;
    }
  }
  
  /*ArrayListの管理*/
  void thingsRegulate(int choice){
    switch(choice){
      case 1:
            if(count>=countLmt){
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
            if(count>=countLmt){
              catchThings.remove(count-1);
              count--;
            }
            catchThings.add(count,choice);
            count++;
            break;
    }
  }
}


/*流れてくるものクラス*/
class something{
  float sx;
  float sy;
  float sv;
  int sc; //s-choice
  
  something(float iny){
    sx=100;
    sy=iny;
    sv=int(random(5,10));
    sc=2;
  }
  
  /*情報を更新して三方を表示*/
  void update(){
    sx+=sv;
    if(sc==0){
      noFill();
      noStroke();
      ellipse(sx,sy,1,1);
    }
    else if(sc==1||sc==13||sc==14){
      sc=1;
      image(mikanImg,sx,sy);
    }
    else if(sc==2||sc==11||sc==12){
      sc=2;
      image(mochiImg,sx,sy);
    }
    else if(sc==3||sc==15||sc==16){
      sc=3;
      image(kabiMikanImg,sx,sy);
    }
    else if(sc==4){
      image(baconImg,sx,sy);
    }
    else if(sc==5){
      image(eggImg,sx,sy);
    }
    else if(sc==6){
      image(hamburgerImg,sx,sy);
    }
    else if(sc==7){
      image(lettuceImg,sx,sy);
    }
    else if(sc==8){
      image(tomatoImg,sx,sy);
    }
    else if(sc==9){
      image(omuImg,sx,sy);
    }
    else if(sc==10){
      image(macaronImg,sx,sy);
    }
    //もしラインを超えていたら初めに戻す
    if(sx>=1000){
      sx=0;
      sv=int(random(5,10));
      sc=int(random(17));
    }
  }
}


/*衝突判定クラス*/
class observer{
  player sanpo;
  something some;
  
  observer(player _sanpo,something _some){
    sanpo=_sanpo;
    some=_some;
  }
  /*情報を更新して当たり判定を行う*/
  boolean update(){
    if(sanpo.py==some.sy&&some.sc!=0&&dist(sanpo.px,sanpo.py,some.sx,some.sy)<=250){
      return true;
    }
    else{
      return false;
    }
  }
}
