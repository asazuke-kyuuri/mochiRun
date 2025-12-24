/**
 * もちばしり：アイテムを三方（さんぽう）に積み上げるアクションゲーム
 */

/** プレイヤーの操作対象となる三方インスタンス */
player sanpo;
/** 各レーン（4行分）に流れるアイテムの生成・更新用インスタンス */
something someLine1,someLine2,someLine3,someLine4;
/** プレイヤーと各レーンのアイテムとの衝突を監視するインスタンス */
observer obLine1,obLine2,obLine3,obLine4;

/** 各レーンごとの衝突判定結果を保持するフラグ */
boolean hit,hit1,hit2,hit3,hit4;
/** 現在三方に乗っているアイテムの数 */
int count=0;
/** アイテムの最大積載制限数 */
int countLmt=20;
/** カビミカンの残機数 */
int kabiCount=3;

/** 各種画像リソースを保持する静的変数 */
static PImage sanpoImg,mikanImg,mochiImg,kabiMikanImg,baconImg,eggImg,hamburgerImg,lettuceImg,tomatoImg,omuImg,macaronImg,kagamimochiImg,patissierImg,maniaImg,BLTImg,healthImg;

/** 現在の表示シーン（"start", "game", "result", "rule"） */
String scene="start";
/** 獲得コレクション */
boolean kagamimochi=false,patissier=false,mania=false,BLT=false,health=false;
/** ゲーム開始時のシステム時刻（ミリ秒） */
int startTime;
/** ゲームの制限時間設定（10000ミリ秒 = 10秒） */
final int gameFinish=20000;
/** タイムアップ（終了判定）の状態を保持するフラグ */
boolean timeUp;

/** スタートボタンの座標とサイズ設定 */
int buttonX,buttonY,buttonW = 200,buttonH = 70; 
/** ルールボタンの座標とサイズ設定 */
int ruleBtnX, ruleBtnY,ruleBtnW = 150,ruleBtnH = 70;
/** 戻るボタンの座標とサイズ設定 */
int backBtnX, backBtnY,backBtnW = 150,backBtnH = 70;
/** コレクションボタンの座標とサイズ設定 */
int collectBtnX, collectBtnY,collectBtnW = 150,collectBtnH = 70;

/** テキスト描画に使用するフォントデータ */
PFont myFont;

/**
 * プログラム実行時に一度だけ呼び出される初期設定。
 * 画面サイズ、リソース読み込み、インスタンス生成を行う。
 */
