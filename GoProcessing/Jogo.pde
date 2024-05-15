PImage imgGrama, imgArvore, imgJogador, imgItem, imgMenu, imgConfig, imgStart, imgQuit, Girar, imgPause, fundoInventario, vent, telinha, telona, playagain, barraverde, GameOver, emergencia, imgInv;

int adm = 3;
int linhas = 30; 
int colunas = 30;
Cell [][] grid;
Cell [][] grid1;
Cell player;
Inventory inventario;
float moveColdown;

boolean bagui;
float lastCheck, cdr = 2;

float finalfoda;
int tempoInicio = 120000;
int tempoPausado;
int duracaoPartida; // 2 minutos em milissegundos
int tempoAoPausar;
int score = 0;
int tempoDecorrido = 0;
int[] itens = new int[10];
int segundos = 0;

boolean started;
boolean paused, jogoPausado;
int startAnim, telinhaAnim;
boolean settings;
boolean ended;
boolean bubble;
float startbut, startadder;
float girar;

void setup() {
  frameRate(60);
  size(900, 900);
  
  started = false;
  paused = false;
  jogoPausado = false;
  settings = false;
  ended = false;
  bubble = false;
  
  GameOver = loadImage("GameOver.png");
  barraverde = loadImage("barraverde.png");
  playagain = loadImage("playagain.png");
  telona = loadImage("telona.png");
  telinha = loadImage("telinha.png");
  imgMenu = loadImage("Menu.png");
  imgConfig = loadImage("ConfigBut.png");
  imgStart = loadImage("StartBut.png");
  imgQuit = loadImage("QuitBut.png");
  Girar = loadImage("preto.png");
  fundoInventario = loadImage("fundoEstrelado.png");
  vent = loadImage("vent.png");
  emergencia = loadImage("emergencia.png");
  imgInv = loadImage("imgInv.png");
  Girar.resize(300, 300);
  startbut = 200;
  
  inventario = new Inventory(fundoInventario, vent, segundos, score,  tempoDecorrido, tempoAoPausar); 
  
  startAnim = 0;
}


void draw(){
  background(0);
  
  if(ended == true) {
    background(0);
    image(imgQuit, 30, 650, 200, 200);
    image(emergencia, 350, 600, 200, 200);
    image(imgInv, 350, 810, 200, 70);
    image(playagain, 650, 625, 200, 250);
    image(barraverde, 200, 500, 50*10, 50);
    image(GameOver, 150, 50, 600, 250);
    textAlign(LEFT);
    textSize(50);
    fill(120, 250, 40);
    finalfoda += score >= finalfoda? 5 : 0;
    text("Score: " + score, finalfoda+100, 450);
    stroke(0);
    rect(finalfoda+200, 450, 10, 50);
    rect(210, 510, finalfoda, 28);
    if(mousePressed && mouseX >= 30 && mouseX <= 230 && mouseY >= 650 && mouseY <= 850) {
      exit();
    }
    if(mousePressed && mouseX >= 650 && mouseX <= 850 && mouseY >= 625 && mouseY <= 825) {
      started = false;
      paused = false;
      jogoPausado = false;
      settings = false;
      ended = false;
      bubble = false;
  
      
      finalfoda = 0;
      score = 0;
      linhas = 30;
      colunas = 30;
      adm = 3;
      grid1 = new Cell[linhas][colunas];
      grid = new Cell[linhas][colunas];
      inventario = new Inventory(fundoInventario, vent, segundos, score,  tempoDecorrido, tempoAoPausar);   
    }
    
    if(bubble == true){
      inventario.bubbleSort();
    }  
    
  } else {
  if(started == false) {
    desenhaMenu();
    
    //menuAqui
    if(mousePressed && mouseX >= 120 && mouseX <= 425 && mouseY >= 100 && mouseY <= 345) {
      started = true;
      duracaoPartida = tempoInicio + millis();
      startGame();  
    }
    if(settings == true) {
      image(telinha, 85, 0, 950, 1000);
      image(telona, 350, 550, 100, 100);
      image(telona, 500, 550, 100, 100);
      image(telona, 650, 550, 100, 100);
      textAlign(LEFT);
      textSize(80);
      fill(0, 255, 0);
      text("  1 ", 350, 630);
      fill(0, 0, 255);
      text("  2 ", 500, 630);
      fill(255, 0, 0);
      text("  3 ", 650, 630);
      textAlign(LEFT);
      fill(255);
      textSize(40);
      text("Tamanho da grid ->  " + adm, 350, 700);
      stroke(0);
      strokeWeight(15);
      line(350, 530, 750, 530);
      text("Tempo = " + tempoInicio/60000+":"+((tempoInicio%60000 < 10)? "0" + tempoInicio % 60000 : "30"), 350, 430);
      textSize(40);
      image(telona, 350, 450, 100, 50);
      fill(0, 255, 0);
      text("2:00", 365, 490);
      image(telona, 500, 450, 100, 50);
      fill(0, 125, 125);
      text("1:30", 515, 490);
      image(telona, 650, 470, 100, 50);
      fill(0, 0, 255);
      text("1:00", 665, 510);
      image(telona, 650, 400, 100, 50);
      fill(255, 0, 0);
      text("0:30", 665, 440);
      strokeWeight(2);
      
    if(mousePressed && mouseX >= 365 && mouseX <= 465 && mouseY >= 450 && mouseY <= 500) {
      tempoInicio = 120000;
    }
    if(mousePressed && mouseX >= 500 && mouseX <= 600 && mouseY >= 450 && mouseY <= 500) {
      tempoInicio = 90000;
    }
    if(mousePressed && mouseX >= 665 && mouseX <= 765 && mouseY >= 470 && mouseY <= 510) {
      tempoInicio = 60000;
    }
    if(mousePressed && mouseX >= 665 && mouseX <= 765 && mouseY >= 400 && mouseY <= 440) {
      tempoInicio = 22000;
    }
      
    }
    if(mousePressed && mouseX >= 685 && mouseX <= 765 && mouseY >= 75 && mouseY <= 145) {
      exit();
    }
    
  }  else {
    
  moveColdown++;
  
  //desenhaGrids
  desenhaMapa() ;
  
  
  if(jogoPausado == true){//Pâmela
      tempoAoPausar = inventario.mostra();
   }else{//Pâmela
      timescore();
    }
    
  if(startAnim < height) { desenhaMenu(); startAnim += 80;} 
  }
  }
  
}

