import processing.sound.*;
Drop[] drops = new Drop[100];
PImage Nuvem, Chuva, Mar, Barco, Raio, Bola;
PImage[] Botoes = new PImage[10];
float xC=0, vC = -10; 
float xN=0, vN = -1;
float xM=0, vxM=-2, yM=445, vyM=-1, vMaxB=3;
float xM1=-50,yM1=405, vyM1=2, vxM1=3;
float xM2=-70, yM2=330, vyM2=-3, vxM2=4;
float xB=10, yB=450, vxB=0;
float xBI=1600, yBI=450,  vxBI=-2;
float k=0, s=0, es=10;
float tempoatual=0, tempoanterior=0;
int selecao=1;
boolean JOGAR=false, MENU=true, PAUSE=false, COLLIDERS=false, VITORIA=false, DERROTA=false, JUST=false;
int shootDelay=100, enemyShootDelay=100;
float xTiro, yTiro, xTiroInimigo, yTiroInimigo;
float forcaTiro=1, forcaTiroInimigo=1;
float vxTiro=12, vyTiro=0, vxTiroInimigo=-12, vyTiroInimigo=0, vyInicialTiro=-12, vyInicialTiroInimigo=-12, vxInicialTiroInimigo=-12, vxInicialTiro=12;
float temp;
boolean startingShoot=true, startingEnemyShoot=true, shooting=false, enemyShooting=false;
float vida, vidaInimigo;
float vidaMax=10, vidaInimigoMax=10;
int coins = 100;
SoundFile tomate, rain, thunder;
void setup(){
  frameRate(60);
  size (1600, 900);
  //tomate = new SoundFile(this, "Tomate.mp3");
  rain = new SoundFile(this, "Rain.mp3");
  thunder = new SoundFile(this, "Thunder.mp3");
  rain.loop();
  
  for (int i = 0; i < Botoes.length; i++) {
      Botoes[i] = new PImage();
  }
  
  for (int i = 0; i < drops.length; i++) {
      drops[i] = new Drop();
  }
  vida=vidaMax; vidaInimigo=vidaInimigoMax;
  Raio = loadImage("Imagens/Raio.png");
  Nuvem = loadImage("Imagens/Nuvem.png");
  Chuva = loadImage("Imagens/Chuva.png");
  Mar = loadImage("Imagens/Mar.png");
  Barco = loadImage("Imagens/Barco.png");
  Bola = loadImage("Imagens/Bola.png");
  Botoes[0]= loadImage("Imagens/BotaoMenu.png");
  Botoes[1]= loadImage("Imagens/BotaoJogar.png");
  Botoes[2]= loadImage("Imagens/BotaoOpcoes.png");
  Botoes[3]= loadImage("Imagens/BotaoSair.png");
  Botoes[4]= loadImage("Imagens/BotaoVoltar.png");
  Botoes[5]= loadImage("Imagens/BotaoSelecionado.png");    
}

