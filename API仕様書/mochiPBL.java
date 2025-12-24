//import processing.core.*;
import java.util.ArrayList;

/** ダミー定義：Javadoc生成用の空クラス */
class PApplet { public float width, height, mouseX, mouseY; public void size(int w, int h){} public void background(int c){} public void frameRate(int f){} public void rectMode(int m){} public void imageMode(int m){} public void textSize(int s){} public void textAlign(int x, int y){} public void textFont(Object f){} public void fill(int c){} public void fill(int c, float a){} public void text(String s, float x, float y){} public void text(String s, float x, float y, float w, float h){} public void rect(float x, float y, float w, float h, float r){} public void line(float x1, float y1, float x2, float y2){} public void stroke(int c){} public void noFill(){} public void noStroke(){} public void ellipse(float x, float y, float w, float h){} public float dist(float x1, float y1, float x2, float y2){return 0;} public int millis(){return 0;} public float random(float m){return 0;} public float random(float l, float h){return 0;} public float ceil(float n){return 0;} public String nf(int n, int d){return "";} public Object createFont(String n, int s, boolean b){return null;} public Object loadImage(String p){return null;} public static final int CENTER = 0; public static final int UP = 0; public static final int DOWN = 0; public int keyCode; }
/** ダミー定義 */
class PImage { public float width, height; public void resize(int w, int h){} }
/** ダミー定義 */
class PFont {}

/**
 * もちばしり：アイテムを三方（さんぽう）に積み上げるアクションゲーム
 */
public class mochiPBL extends PApplet {

    player sanpo;
    something someLine1, someLine2, someLine3, someLine4;
    observer obLine1, obLine2, obLine3, obLine4;

    boolean hit, hit1, hit2, hit3, hit4;
    boolean ending = true;
    int count = 0, countLmt = 20;
    static PImage sanpoImg, mikanImg, mochiImg, kabiMikanImg, baconImg, eggImg, hamburgerImg, lettuceImg, tomatoImg, omuImg, macaronImg;

    String scene = "start";
    int startTime;
    final int gameFinish = 10000; // 本番は60000
    boolean timeUp;

    int buttonX, buttonY, buttonW = 200, buttonH = 70;
    int ruleBtnX, ruleBtnY, ruleBtnW = 150, ruleBtnH = 70;
    int backBtnX, backBtnY, backBtnW = 150, backBtnH = 70;

    PFont myFont;

    public void setup() {
        // 基本設定
        size(1300, 700);
        background(0xFF6E7955);
        frameRate(60);
        rectMode(CENTER);
        imageMode(CENTER);
        textSize(50);
        textAlign(CENTER, CENTER);
        myFont = createFont("MS Gothic", 50, true);
        textFont(myFont);

        // 画像読み込み
        sanpoImg = loadImage("sanpo.png");
        sanpoImg.resize(140, 105);
        mikanImg = loadImage("mikan.png");
        mikanImg.resize(45, 40);
        mochiImg = loadImage("mochi.png");
        mochiImg.resize(75, 40);
        kabiMikanImg = loadImage("kabiMikan.png");
        kabiMikanImg.resize(45, 40);
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

        // クラスのインスタンス作成
        sanpo = new player();
        someLine1 = new something(175);
        someLine2 = new something(325);
        someLine3 = new something(475);
        someLine4 = new something(625);
        obLine1 = new observer(sanpo, someLine1);
        obLine2 = new observer(sanpo, someLine2);
        obLine3 = new observer(sanpo, someLine3);
        obLine4 = new observer(sanpo, someLine4);

        // ボタン定義
        buttonX = width / 2;
        buttonY = height / 2 + 200;
        ruleBtnX = 100;
        ruleBtnY = 50;
        backBtnX = width / 2;
        backBtnY = height / 2 + 300;
    }

    public void draw() {
        common();
        if (scene.equals("start")) {
            startScene();
        } else if (scene.equals("game")) {
            gameScene();
        } else if (scene.equals("result")) {
            resultScene(sanpo);
        } else if (scene.equals("rule")) {
            ruleScene();
        }
    }

    /** 全フレーム共通描画 */
    public void common() {
        background(85, 107, 47);
    }

    /** スタート画面シーン */
    public void startScene() {
        fill(0xFF1F3134);
        textSize(250);
        text("もちばしり", width / 2, height / 2);

        fill(0xFF95859C);
        rect(buttonX, buttonY, (float)buttonW, (float)buttonH, 10);
        fill(0xFFE7E7EB);
        textSize(32);
        String buttonText = "はじまり";
        text(buttonText, buttonX, buttonY);

        fill(0xFF705B67);
        rect(ruleBtnX, ruleBtnY, (float)ruleBtnW, (float)ruleBtnH, 10);
        fill(0xFFE7E7EB);
        textSize(24);
        text("きまりごと", ruleBtnX, ruleBtnY);
    }

