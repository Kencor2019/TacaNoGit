class Cell {
  String tipoDaCelula;
  float x, y;
  PImage img;
  int adm;
  int top, value;
  
  Cell (String tipoDaCelula, float x, float y, PImage img, int adm, int top){
    this.tipoDaCelula = tipoDaCelula;
    this.x = x;
    this.y = y;
    this.img = img;
    this.adm = adm;
    this.top = top;
  }
  
  void setTipoDaCelula(String tipoDaCelula, PImage img) {
    this.tipoDaCelula = tipoDaCelula;
    this.img = img;
  }
  
  String display(boolean item){//Pâmela(isso é pra pegar os valores dos itens pra mandar pro score)
      
      if(tipoDaCelula == "grama" && top == 1 && item)  {
        int valor = (int)random(1, 10);
        if(valor <= 10) {
          this.value = valor;
          if(valor == 1){
             tipoDaCelula = "folha";
            this.img = loadImage("folha.png");
          }
          if(valor == 2){
             tipoDaCelula = "verde";
            this.img = loadImage("verde.png");
          }
          if(valor == 3){
             tipoDaCelula = "gato";
            this.img = loadImage("gato.png");
          }
          if(valor == 4){
             tipoDaCelula = "ovo";
            this.img = loadImage("ovo.png");
          }
          if(valor == 5){
             tipoDaCelula = "abobora";
            this.img = loadImage("abobora.png");
          }
          if(valor == 6){
             tipoDaCelula = "papel";
            this.img = loadImage("papel.png");
          }
          if(valor == 7){
             tipoDaCelula = "cachorro";
            this.img = loadImage("cachorro.png");
          }
          if(valor == 8){
             tipoDaCelula = "robo";
            this.img = loadImage("robo.png");
          }
          if(valor == 9){
             tipoDaCelula = "chapeu";
            this.img = loadImage("chapeu.png");
          }
          if(valor == 10){
             tipoDaCelula = "ET";
            this.img = loadImage("ET.png");
          }
        }
      } else if (top == 1 && item) {
          
      }
      
      image(img, x, y, 30*adm, 30*adm);
      return tipoDaCelula;
  }
}