void keyReleased(){
  if(MENU){
    if((key == 's' || key == 'S') && selecao<3) selecao++;
    if((key == 'w' || key == 'W') && selecao>1) selecao--;
    if(key==ENTER){
      switch(selecao){
        case 1:
        JOGAR=true; MENU=false; PAUSE=false; selecao=0;
        break;
        case 3:
        case 4:
          exit();
        break;
        default: break;
      }
    }
  }
  if(JOGAR){
    if(key=='p') {PAUSE=!PAUSE; selecao=1;}
    if(key=='c') COLLIDERS=!COLLIDERS;
    if(key=='m') {MENU=true; JOGAR=false; selecao=1;}
  }
  if(PAUSE){
    if((key == 's' || key == 'S') && selecao<6) selecao++;
    if((key == 'w' || key == 'W') && selecao>1) selecao--;
    if(key==ENTER){
      switch(selecao){
        case 1:
          if(coins>=50){
            temp = vida/vidaMax;
            vidaMax+=3;
            vida=temp*vidaMax;
            coins-=50;
          }
        break;
        case 2:
           if(coins>=60){
            shootDelay-=30;
            coins-=60;
           }
        break;
        case 3:
        if(coins>=40){
          vxInicialTiro+=1;
          if(vyInicialTiro>7) vyInicialTiro--;
          coins-=40;
        }
        break;
        case 4:
        if(coins>=35){
          vMaxB++;
          coins-=35;
        }
        break;
        case 5:
        if(coins>=50){
          forcaTiro++;
          coins-=50;
        }
        break;
        case 6:
          PAUSE=false;
        break;
        default: break;
      }
    }
  }
}
void shoot(){
  if(startingShoot){
    xTiro=xB+50;
    yTiro=yB+50;
    vyTiro=vyInicialTiro;
    vxTiro=vxInicialTiro;
    startingShoot=false;
  }
  pushMatrix();
    translate(xTiro, yTiro);
    scale(0.15, 0.15);
    image(Bola, 0, 0);
  popMatrix();
  if(!PAUSE){
    xTiro+=vxTiro;
    yTiro+=vyTiro;
    vyTiro+=0.3;
    if(xTiro>width || yTiro>height){
     shooting=false;
     startingShoot=true;
    }
    
  }
}
void enemyShoot(){
   if(startingEnemyShoot){
    xTiroInimigo=xBI-75;
    yTiroInimigo=yBI+50;
    vyTiroInimigo=vyInicialTiroInimigo;
    vxTiroInimigo=vxInicialTiroInimigo;
    startingEnemyShoot=false;
  }
  pushMatrix();
    translate(xTiroInimigo, yTiroInimigo);
    scale(0.15, 0.15);
    image(Bola, 0, 0);
  popMatrix();
  if(!PAUSE){
    xTiroInimigo+=vxTiroInimigo;
    yTiroInimigo+=vyTiroInimigo;
    vyTiroInimigo+=0.3;
    if(xTiroInimigo>width || yTiroInimigo>height){
     enemyShooting=false;
     startingEnemyShoot=true;
    }
    
  }
}
void colisoes(){
  if(shooting) if(xTiro+40>xBI-180 && xTiro<xBI && yTiro+40>yBI+75 && yTiro<yBI+130) {vidaInimigo-=forcaTiro; shooting=false; startingShoot=true;}
  if(enemyShooting) if(xTiroInimigo+40>xB && xTiroInimigo<xB+180 && yTiroInimigo+40>yB+75 && yTiroInimigo<yB+130) {vida-=forcaTiroInimigo; enemyShooting=false; startingEnemyShoot=true;}
  if(vidaInimigo<=0) {VITORIA=true; JUST=true;}
  if(vida<=0) {DERROTA=true; JUST=true;}
  //if(xTiro+40>xB && xTiro<xB+180 && yTiro+40>yB+75 && yTiro<yB+130) {vida--; shooting=false; startingShoot=true;}
  //if(xTiroInimigo+40>xBI-180 && xTiroInimigo<xBI && yTiroInimigo+40>yBI+75 && yTiroInimigo<yBI+130) {vidaInimigo--; enemyShooting=false; startingEnemyShoot=true;}
  
  if(shooting && enemyShooting) if(xTiro+40>xTiroInimigo && xTiro<xTiroInimigo+40 && yTiro+40>yTiroInimigo && yTiro<yTiroInimigo+40) {vxTiro*=-1; vxTiroInimigo*=-1; temp=xTiroInimigo; xTiroInimigo=xTiro; xTiro=temp; temp=yTiro; yTiro=yTiroInimigo; yTiroInimigo=temp; temp=vxTiro; vxTiro=vxTiroInimigo; vxTiroInimigo=temp; temp=vyTiro; vyTiro=vyTiroInimigo; vyTiroInimigo=temp;}
}
void posiciona(){
    //tempoatual=millis();
    
    if(!PAUSE){
      xC+=vC; xN+=vN; xM+=vxM; yM+=vyM; if(((xB>=0 && vxB<0) || (xB+180<=width && vxB>0))) xB+=vxB; if(xB<=0 || xB>=width) vxB=0; yB-=vyM; xM1+=vxM1; yM1+=vyM1; xM2+=vxM2; yM2+=vyM2; xBI+=vxBI; yBI-=vyM; k++; s++; es++; 
      for(int i=0; i<drops.length; i++)drops[i].fall();
      if (keyPressed) {
          if (key == 'D' || key == 'd') {
            if(vxB<vMaxB){vxB+=0.3;}
          }
          if (key == 'A' || key == 'a') {
            if(vxB>-vMaxB){vxB-=0.3;}
          }
      }

      if(xC<-700 || xC>-10){vC*=-1;}
      if(xN<-400 || xN>0){vN*=-1;}
      if(xM<-100 || xM>-0){vxM*=-1;}
      if(yM<430 || yM>470){vyM*=-1;}
      if(xM1<-100 || xM1>-0){vxM1*=-1;}
      if(yM1<390 || yM1>430){vyM1*=-1;}
      if(xM2<-100 || xM2>-0){vxM2*=-1;}
      if(yM2<320 || yM2>350){vyM2*=-1;}
      if(k==500){thunder.play();}
      if(k>520){background(255,255,150);}
      if(k>530){k=0;}
      if(s>shootDelay) {shooting=true; s=0;}
      if(es>enemyShootDelay) {enemyShooting=true; es=0; if(vxBI>0) vxBI*=-1.01; else vxBI*=-1;}
    }
    //tempoanterior=millis();
}

