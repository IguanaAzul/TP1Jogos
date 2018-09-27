import processing.sound.*;
Drop[] drops = new Drop[200];
PImage Nuvem, Chuva, Mar, Barco, Raio;
PImage[] Botoes = new PImage[10];
float xC=0, vC = -10; 
float xN=0, vN = -1;
float xM=0, vxM=-2, yM=445, vyM=-1; 
float xM1=-50,yM1=405, vyM1=2, vxM1=3;
float xM2=-70, yM2=330, vyM2=-3, vxM2=4;
float xB=0, yB=450, vxB=0;
float k=0;
int selecao=1;
boolean JOGAR=false, MENU=true, STARTEDSONG=false, PAUSE=false;
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
  
  Raio = loadImage("Imagens/Raio.png");
  Nuvem = loadImage("Imagens/Nuvem.png");
  Chuva = loadImage("Imagens/Chuva.png");
  Mar = loadImage("Imagens/Mar.png");
  Barco = loadImage("Imagens/Barco.png");
  Botoes[0]= loadImage("Imagens/BotaoMenu.png");
  Botoes[1]= loadImage("Imagens/BotaoJogar.png");
  Botoes[2]= loadImage("Imagens/BotaoOpcoes.png");
  Botoes[3]= loadImage("Imagens/BotaoSair.png");
  Botoes[4]= loadImage("Imagens/BotaoVoltar.png");
  Botoes[5]= loadImage("Imagens/BotaoSelecionado.png");    
}

void keyReleased(){
    if((key == 's' || key == 'S') && selecao<3) selecao++;
    if((key == 'w' || key == 'W') && selecao>1) selecao--;
    if(key==ENTER){
      switch(selecao){
        case 1:
        JOGAR=true; MENU=false;
        break;
        case 3:
        case 4:
          exit();
        break;
        default: break;
      }
    }
    if(key=='q'){
      if(MENU&&!JOGAR) exit();
      if(JOGAR&&!MENU){MENU=true;}
      if(JOGAR&&MENU){MENU=false;}
    }
    if(key=='p') PAUSE=!PAUSE;
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
    image(Mar, xM2, yM2);
    image(Mar, xM1, yM1);
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
    
    
    if(k>500){image(Raio, random(0, 1280), random(0, 150));}
    image(Nuvem, xN, -290);
    
    if(!PAUSE){xC+=vC; xN+=vN; xM+=vxM; yM+=vyM; xB+=vxB; yB-=vyM; xM1+=vxM1; yM1+=vyM1; xM2+=vxM2; yM2+=vyM2; k++; for(int i=0; i<drops.length; i++)drops[i].fall();}
    for(int i=0; i<drops.length; i++)drops[i].show();
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
      if(xM<-100 || xM>-0){vxM*=-1;}
      if(yM<430 || yM>470){vyM*=-1;}
      if(xM1<-100 || xM1>-0){vxM1*=-1;}
      if(yM1<390 || yM1>430){vyM1*=-1;}
      if(xM2<-100 || xM2>-0){vxM2*=-1;}
      if(yM2<320 || yM2>350){vyM2*=-1;}
      if(k==500){thunder.play();}
      if(k>520){background(255,255,150);}
      if(k>530){k=0;}
  }
  if(MENU){
    if(!JOGAR) {
      pushMatrix();
        image(Chuva, -250, -400);
        image(Mar, 0, 450);
      popMatrix();
      pushMatrix();
        translate(width/2-200, height/2-143);
        scale(2);
        image(Barco, 0, 0);
      popMatrix();
    }
    pushMatrix();
      translate(64, -64);
      scale(0.5);
      image(Botoes[0], 0, 0);
    popMatrix();
    pushMatrix();
      translate(64, 96+selecao*128);
      scale(0.5);
      image(Botoes[5], 0, 0);
    popMatrix();
    for(int i=1; i<4; i++){
      pushMatrix();
        translate(64, 96+128*i);
        scale(0.5);
        image(Botoes[i], 0, 0);
      popMatrix();
    }
  }
  
}
