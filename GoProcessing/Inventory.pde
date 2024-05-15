class Inventory {
    Item cabeca;
    PImage fundo, vent, despause, tela;
    public int score, restante, tempoDecorrido, soma, tempoAoPausar;
    int x, y1, y2;
    public int[] quant, q, quant2;
    int[] x2, y3;
    int[] ordenado, auxiliar, posicao, conta;

    Inventory(PImage fundo, PImage vent, int restante, int score, int tempoDecorrido, int soma) {
        this.despause = loadImage("despause.png");
        this.cabeca = null;
        this.fundo = fundo;
        this.vent = vent;
        this.tempoDecorrido = tempoDecorrido;
        this.restante = restante;
        this.score = score;
        this.soma = soma;
        this.y1 = 420;
        this.y2 = 500;
        this.x = 255;
        this.quant = new int[10];
        this.x2 = new int[10];
        this.y3 = new int[10];
        this.q = new int[10];
        for (int i = 0; i < 10; i++) {
            this.q[i] = 0;
        }
        this.quant2 = new int[10];
        for (int i = 0; i < 10; i++) {
            this.quant2[i] = 0;
        }
        this.ordenado = new int[10];
        this.auxiliar = new int[10];
        for (int i = 0; i < 10; i++) {
            this.auxiliar[i] = 0;
        }
        this.posicao = new int[10];
        for (int i = 0; i < 10; i++) {
            this.posicao[i] = i;
        }
        this.conta = new int[10];
        for (int i = 0; i < 10; i++) {
            this.conta[i] = 0;
        }
    }

    void add(int valor) {
        Item novoItem = new Item(valor);
        if (cabeca == null) {
            cabeca = novoItem;
        } else {
            Item aux = cabeca;
            while (aux.proximo != null) {
                aux = aux.proximo;
            }
            aux.proximo = novoItem;
        }
        q[valor - 1]++;
        
    }

    int mostra() {
        // Desenha o fundo e outros elementos gráficos
        image(fundo, 0, 0, 900, 900);
        image(vent, 280, 10, 300, 400);
        textSize(90);
        fill(255);
        stroke(255, 0, 0);
        text("IN", 375, 330);
        text("ORY", 633, 330);

        // Desenha o painel
        fill(0);
        stroke(255);
        for (int i = 0; i < 5; i++) {
            rect(x + (80 * i), y2, 80, 80);
            rect(x + (80 * i), y1, 80, 80);
        }

        // Desenha o tempo decorrido e o score
        fill(255);
        rect(5, 44, 31, 31);
        image(despause, 6, 45, 30, 30);

        textAlign(LEFT);
        textSize(20);
        fill(255, 255, 255);
        rect(5, 10, 105, 30);
        fill(0);
        text("Tempo: " + restante, 10, 30);

        textAlign(RIGHT);
        fill(255, 255, 255);
        rect(width - 105, 10, 100, 30);
        fill(0);
        text("Score: " + score, width - 10, 30);

        tempoAoPausar = millis() - tempoDecorrido + soma;

        
        lista();
        return tempoAoPausar;
    }

    void lista() {
        Item atual = cabeca;
        int posicaoX = x + 2;
        int posicaoY = y1 + 2;
       
        while (atual != null) {
          
            desenha(atual.retornaImg(), posicaoX, posicaoY, atual);
            
            if (quant2[atual.valor - 1] == 1) {
              posicaoX += 80;
              if (posicaoX >= x + 5 * 80) {
                  posicaoX = x + 2;
                  posicaoY = y2 + 2;
              }
            }
            atual = atual.proximo;
        }
    }

    void desenha(PImage imgItem, int x, int y, Item atual) {
        
        quant2[atual.valor - 1]++;
        
        if (quant2[atual.valor - 1] == 1) {
        
          image(imgItem, x, y, 70, 70);
          x2[atual.valor - 1] = x;
          y3[atual.valor - 1] = y;
        } else {
          image(imgItem, x2[atual.valor - 1], y3[atual.valor - 1], 70, 70);
        }
        if (y3[atual.valor - 1] == 502) {
          if (mouseX >= x2[atual.valor - 1] && mouseX <= x2[atual.valor - 1] + 70 && mouseY >= y3[atual.valor - 1]  && mouseY <= 70 + y3[atual.valor - 1]) {
            image(imgItem, 350, 600, 200, 200);
            textSize(50);
            fill(255);
            text(atual.nome, 530, 850);
            fill(0);
            stroke(255);
            rect(x2[atual.valor - 1] - 30, y3[atual.valor - 1] + 85, 150, 60);
            fill(255, 0, 0);
            textSize(20);
            text("VALOR: " + atual.valor, x2[atual.valor - 1] + 57, y3[atual.valor - 1] + 130);
            text("QUANTIDADE: " + q[atual.valor - 1], x2[atual.valor - 1] + 112, y3[atual.valor - 1] + 112);
          }
        } else {
          if (mouseX >= x2[atual.valor - 1] && mouseX <= x2[atual.valor - 1] + 70 && mouseY >= y3[atual.valor - 1]  && mouseY <= 70 + y3[atual.valor - 1]) {
            image(imgItem, 350, 600, 200, 200);
            textSize(50);
            fill(255);
            text(atual.nome, 530, 850);
            fill(0);
            stroke(255);
            rect(x2[atual.valor - 1] - 30, y3[atual.valor - 1] - 70, 150, 60);
            fill(255, 0, 0);
            textSize(20);
            text("VALOR: " + atual.valor, x2[atual.valor - 1] + 57, y3[atual.valor - 1] - 25);
            text("QUANTIDADE: " + q[atual.valor - 1], x2[atual.valor - 1] + 112, y3[atual.valor - 1] - 43);
          }
        }
        
    }
    
    void bubbleSort(){
       int numAtual, posAtual;
       int total = 10;
       int y = 0;
       PImage imgItem, xis;
       
       Item atual = cabeca;
       
       xis = loadImage("xis.png");
       
       //Coloca os valores desordenados no vetor
       while (atual != null) {
         
             if (conta[atual.valor - 1] == 0 && y < 10) {
                auxiliar[y] = q[atual.valor - 1] * (atual.valor);
                posicao[y] = auxiliar[y]/q[atual.valor - 1];
                
                y++;
             }
             conta[atual.valor - 1]++;
             
           
         atual = atual.proximo;
       }
       
       //Ordenação
       for (int i = 0; i < total - 1; i++) {
         for (int j = 0; j < total - i - 1; j++) {
           if (auxiliar[j] < auxiliar[j + 1]) {
             numAtual = auxiliar[j];
             auxiliar[j] = auxiliar[j + 1];
             auxiliar[j + 1] = numAtual;
             posAtual = posicao[j];
             posicao[j] = posicao[j + 1];
             posicao[j + 1] = posAtual;
            
           }
         }
       }
       
       // Mostra a ordenação
       fill(0);
       rect(0, 0, 900, 900);
       
       // Botao de sair
       image(xis, 800, 30, 80, 80);
       
       // Desenha os quadradinhos 
       stroke(255);
       textSize(70);
       int w = 6, s = 1;
       for (int i = 0; i < 5; i++) {
            
            fill(0);
            rect(x + (80 * i), 720, 80, 80);
            rect(x + (80 * i), 800, 80, 80);
            
            fill(255, 0, 0);
            text(s, x + (80 * i) + 20, 785);
            if (w != 10) {
              text(w, x + (80 * i) + 20, 865);
            } else {
              text(w, x + (80 * i) + 5, 865);
            }
            s++;
            w++;
            
            
        }
        
       for (int i = 0 ; i < 10; i ++) {
         
           // Desenha os itens
           fill(255);
           
           if (i < 5 && mouseX > x + (80 * i) && mouseX < x + (80 * i) + 80 && mouseY > 720 && mouseY < 800) {
             textSize(100);
             text((auxiliar[i] == 0) ? "Tenta pegar algo" : Integer.toString(auxiliar[i]), (auxiliar[i] == 0) ? 100:410, 250);
             
             textSize(50);
             
             Item n = (auxiliar[i] == 0)? new Item(30) : new Item(posicao[i]);
               
             imgItem = n.retornaImg();
             image(imgItem, 350, 350, 200, 200);
             fill(255);
             text((auxiliar[i] == 0)? "NADA" : n.nome, 390, 610);
           } else if (i >= 5 && mouseX > x + (80 * (i - 5)) && mouseX < x + (80 * (i - 5)) + 80 && mouseY > 800 && mouseY < 880) {
             textSize(100);
             text((auxiliar[i] == 0) ? "Tenta pegar algo" : Integer.toString(auxiliar[i]), (auxiliar[i] == 0) ? 100:410, 250);
             
             textSize(50);
             Item n = (auxiliar[i] == 0)? new Item(30) : new Item(posicao[i]);
              
             imgItem = n.retornaImg();
             image(imgItem, 350, 350, 200, 200); 
             fill(255);
             text((auxiliar[i] == 0)? "NADA" : n.nome, 390, 610);
             
           }
         
       }    
        
    }
    
}
