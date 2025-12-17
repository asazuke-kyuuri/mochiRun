String scene = "start";

//日本語にいる
PFont myFont;

// === シーン遷移用 タイマー変数 ===
int startTime; 
final int GAME_DURATION = 10000; 

// === 中央のスタートボタン ===
int buttonX, buttonY;
int buttonW = 200; 
int buttonH = 70;  

// === 左上のボタン（ルール） ===
int leftBtnX, leftBtnY;
int leftBtnW = 150;
int leftBtnH = 60;

// === 右上のボタン（設定） ===
int rightBtnX, rightBtnY;
int rightBtnW = 150;
int rightBtnH = 60;

// === ★追加：戻るボタン（各画面共通） ===
int backBtnX, backBtnY;
int backBtnW = 200;
int backBtnH = 60;

void setup(){
  size(1300, 700);
  textSize(50);
  textAlign(CENTER, CENTER);
  
 //日本語にいる
  myFont = createFont("MS Gothic", 50, true); 
  textFont(myFont); 

  textAlign(CENTER, CENTER);

  // 中央ボタンの位置
  buttonX = width/2 - buttonW/2;
  buttonY = height/2 + 100 - buttonH/2;

  // 左上ボタンの位置
  leftBtnX = 50;
  leftBtnY = 50;

  // 右上ボタンの位置
  rightBtnX = width - rightBtnW - 50;
  rightBtnY = 50;
  
  // ★戻るボタンの位置（画面の下の方）
  backBtnX = width/2 - backBtnW/2;
  backBtnY = height - 100;
}

void draw(){
  common();
  // シーンによって表示する関数を変える
  if(scene == "start") start_scene();
  else if(scene == "game") game_scene();
  else if(scene == "clear") clear_scene();
  else if(scene == "rule") rule_scene(); 
  else if(scene == "setting") setting_scene(); 
}

void common(){
  background(255);
}

// === 各シーンの描画関数 ===

void start_scene(){
  fill(0);
  textSize(50);
  text("MOCHI RUN", width/2, height/2); 

  // --- 1. 中央のスタートボタン ---
  fill(50, 200, 50); 
  rect(buttonX, buttonY, buttonW, buttonH, 10); 
  fill(255); 
  textSize(32);
  text("START", buttonX + buttonW/2, buttonY + buttonH/2);

  // --- 2. 左上のボタン（RULE） ---
  fill(200, 200, 200);
  rect(leftBtnX, leftBtnY, leftBtnW, leftBtnH, 10);
  fill(0);
  textSize(24);
  text("ルール", leftBtnX + leftBtnW/2, leftBtnY + leftBtnH/2);

  // --- 3. 右上のボタン（SETTING） ---
  fill(192, 192, 192);
  rect(rightBtnX, rightBtnY, rightBtnW, rightBtnH, 10);
  fill(0);
  textSize(24);
  text("設定", rightBtnX + rightBtnW/2, rightBtnY + rightBtnH/2);
}

// ルール画面 
void rule_scene(){
  fill(0);
  textSize(40);
  text("- ルール -", width/2, 150);
  
  textSize(30);
  text("自分だけの鏡餅を作ろう！\n道に落ちているアイテム", width/2, height/2);
  
  // 戻るボタンの描画
  fill(100);
  rect(backBtnX, backBtnY, backBtnW, backBtnH, 10);
  fill(255);
  textSize(24);
  text("戻る", backBtnX + backBtnW/2, backBtnY + backBtnH/2);
}

// 設定画面
void setting_scene(){
  fill(0);
  textSize(40);
  text("- 設定 -", width/2, 150);
  
  textSize(30);
  text("", width/2, height/2 - 30);
  text("", width/2, height/2 + 30);
  
  // 戻るボタン
  fill(100);
  rect(backBtnX, backBtnY, backBtnW, backBtnH, 10);
  fill(255);
  textSize(24);
  text("戻る", backBtnX + backBtnW/2, backBtnY + backBtnH/2);
}

void game_scene(){
  fill(0);
  textSize(50);
  text("ゲーム中", width/2, height/2);
  
  int elapsedTime = millis() - startTime; 
  boolean time_up = (elapsedTime >= GAME_DURATION); 
  
  if (time_up) {
    scene = "clear";
  } 
}

void clear_scene(){
  fill(0);
  textSize(50);
  text("クリア!!!", width/2, height/2 - 30);
  
  textSize(30); 
  fill(50);
  text("[クリックしてタイトルへ]", width/2, height/2 + 60);
}

void mousePressed(){
  // === スタート画面でのクリック ===
  if(scene == "start"){
    // スタートボタン
    if (mouseX >= buttonX && mouseX <= buttonX + buttonW &&
        mouseY >= buttonY && mouseY <= buttonY + buttonH) {
      scene = "game"; 
      startTime = millis(); 
    }
    // ルール画面へ
    if (mouseX >= leftBtnX && mouseX <= leftBtnX + leftBtnW &&
        mouseY >= leftBtnY && mouseY <= leftBtnY + leftBtnH) {
      scene = "rule"; 
    }
    // 設定画面へ
    if (mouseX >= rightBtnX && mouseX <= rightBtnX + rightBtnW &&
        mouseY >= rightBtnY && mouseY <= rightBtnY + rightBtnH) {
      scene = "setting";
    }
  }
  
  // ルール画面
  else if(scene == "rule"){
    if (mouseX >= backBtnX && mouseX <= backBtnX + backBtnW &&
        mouseY >= backBtnY && mouseY <= backBtnY + backBtnH) {
      scene = "start"; // タイトルに戻る
    }
  }
  
  // 設定画面
  else if(scene == "setting"){
    if (mouseX >= backBtnX && mouseX <= backBtnX + backBtnW &&
        mouseY >= backBtnY && mouseY <= backBtnY + backBtnH) {
      scene = "start"; // タイトルに戻る
    }
  }
  
  else if(scene == "game"){
    // ゲーム中のクリック（なし）
  }
  else if(scene == "clear"){
    scene = "start";
  }
}