void mousePressed(){
  if( mouseX >= 100 && mouseX <= 300 && mouseY >= 555 && mouseY <= 730 && settings == false) {
      settings = true;
    } else if( mouseX >= 100 && mouseX <= 300 && mouseY >= 555 && mouseY <= 730 && settings == true){
      settings = false;
    }
    for(int i = 1; i <= 3; i++) {
      if( mouseX >= 200 + 150*i && mouseX <= 300 + 150*i && mouseY >= 550 && mouseY <= 650 && settings == true) {
        adm = i;  
      }
    }
    
  if(mouseX >= 5 && mouseX <= 35 && mouseY >= 45 && mouseY <= 75 && jogoPausado == false){
        jogoPausado = true;
   } else if (mouseX >= 5 && mouseX <= 35 && mouseY >= 45 && mouseY <= 75 && jogoPausado ==  true) {
     jogoPausado = false;  
   }
   if(mouseX >= 350 && mouseX <= 550 && mouseY >= 600 && mouseY <= 800 && bubble == false){
      bubble = true;
   } else if(mouseX >= 800 && mouseX <= 880 && mouseY >= 30 && mouseY <= 110 && bubble == true){//tem q trocar isso
     bubble = false;
   }
}

void keyPressed(){
  movePlayer();
  
}

void desenhaMapa() 
{
  for (int i = 0; i < linhas; i++) {
    for (int j = 0; j < colunas; j++) {
      grid1[i][j].display(false);
    }
  }
  for (int i = 0; i < linhas; i++) {
    for (int j = 0; j < colunas; j++) {
      grid[i][j].display(false);
    }
  }    

  // Variáveis para controlar o tempo
  int a, b;
  int currentTime = millis();

  // Verifica se é hora de exibir um item
  if (segundos % 10 == 0 && bagui == true) {
    a = (int) random(0, linhas);
    b = (int) random(0, linhas);
    
    // Garante que não será uma árvore
    while (grid[b][a].tipoDaCelula.equals("árvore")) {
      a = (int) random(0, linhas);
      b = (int) random(0, linhas);
    }

    // Define o tipo do item e exibe
    grid[b][a].display(true);
    lastCheck = currentTime;
    bagui = false;
  }

  // Verifica o tempo de espera antes de exibir o próximo item
  if (currentTime - lastCheck >= cdr * 1000) {
    bagui = true;
    lastCheck = currentTime;
  }
}

void movePlayer() 
{
  if(moveColdown < 4) {
    return;  
  }
  moveColdown = 0;
  int i = int(player.y / (30*adm));
  int j = int(player.x / (30*adm));
  Cell nextCell = null;
  if (keyCode == UP && i > 0) {
    nextCell = grid[i-1][j];
  } else if (keyCode == DOWN && i < linhas-1) {
    nextCell = grid[i+1][j];
  } else if (keyCode == LEFT && j > 0) {
    nextCell = grid[i][j-1];
  } else if (keyCode == RIGHT && j < colunas-1) {
    nextCell = grid[i][j+1];
  }
  if (nextCell != null && !nextCell.tipoDaCelula.equals("árvore") && !nextCell.tipoDaCelula.equals("grama")) {
    if(nextCell.tipoDaCelula.equals("folha")) {
      itens[0]++;
    } else if(nextCell.tipoDaCelula.equals("verde")) {//Pâmela
      itens[1]++;
    } else if(nextCell.tipoDaCelula.equals("gato")) {//Pâmela
      itens[2]++;
    } else if(nextCell.tipoDaCelula.equals("ovo")) {//Pâmela
      itens[3]++;
    } else if(nextCell.tipoDaCelula.equals("abobora")) {//Pâmela
      itens[4]++;
    } else if(nextCell.tipoDaCelula.equals("papel")) {//Pâmela
      itens[5]++;
    } else if(nextCell.tipoDaCelula.equals("cachorro")) {//Pâmela
      itens[6]++;
    } else if(nextCell.tipoDaCelula.equals("robo")) {//Pâmela
      itens[7]++;
    } else if(nextCell.tipoDaCelula.equals("chapeu")) {//Pâmela
      itens[8]++;
    } else if(nextCell.tipoDaCelula.equals("ET")) {//Pâmela
      itens[9]++;
    } 
    
    for (int l = 0; l < 10; l++) {
        inventario.quant2[l] = 0;
     }
    inventario.add(nextCell.value); //Esse não Pâmela
    score += nextCell.value;//Pâmela
    player.tipoDaCelula = "grama";
    player.img = imgGrama;
    player = nextCell;
    player.tipoDaCelula = "jogador";
    player.img = imgJogador;
  } else if(nextCell!= null &&!nextCell.tipoDaCelula.equals("árvore")) {
    player.tipoDaCelula = "grama";
    player.img = imgGrama;
    player = nextCell;
    player.tipoDaCelula = "jogador";
    player.img = imgJogador;  
  }
}