    /** ルール画面シーン */
    public void ruleScene() {
        fill(0);
        textSize(40);
        text("きまりごと", width / 2, 150);
        textSize(30);
        text("自分だけの鏡餅を作ろう！\n道に落ちているアイテム", width / 2, height / 2);

        fill(100);
        rect(backBtnX, backBtnY, (float)backBtnW, (float)backBtnH, 10);
        fill(255);
        textSize(24);
        text("戻る", backBtnX, backBtnY);
    }

    /** ゲームメインシーン */
    public void gameScene() {
        stroke(0xFFDCD3B2);
        line(0, 100, 1300, 100);
        line(0, 250, 1000, 250);
        line(0, 400, 1000, 400);
        line(0, 550, 1000, 550);
        line(1000, 0, 1000, 700);

        sanpo.update(sanpo.px, sanpo.py);
        someLine1.update();
        someLine2.update();
        someLine3.update();
        someLine4.update();
        hit1 = obLine1.update();
        hit2 = obLine2.update();
        hit3 = obLine3.update();
        hit4 = obLine4.update();

        judge(hit1, hit2, hit3, hit4);

        String timerString = timer();
        textSize(35);
        text(timerString, 1150, 50);
        if (timeUp) {
            scene = "result";
        }
    }

    /** リザルト画面シーン */
    public void resultScene(player sanpo) {
        fill(0);
        textSize(50);
        text("完走!!!!!!!!!!", width / 2, height / 2 - 200);
        textSize(30);
        fill(50);
        text("[押すとはじめにもどる]", width / 2, height / 2 + 200);

        sanpo.update(75, 640);

        String NameStart = "そなたのかがみもちは...";
        text(NameStart, width / 2 - 200, height / 2 - 100);
        String fullName = "";
        int fullScore = 0;
        if (count == 3 && sanpo.catchThings.get(0) == 2 && sanpo.catchThings.get(1) == 2 && sanpo.catchThings.get(2) == 1) {
            fullName = "かがみもち";
            fullScore = 100000;
        } else {
            fullName += "かがみ";
            for (int i = 0; i < count; i++) {
                int id = sanpo.catchThings.get(i);
                String itemName = "";
                int score = 0;
                switch (id) {
                case 1: itemName = "みかん"; score = 3; break;
                case 2: itemName = "もち"; score = 2; break;
                case 4: itemName = "ベーコン"; score = 4; break;
                case 5: itemName = "たまご"; score = 3; break;
                case 6: itemName = "バーガー"; score = 4; break;
                case 7: itemName = "レタス"; score = 3; break;
                case 8: itemName = "とまと"; score = 3; break;
                case 9: itemName = "オムレツ"; score = 4; break;
                case 10: itemName = "マカロン"; score = 4; break;
                }
                fullName += " " + itemName;
                fullScore += score;
            }
            fullName += " もち";
        }
        textSize(35);
        fill(0xFFE2041B);
        text(fullName, width / 2, height / 2, 1000, 40);
        text("得点：" + fullScore + "点", width / 2, height / 2 + 100);
    }

    /** 新規ゲームリセット */
    public void reset() {
        ending = true;
        someLine1.sx = 0; someLine1.sc = 2;
        someLine2.sx = 0; someLine2.sc = 2;
        someLine3.sx = 0; someLine3.sc = 2;
        someLine4.sx = 0; someLine4.sc = 2;
    }

    public void mousePressed() {
        if (scene.equals("start")) {
            if (abs(mouseX - buttonX) <= 50 && abs(mouseY - buttonY) <= 50) {
                scene = "game"; count = 0; sanpo.catchThings.clear(); reset(); startTime = millis();
            }
            if (abs(mouseX - ruleBtnX) <= 50 && abs(mouseY - ruleBtnY) <= 50) {
                scene = "rule";
            }
        } else if (scene.equals("rule")) {
            if (abs(mouseX - backBtnX) <= 50 && abs(mouseY - backBtnY) <= 50) {
                scene = "start";
            }
        } else if (scene.equals("result")) {
            scene = "start";
        }
    }

    public void keyPressed() {
        if (keyCode == UP) { sanpo.up(); }
        else if (keyCode == DOWN) { sanpo.down(); }
    }

    /** 終了演出 */
    public void ending() {
        someLine1.sx = 0; someLine1.sc = 1; someLine1.sv = 27;
        someLine2.sx = 0; someLine2.sc = 1; someLine2.sv = 27;
        someLine3.sx = 0; someLine3.sc = 1; someLine3.sv = 27;
        someLine4.sx = 0; someLine4.sc = 1; someLine4.sv = 27;
    }

    /** タイマー処理 */
    public String timer() {
        int elapsedTime = millis() - startTime;
        timeUp = (elapsedTime >= gameFinish);
        int totalSeconds = (int)ceil((gameFinish - elapsedTime) / 1000.0f);
        if (totalSeconds < 0) { totalSeconds = 0; }
        int m = totalSeconds / 60;
        float ss = totalSeconds % 60;
        int s = (int)ss;
        if (m == 0 && ss <= 1.2 && ending) {
            ending = false;
            ending();
        }
        return m + ":" + nf(s, 2);
    }