void setup(){
  size(1300,700);
  background(#6e7955);
  frameRate(60);
  rectMode(CENTER);
  imageMode(CENTER);
  textSize(50);
  textAlign(CENTER, CENTER);
  myFont = createFont("MS Gothic", 50, true); 
  textFont(myFont);
  
  // 画像データのロードとリサイズ
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
  kagamimochiImg=loadImage("kagamimochi.png");
  patissierImg=loadImage("patissier.png");
  maniaImg=loadImage("mania.png");
  BLTImg=loadImage("BLT.png");
  healthImg=loadImage("health.png");
  
  // クラスのインスタンス初期化
  sanpo=new player();
  someLine1=new something(175);
  someLine2=new something(325);
  someLine3=new something(475);
  someLine4=new something(625);
  obLine1=new observer(sanpo,someLine1);
  obLine2=new observer(sanpo,someLine2);
  obLine3=new observer(sanpo,someLine3);
  obLine4=new observer(sanpo,someLine4);
  
  // UIボタンの基準座標設定
  buttonX = width/2;
  buttonY = height/2+200;
  ruleBtnX = 100;
  ruleBtnY = 50;
  collectBtnX = 300;
  collectBtnY = 50;
  backBtnX = width/2;
  backBtnY = height/2+300;
}

/**
 * 毎フレーム呼び出されるメインループ。シーン管理を行う。
 */
void draw(){
  common();
  if(scene=="start"){
    startScene();
  }
  else if(scene=="game"){
    gameScene();
  }
  else if(scene=="gameOver"){
    gameOverScene();
  }
  else if(scene=="result"){
    resultScene(sanpo);
  }
  else if(scene=="rule"){
    ruleScene();
  }
  else if(scene=="collection"){
    collectScene();
  }
}

/**
 * 全シーン共通の背景描画処理。
 */
void common(){
  background(85,107,47);
}

/**
 * タイトルおよび操作ボタンを描画するスタート画面シーン。
 */
void startScene(){
  fill(#1f3134);
  textSize(250);
  text("もちばしり", width/2, height/2); 

  fill(#95859c); 
  rect(buttonX, buttonY, buttonW, buttonH, 10); 
  fill(#e7e7eb); 
  textSize(32);
  String buttonText = "はじまり";
  text(buttonText,buttonX, buttonY);
  
  fill(#705b67);
  rect(ruleBtnX, ruleBtnY, ruleBtnW, ruleBtnH, 10);
  fill(#e7e7eb);
  textSize(24);
  text("きまりごと", ruleBtnX, ruleBtnY);
  
  fill(#705b67);
  rect(collectBtnX, collectBtnY, collectBtnW, collectBtnH, 10);
  fill(#e7e7eb);
  textSize(24);
  text("コレクション", collectBtnX, collectBtnY);
}

/**
 * 操作方法やゲーム内容を説明するルール画面シーン。
 */
void ruleScene(){
  fill(0);
  textSize(40);
  text("きまりごと", width/2, 150);
  
  textSize(30);
  text("自分だけの鏡餅を作ろう！\n矢印キーで三方を操作して，流れてくる食べ物をキャッチしよう！\nスコアは積んだ食べ物の文字数の合計だよ\nいっぱい積んで自分だけのかがみもちを作ろう！", width/2, height/2-50);
  
  image(kabiMikanImg,width/4,height/1.6);
  textSize(20);
  text("カビみかんをとると，一番上の食べ物がなくなるよ\n4個めを取るとゲームオーバーになっちゃうから気を付けてね",width/4,height/1.4);
  
  fill(100);
  rect(backBtnX, backBtnY, backBtnW, backBtnH, 10);
  fill(255);
  textSize(24);
  text("戻る", backBtnX, backBtnY);
}

/**
 * コレクション画面シーン。
 */
void collectScene(){
  fill(0);
  textSize(40);
  text("コレクション", width/2, 150);
  textSize(30);
  text("いい感じに3つだけ積むとコレクションができるかも．．．", width/2, height/2-150);
  
  text("かがみもち",width/6,550);
  text("パティシエ",(width/6)*2,550);
  text("ハンバーガー\nジャンキー",(width/6)*3,550);
  text("BLT",(width/6)*4,550);
  text("健康志向",(width/6)*5,550);
  
  if(kagamimochi){
    image(kagamimochiImg,width/6,400);
  }
  if(patissier){
    image(patissierImg,(width/6)*2,400);
  }
  if(mania){
    image(maniaImg,(width/6)*3,400);
  }
  if(BLT){
    image(BLTImg,(width/6)*4,400);
  }
  if(health){
    image(healthImg,(width/6)*5,400);
  }
  
  fill(100);
  rect(backBtnX, backBtnY, backBtnW, backBtnH, 10);
  fill(255);
  textSize(24);
  text("戻る", backBtnX, backBtnY);
  
}

/**
 * メインのアクションシーン。各オブジェクトの更新と判定、タイマー表示を行う。
 */
void gameScene(){
  stroke(#dcd3b2);
  line(0,100,1300,100);
  line(0,250,1000,250);
  line(0,400,1000,400);
  line(0,550,1000,550);
  line(1000,0,1000,700);
  
  sanpo.update(sanpo.px,sanpo.py);
  someLine1.update();
  someLine2.update();
  someLine3.update();
  someLine4.update();
  hit1=obLine1.update();
  hit2=obLine2.update();
  hit3=obLine3.update();
  hit4=obLine4.update();
  
  judge(hit1,hit2,hit3,hit4);
  
  String timerString=timer();
  textSize(35);
  text(timerString,1150,50);
  
  kabiLife(kabiCount);
  
  if(kabiCount==0){
    startTime=millis();
    scene="gameOver";
  }
  
  if(timeUp){
    scene="result";
  }
}

/**
 * ゲームオーバーを表示するシーン。
 */
void gameOverScene(){
  background(85,107,47);
  sanpo.update(75,600);
  
  fill(255, 0, 0);
  textSize(80);
  text("Game Over...", width/2, height/2);
  
  // 2秒（2000ミリ秒）経過したらリザルトへ
  if(millis() - startTime > 2000){
    scene = "result";
  }
}

/**
 * ゲーム終了時の結果を表示するシーン。
 * スコア計算、アイテム名合成、および獲得した鏡餅の表示を行う。
 * @param sanpo プレイヤーの所持アイテムを参照するためのプレイヤーインスタンス
 */
void resultScene(player sanpo){
  fill(0);
  textSize(50);
  text("完走!!!!!!!!!!", width/2, height/2 - 150);
  textSize(30); 
  fill(50);
  text("[押すとはじめにもどる]", width/2, height/2 + 200);
  
  sanpo.update(75,640);
  
  String NameStart="そなたのかがみもちは...";
  text(NameStart,width/2-200, height/2 - 100);
  String fullName="";
  int fullScore=0;

  // 特殊な組み合わせ判定
  if(count==3&&sanpo.catchThings.get(0)==2&&sanpo.catchThings.get(1)==2&&sanpo.catchThings.get(2)==1){
    fullName="かがみもち";
    fullScore=100000000;
    kagamimochi=true;
  }
  else if(count==3&&sanpo.catchThings.get(0)==10&&sanpo.catchThings.get(1)==10&&sanpo.catchThings.get(2)==10){
    fullName="パティシエ";
    fullScore=100000;
    patissier=true;
  }
  else if(count==3&&sanpo.catchThings.get(0)==6&&sanpo.catchThings.get(1)==6&&sanpo.catchThings.get(2)==6){
    fullName="ハンバーガージャンキー";
    fullScore=100000;
    mania=true;
  }
  else if(count==3&&sanpo.catchThings.get(0)==4&&sanpo.catchThings.get(1)==7&&sanpo.catchThings.get(2)==8){
    fullName="BLT";
    fullScore=100000;
    BLT=true;
  }
  else if(count==3&&sanpo.catchThings.get(0)==7&&sanpo.catchThings.get(1)==7&&sanpo.catchThings.get(2)==7){
    fullName="健康志向";
    fullScore=100000;
    health=true;
  }
  else{
    fullName+="かがみ";
    for(int i=0;i<count;i++){
      int id=sanpo.catchThings.get(i);
      String itemName="";
      int score=0;
      switch(id){
        case 1:  itemName = "みかん"; score=3; break;
        case 2:  itemName = "もち"; score=2; break;
        case 4:  itemName = "ベーコン"; score=4; break;
        case 5:  itemName = "たまご"; score=3; break;
        case 6:  itemName = "バーガー"; score=4; break;
        case 7:  itemName = "レタス"; score=3; break;
        case 8:  itemName = "とまと"; score=3; break;
        case 9:  itemName = "オムレツ"; score=4; break;
        case 10: itemName = "マカロン"; score=4; break;
        default: break;
       }
      fullName+=" "+itemName;
      if((i+1)!=0&&(i+1)%5==0){
        fullName+="\n";
      }
      fullScore+=score;
    }
    fullName+=" もち";
  }
  textSize(35);
  fill(#e2041b);
  text(fullName, width/2, height/2, 1100, 250);
  text("得点："+fullScore+"点",width/2,height/2+100);
}

/**
 * ゲームの再開準備として演出フラグや各レーンのアイテム位置・種類を初期化する。
 */
void reset() {
  kabiCount=3;
  someLine1.sx = 0;
  someLine1.sc = 4;
  someLine2.sx = 0;
  someLine2.sc = 7;
  someLine3.sx = 0;
  someLine3.sc = 8;
  someLine4.sx = 0;
  someLine4.sc = 4;
}

/**
 * 画面上のボタンに対するクリック判定およびシーン遷移、ゲーム開始リセットを行う。
 */
void mousePressed(){
  if(scene == "start"){
    if (abs(mouseX-buttonX)<=50&&abs(mouseY-buttonY)<=50) {
      scene = "game"; 
      count = 0;
      sanpo.catchThings.clear();
      reset();
      startTime = millis();
    }
    if (abs(mouseX-ruleBtnX)<=80&&abs(mouseY-ruleBtnY)<=50) {
      scene = "rule"; 
    }
    if (abs(mouseX-collectBtnX)<=80&&abs(mouseY-collectBtnY)<=50) {
      scene = "collection"; 
    }
  }
  else if(scene=="rule"){
    if(abs(mouseX-backBtnX)<=80&&abs(mouseY-backBtnY)<=50){
      scene="start";
    }
  }
  else if(scene=="collection"){
    if(abs(mouseX-backBtnX)<=80&&abs(mouseY-backBtnY)<=50){
      scene="start";
    }
  }
  else if(scene == "game"){
  }
  else if(scene == "result"){
    scene = "start";
  }
}

/**
 * キーボード入力を受け取り、プレイヤーの上移動・下移動命令を発行する。
 */
void keyPressed(){
  if(keyCode==UP){
    sanpo.up();
  }
  else if(keyCode==DOWN){
    sanpo.down();
  }
}


/**
 * 経過時間を管理し、残り時間文字列を生成。終了1.2秒前の演出トリガー判定も行う。
 * @return "分:秒"形式の残り時間文字列
 */
String timer(){
  int elapsedTime = millis() - startTime; 
  timeUp = (elapsedTime >= gameFinish);
  int totalSeconds = ceil((gameFinish - elapsedTime) / 1000.0);
  if (totalSeconds < 0){
    totalSeconds = 0;
  }
  int m = totalSeconds / 60; 
  int s=totalSeconds % 60; 
  
  String timeString = m + ":" + nf(s, 2);
  return timeString;
}

/**
 * カビみかん獲得個数による残りライフの表示を行う．
 */
void kabiLife(int kabiCount){
  float kabiWidth=kabiMikanImg.width/2+5,kabiHeight=50;
  for(int i=0;i<kabiCount;i++){
    image(kabiMikanImg,kabiWidth,kabiHeight);
    kabiWidth+=kabiMikanImg.width+5;
  }
}

/**
 * 各レーンでの衝突判定結果を統合し、衝突があった場合にプレイヤーの所持品リストを更新する。
 * @param hit1〜hit4 各レーンごとの衝突有無
 */
void judge(boolean hit1,boolean hit2,boolean hit3,boolean hit4){
  something currentThing=null;
  if(hit1||hit2||hit3||hit4){
    hit=true;
    if(hit1){ currentThing=someLine1; }
    else if(hit2){ currentThing=someLine2; }
    else if(hit3){ currentThing=someLine3; }
    else if(hit4){ currentThing=someLine4; }
    
    sanpo.thingsRegulate(currentThing.sc); 
    currentThing.sc=0;
  }
  else{
    hit=false;
  }
}

/**
 * プレイヤー（三方）および積み上げられたアイテムの状態管理と描画を担当するクラス。
 */
class player{
  float px;
  float py;
  /** 所持しているアイテムIDを格納する動的配列 */
  ArrayList<Integer> catchThings; 
  
  player(){
    px=1150;
    py=475;
    catchThings=new ArrayList<Integer>();
  }
  
  /**
   * 三方の土台と、積み上げられたアイテムを現在のリスト順に描画する。
   * @param nowX 描画位置のX座標
   * @param nowY 描画位置のY座標（土台の基準点）
   */
  void update(float nowX,float nowY){
    image(sanpoImg,nowX,nowY+25);
    float nowHeight=nowY+25-(sanpoImg.height/2)+10; 
    for(int i=0;i<count;i++){
      int nowThing=catchThings.get(i);
      int beforeThing;
      if(i!=0){
        beforeThing=catchThings.get(i-1);
      }
      else{
        beforeThing=1;
      }
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
  
  /** プレイヤーを一つ上のレーンへ移動。一番上の場合は一番下へループする。 */
  void up(){
    if(py==175){ py=625; }
    else{ py-=150; }
  }
  
  /** プレイヤーを一つ下のレーンへ移動。一番下の場合は一番上へループする。 */
  void down(){
    if(py==625){ py=175; }
    else{ py+=150; }
  }
  
  /**
   * 取得したアイテムをリストに追加、またはカビみかん（ID:3）による削除を行う。
   * 最大個数(countLmt)を超えた場合は古いものを削除して追加する。
   * @param choice 取得したアイテムのID
   */
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
            kabiCount--;
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

/**
 * レーン上に流れるアイテム（または障害物）を管理するクラス。
 */
class something{
  float sx;
  float sy;
  float sv;
  /** 表示するアイテムの種類を決定するID */
  int sc; 
  
  something(float iny){
    sx=100;
    sy=iny;
    sv=int(random(5,10));
    sc=2;
  }
  
  /**
   * アイテムの移動を更新し、対応する画像を描画する。画面端到達で再抽選を行う。
   */
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
    if(sx>=1000){
      sx=0;
      sv=int(random(5,10));
      sc=int(random(17));
    }
  }
}

/**
 * プレイヤーとレーン上のアイテムとの衝突（位置関係の重複）を判定するクラス。
 */
class observer{
  player sanpo;
  something some;
  
  observer(player _sanpo,something _some){
    sanpo=_sanpo;
    some=_some;
  }
  
  /**
   * 現在のプレイヤー座標とアイテム座標、および衝突半径を計算して衝突の成否を返す。
   * @return 衝突していれば true、していなければ false
   */
  boolean update(){
    if(sanpo.py==some.sy&&some.sc!=0&&dist(sanpo.px,sanpo.py,some.sx,some.sy)<=250){
      return true;
    }
    else{
      return false;
    }
  }
}