void desenhaMenu() 
{ 
   
   if((startAnim > 0 )) { startAnim -= 40; } 
   
  if(startbut <= 200) { startadder = 5;} else if(startbut > 300) { startadder = -5;}
    startbut += startadder;
    image(imgMenu, 0, +startAnim, width, height);
    image(imgQuit, 675, 75+startAnim, 100, 100);
    starter();
}

void starter() 
{
  image(imgStart, (width*1/4) - startbut/2,  height/4 -(startbut/2) +(+startAnim), startbut+70, startbut);
  image(imgConfig, 100, 550+startAnim, 200, 200);
    
  if(settings == false) {
  
    pushMatrix();
    translate(500, 500+startAnim);
    girar += 5;
    rotate(girar*PI/100);
    image(Girar, -75, -75, 150, 150);
    translate(50, 50);
    rotate(girar*PI/100);
    image(Girar, 00, 00, 75, 75);
    translate(50, 50);
    rotate(girar*PI/100);
    image(Girar, 00, 00, 75, 75);
    translate(50, 50);
    rotate(girar*PI/100);
    image(Girar, 00, 00, 75, 75);
    popMatrix();    
  }
}

void startGame() 
{
  linhas /= adm;
  colunas /= adm;
  
  preparaSprite();
  gridDeFundo();
  gridDeCima();
  
  player = grid[linhas/2][colunas/2];
  player.tipoDaCelula = "jogador";
  player.img = imgJogador;  
}

void preparaSprite() 
{
  imgGrama = loadImage("graminha.png");
  imgGrama.resize(30*adm, 30*adm);
  imgArvore = loadImage("preto.png");
  imgArvore.resize(30*adm, 30*adm);
  imgJogador = loadImage("bunequinho.png");
  imgJogador.resize(30*adm, 30*adm);
    
}

void gridDeFundo() 
{
  grid1 = new Cell[linhas][colunas];
  for (int i = 0; i < linhas; i++) {
    for (int j = 0; j < colunas; j++) {
      String tipoDaCelula = "grama" ;
      PImage img = tipoDaCelula.equals("grama")? imgGrama : imgArvore;
      grid1[i][j] = new Cell(tipoDaCelula, j * 30 * adm, i * 30 * adm, img, adm, 0);
    }
  }  
}

void gridDeCima() 
{
    grid = new Cell[linhas][colunas];
  for (int i = 0; i < linhas; i++) {
    for (int j = 0; j < colunas; j++) {
      String tipoDaCelula = random(1) < 0.9? "grama" : "árvore";
      PImage img = tipoDaCelula.equals("grama")? imgGrama : imgArvore;
      grid[i][j] = new Cell(tipoDaCelula, j * 30 * adm, i * 30 * adm, img, adm, 1);
    }
  }
}
 
 void timescore()//Pâmela(essa função toda)
 {
  tempoDecorrido = millis();
  int tempoRestante = duracaoPartida + tempoAoPausar - tempoDecorrido;
  segundos = tempoRestante / 1000;
  inventario.restante = segundos;
  inventario.score = score;
  inventario.tempoDecorrido = tempoDecorrido;
  inventario.soma = tempoAoPausar;
  
  imgPause = loadImage("pause.png");
  
  fill(255);
  rect(5, 44, 31, 31);
  image(imgPause, 1.5, 40, 40, 40);
  ;
  textAlign(LEFT);
  textSize(20);
  fill(255, 255, 255);
  rect(5, 10, 105, 30);
  fill(0);
  text("Tempo: " + segundos, 10, 30);
  
  textAlign(RIGHT);
  fill(255, 255, 255);
  rect( width - 105, 10, 100, 30);
  fill(0);
  text("Score: " + score, width - 10, 30);

  // Verificar fim do jogo
  if (tempoRestante <= 0) {
    gameOver();
  }  
  
 }
 
 void gameOver() {
   ended = true;
}
