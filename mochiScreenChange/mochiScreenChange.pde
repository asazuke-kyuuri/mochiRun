String scene = "start";

// === シーン遷移用 タイマー変数 ===
int startTime; // ゲーム開始時のmillis()の値を保存
final int GAME_DURATION = 5000; // 10秒 (10000ミリ秒)

// === ボタンの定義のための変数 ===
int buttonX;
int buttonY;
int buttonW = 200; 
int buttonH = 70;  

void setup(){
  size(1300, 700);
  textSize(50);
  textAlign(CENTER, CENTER); // テキストを中央揃えに設定

  // ボタンの位置を画面中央に設定
  buttonX = width/2 - buttonW/2;
  buttonY = height/2 + 100 - buttonH/2;
}

void draw(){
  common();
  // シーンの切り替え
  if(scene == "start") start_scene();
  else if(scene == "game") game_scene();
  else if(scene == "clear") clear_scene();
}

void common(){
  background(255);
}

// === 各シーンの描画関数 ===

void start_scene(){
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

// === game_scene: 10秒経過判定のみ ===
void game_scene(){
  
  // 画面表示はシンプルに
  fill(0);
  textSize(50);
  text("Game", width/2, height/2);
  
  // ----------------------------------------------------
  // 10秒経過判定ロジック
  // ----------------------------------------------------
  
  int elapsedTime = millis() - startTime; 
  
  // if関数を使って10秒たったらtrue（終了）、たってなかったらfalse（続行）
  boolean time_up = (elapsedTime >= GAME_DURATION); 
  
  if (time_up) {
    // 終了（true）: リザルト画面へ
    scene = "clear";
  } 
  // else (false の場合は何もしない、つまり次のフレームも game_scene が実行される)
}

void clear_scene(){
  fill(0);
  textSize(50);
  text("CLEAR!!!!!!!!!!", width/2, height/2 - 30); // 終了メッセージ
  
  textSize(30); 
  fill(50);
  text("[Click to return to Title]", width/2, height/2 + 60);
}


void mousePressed(){
  if(scene == "start"){
    // スタートボタンの範囲判定
    if (mouseX >= buttonX && mouseX <= buttonX + buttonW &&
        mouseY >= buttonY && mouseY <= buttonY + buttonH) {
      
      scene = "game"; 
      startTime = millis(); // ★ゲーム開始時にタイマーをリセット
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
