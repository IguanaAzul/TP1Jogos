import processing.sound.*;
Drop[] drops = new Drop[200];
PImage Nuvem, Chuva, Mar, Barco, Raio;
PImage[] Botoes = new PImage[10];
float xC=0, xN=0, xM=0, vC = -10, vN = -1, vM=-3, yM=450, vyM = -1, xB=0, yB=450, vxB=0, k=0;
int selecao=0, justpressed=0;
boolean JOGAR=false, MENU=true, STARTEDSONG=false;
SoundFile tomate, rain, thunder;
void setup(){
  size (1600, 900);  
  //tomate = new SoundFile(this, "Tomate.mp3");
  rain = new SoundFile(this, "Rain.mp3");
  thunder = new SoundFile(this, "Thunder.mp3");
  
  for (int i = 0; i < Botoes.length; i++) {
      Botoes[i] = new PImage();
  }
  
  for (int i = 0; i < drops.length; i++) {
      drops[i] = new Drop();
  }
  
  Raio = loadImage("Imagens/Raio Poofy.png");
  Nuvem = loadImage("Imagens/Nuvem Poofy.png");
  Chuva = loadImage("Imagens/Chuva Poofy.png");
  Mar = loadImage("Imagens/Mar Poofy.png");
  Barco = loadImage("Imagens/Barco Poofy.png");
  Botoes[0]= loadImage("Imagens/BotaoMenu.png");
  Botoes[1]= loadImage("Imagens/BotaoJogar.png");
  Botoes[2]= loadImage("Imagens/BotaoOpcoes.png");
  Botoes[3]= loadImage("Imagens/BotaoVoltar.png");
  Botoes[4]= loadImage("Imagens/BotaoSair.png");
  Botoes[5]= loadImage("Imagens/BotaoSelecionado.png");

    
}
void keyReleased(){
    if((key == 's' || key == 'S') && selecao<4 && justpressed<20000) selecao++;
    if((key == 'w' || key == 'W') && selecao>0 && justpressed<20000) selecao--;
    if(key==ENTER){
      switch(selecao){
        case 1:
        JOGAR=true; MENU=false;
        break;
        case 3|4:
          exit();
        break;
        default: break;
      }
    }
}
void draw(){
  background(150, 255, 255);
  if(JOGAR){
    if(!STARTEDSONG){
        rain.loop();
        STARTEDSONG=true;
    }
    background(150,150,150);
    image(Chuva, xC, -320);
    image(Mar, xM, yM);
    
    pushMatrix();
      translate(xB, yB);
      image(Barco, 0, 0);
    popMatrix();
    
    pushMatrix();
      translate(width-xB, yB);
      scale(-1,1);
      image(Barco, 0, 0);
    popMatrix();
    
    for (int i = 0; i < drops.length; i++) {
        drops[i].fall();
        drops[i].show();
      }
    if(k>500){image(Raio, random(0, 1280), random(0, 150));}
    image(Nuvem, xN, -290);
    
    xC+=vC; xN+=vN; xM+=vM; yM+=vyM; xB+=vxB; yB-=vyM;
    
    if (keyPressed) {
        if (key == 'D' || key == 'd') {
          if(vxB<1){vxB+=0.1;}
        }
        if (key == 'A' || key == 'a') {
          if(vxB>-1){vxB-=0.1;}
        }
    }
    if(xB>1480){xB-=1580;}
    if(xB<-200){xB+=1280;}
    if(xC<-700 || xC>-10){vC*=-1;}
    if(xN<-760 || xN>-0){vN*=-1;}
    if(xM<-100 || xM>-0){vM*=-1;}
    if(yM<430 || yM>470){vyM*=-1;}
    if(k==500){thunder.play();}
    if(k>520){background(255,255,150);}
    if(k>530){k=0;}
    k++;
  }
  if(MENU){
    pushMatrix();
      translate(64, 32+selecao*128);
      scale(0.5);
      image(Botoes[5], 0, 0);
    popMatrix();
    for(int i=0; i<5; i++){
      pushMatrix();
        translate(64, 32+128*i);
        scale(0.5);
        image(Botoes[i], 0, 0);
      popMatrix();
    }
  }
  
}