void desenha(){
  background(150, 255, 255);
  if(VITORIA){
    JOGAR=false;
    background(100, 250, 100);
    textSize(30);
    fill(255, 0, 0);
    text("Você Venceu!!!!!\nPressione enter para ir para a próxima fase.", width/2-250, height/2);
    if(JUST){
      coins+=100;
      vxInicialTiroInimigo-=0.5;
      if(vyInicialTiroInimigo>8) vyInicialTiroInimigo+=0.5;
      xB=10; vxB=0;
      vida=vidaMax;
      JUST=false;
      vidaInimigoMax+=1;
      vidaInimigo=vidaInimigoMax;
      shooting=false; startingShoot=true;
      forcaTiroInimigo++;
      enemyShooting=false; startingEnemyShoot=true;
    }
    if(keyPressed){if(key==ENTER) {VITORIA=false; JOGAR=true;}}
  }
  if(DERROTA){
    JOGAR=false;
    coins=0;
    background(250, 100, 100);
    textSize(30);
    fill(100, 0, 255);
    text("Você PERDEU!!!!! HAHAHAHHAHA\nPressione enter para FECHAR O JOGO.\nnoob", width/2-250, height/2);
    if(keyPressed){if(key==ENTER) {exit();}}
  }
  if(JOGAR){
    background(150,150,150);
    image(Chuva, xC, -320);
    //image(Mar, xM2, yM2);
    //tint(255, 200);
    //image(Mar, xM1, yM1);
    //tint(255, 175);
    image(Mar, xM, yM);
    tint(255, 255);
    if(shooting) shoot();
    if(enemyShooting) enemyShoot();
    colisoes();
    pushMatrix();
      translate(xB, yB);
      image(Barco, 0, 0);
    popMatrix();
    
    pushMatrix();
      translate(xBI, yBI);
      scale(-1,1);
      image(Barco, 0, 0);
    popMatrix();
    for(int i=0; i<drops.length; i++)drops[i].show();
    if(k>500){image(Raio, random(0, 1280), random(0, 150));}
    image(Nuvem, xN, -290);
    
    fill(0, 0, 0);
    rect(xB, yB-10, 190, 10);
    rect(xBI-190, yBI-10, 190, 10);
    fill(255-255*(vida/vidaMax), 0+255*(vida/vidaMax), 50);
    rect(xB, yB-10, 190*vida/vidaMax, 10);
    
    fill(255-255*(vidaInimigo/vidaInimigoMax), 0+255*(vidaInimigo/vidaInimigoMax), 50);
    rect(xBI-190, yBI-10, 190*vidaInimigo/vidaInimigoMax, 10);
    String s = "Pressione A e D para mover-se\nPara voltar ao menu pressione M\nPara pausar e ver opções de upgrade pressione P\nCoins " + coins;
    fill(50, 250, 30);  
    textSize(17);
    text(s, 1, 1, 1000, 1000);
    if(COLLIDERS){
      stroke(0,0,255);
      ellipse(xB, yB+130, 5, 5);
      ellipse(xB, yB+75, 5, 5);
      ellipse(xB+180, yB+130, 5, 5);
      ellipse(xB+180, yB+75, 5, 5);
      
      stroke(255,0,0);
      ellipse(xBI, yBI+130, 5, 5);
      ellipse(xBI, yBI+75, 5, 5);
      ellipse(xBI-180, yBI+130, 5, 5);
      ellipse(xBI-180, yBI+75, 5, 5);
    }
  }
  if(PAUSE){
    String s1 = "Aumentar vida máxima: 50 moedas";
    String s2 = "Aumentar frequencia de tiros: 60 moedas";
    String s3 = "Aumentar velocidade do tiro: 40 moedas";
    String s4 = "Aumentar velocidade do barco: 35 moedas";
    String s5 = "Aumentar força do tiro: 50 moedas";
    String s6 = "Voltar para o jogo";
    fill(250, 250, 30);
    textSize(17);
    if(selecao==1) fill(255);
    text(s1, width/2-200, 140, 1000, 1000);
    fill(250, 250, 30);
    if(selecao==2) fill(255);
    text(s2, width/2-200, 190, 1000, 1000);
    fill(250, 250, 30);
    if(selecao==3) fill(255);
    text(s3, width/2-200, 240, 1000, 1000);
    fill(250, 250, 30);
    if(selecao==4) fill(255);
    text(s4, width/2-200, 290, 1000, 1000);
    fill(250, 250, 30);
    if(selecao==5) fill(255);
    text(s5, width/2-200, 340, 1000, 1000);
    fill(250, 250, 30);
    if(selecao==6) fill(255);
    text(s6, width/2-200, 390, 1000, 1000);
    fill(250, 250, 30);
  }
  if(MENU){
      pushMatrix();
        image(Chuva, -250, -400);
        image(Mar, 0, 450);
      popMatrix();
      pushMatrix();
        translate(width/2-200, height/2-143);
        scale(2);
        image(Barco, 0, 0);
      popMatrix();
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
void draw(){
    desenha();
    posiciona();  
}
