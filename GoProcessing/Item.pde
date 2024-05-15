class Item {
    int valor;
    String nome;
    PImage imagem;
    Item proximo;

    Item(int valor) {
        this.valor = valor;
        this.proximo = null;
        
        if (valor == 1) {
            this.imagem = loadImage("folha.png");
            this.nome = "FOLHA";//F
        } else if (valor == 2) {
            this.imagem = loadImage("verde.png");
            this.nome = "ALIEN  "; //F
        } else if (valor == 3) {
            this.imagem = loadImage("gato.png");
            this.nome = "GATO  ";//F
        } else if (valor == 4) {
            this.imagem = loadImage("ovo.png");
            this.nome = "OVO    "; //F
        } else if (valor == 5) {
            this.imagem = loadImage("abobora.png");
            this.nome = "ABÓBORA";
        } else if (valor == 6) {
            this.imagem = loadImage("papel.png");
            this.nome = "PAPEL";//F
        } else if (valor == 7) {
            this.imagem = loadImage("cachorro.png");
            this.nome = "CÃO   ";//F
        } else if (valor == 8) {
            this.imagem = loadImage("robo.png");
            this.nome = "ROBÔ  "; //F
        } else if (valor == 9) {
            this.imagem = loadImage("chapeu.png");
            this.nome = "CHÁPEU";//F
        } else if (valor == 10) {
            this.imagem = loadImage("ET.png");
            this.nome = "OVNI   ";//F
        } else {
            this.imagem = loadImage("bunequinho.png");  
        }
    }

    PImage retornaImg() {
        return imagem;
    }
}