    /** 衝突判定ロジック */
    public void judge(boolean hit1, boolean hit2, boolean hit3, boolean hit4) {
        something currentThing = null;
        if (hit1 || hit2 || hit3 || hit4) {
            hit = true;
            if (hit1) { currentThing = someLine1; }
            else if (hit2) { currentThing = someLine2; }
            else if (hit3) { currentThing = someLine3; }
            else if (hit4) { currentThing = someLine4; }
            sanpo.thingsRegulate(currentThing.sc);
            currentThing.sc = 0;
        } else {
            hit = false;
        }
    }

    /** プレイヤークラス */
    class player {
        float px, py;
        ArrayList<Integer> catchThings;

        player() {
            px = 1150; py = 475;
            catchThings = new ArrayList<Integer>();
        }

        void update(float nowX, float nowY) {
            image(sanpoImg, nowX, nowY + 25);
            float nowHeight = nowY + 25 - (sanpoImg.height / 2) + 10;
            for (int i = 0; i < count; i++) {
                int nowThing = catchThings.get(i);
                int beforeThing = (i != 0) ? catchThings.get(i - 1) : 1;
                switch (nowThing) {
                case 1:
                    nowHeight -= (mikanImg.height / 2);
                    image(mikanImg, nowX, nowHeight);
                    nowHeight -= (mikanImg.height / 2);
                    break;
                case 2:
                    nowHeight -= (mochiImg.height / 2);
                    if (beforeThing == 2) { nowHeight += 15; }
                    image(mochiImg, nowX, nowHeight);
                    nowHeight -= (mochiImg.height / 2);
                    break;
                case 4:
                    nowHeight -= (baconImg.height / 2);
                    image(baconImg, nowX, nowHeight);
                    nowHeight -= (baconImg.height / 2);
                    break;
                case 5:
                    nowHeight -= (eggImg.height / 2);
                    image(eggImg, nowX, nowHeight);
                    nowHeight -= (eggImg.height / 2);
                    break;
                case 6:
                    nowHeight -= (hamburgerImg.height / 2) + 10;
                    image(hamburgerImg, nowX, nowHeight);
                    nowHeight -= (hamburgerImg.height / 2);
                    break;
                case 7:
                    nowHeight -= (lettuceImg.height / 2);
                    image(lettuceImg, nowX, nowHeight);
                    nowHeight -= (lettuceImg.height / 2);
                    break;
                case 8:
                    nowHeight -= (tomatoImg.height / 2);
                    image(tomatoImg, nowX, nowHeight);
                    nowHeight -= (tomatoImg.height / 2);
                    break;
                case 9:
                    nowHeight -= (omuImg.height / 2) + 10;
                    image(omuImg, nowX, nowHeight);
                    nowHeight -= (omuImg.height / 2);
                    break;
                case 10:
                    nowHeight -= (macaronImg.height / 2);
                    image(macaronImg, nowX, nowHeight);
                    nowHeight -= (macaronImg.height / 2);
                    break;
                }
            }
        }

        void up() { py = (py == 175) ? 625 : py - 150; }
        void down() { py = (py == 625) ? 175 : py + 150; }

        void thingsRegulate(int choice) {
            if (choice == 3) {
                if (count != 0) { catchThings.remove(count - 1); count--; }
            } else {
                if (count >= countLmt) { catchThings.remove(count - 1); count--; }
                catchThings.add(count, choice);
                count++;
            }
        }
    }

    /** アイテムクラス */
    class something {
        float sx, sy, sv;
        int sc;

        something(float iny) {
            sx = 100; sy = iny; sv = (float)((int)random(5, 10)); sc = 2;
        }

        void update() {
            sx += sv;
            if (sc == 0) { noFill(); noStroke(); ellipse(sx, sy, 1, 1); }
            else if (sc == 1 || sc == 13 || sc == 14) { sc = 1; image(mikanImg, sx, sy); }
            else if (sc == 2 || sc == 11 || sc == 12) { sc = 2; image(mochiImg, sx, sy); }
            else if (sc == 3 || sc == 15 || sc == 16) { sc = 3; image(kabiMikanImg, sx, sy); }
            else if (sc == 4) { image(baconImg, sx, sy); }
            else if (sc == 5) { image(eggImg, sx, sy); }
            else if (sc == 6) { image(hamburgerImg, sx, sy); }
            else if (sc == 7) { image(lettuceImg, sx, sy); }
            else if (sc == 8) { image(tomatoImg, sx, sy); }
            else if (sc == 9) { image(omuImg, sx, sy); }
            else if (sc == 10) { image(macaronImg, sx, sy); }

            if (sx >= 1000) {
                sx = 0; sv = (float)((int)random(5, 10)); sc = (int)random(17);
            }
        }
    }

    /** 監視クラス */
    class observer {
        player sanpo;
        something some;

        observer(player _p, something _s) { sanpo = _p; some = _s; }

        boolean update() {
            return (sanpo.py == some.sy && some.sc != 0 && dist(sanpo.px, sanpo.py, some.sx, some.sy) <= 250);
        }
    }
}