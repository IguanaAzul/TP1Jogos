import processing.sound.*;
Drop[] drops = new Drop[200];
PImage Nuvem, Chuva, Mar, Barco, Raio;
float xC=0, xN=0, xM=0, vC = -10, vN = -1, vM=-3, yM=450, vyM = -1, xB=0, yB=450, vxB=0, k=0;
SoundFile tomate, rain, thunder;
void setup(){
  size (1280, 720);
  
  tomate = new SoundFile(this, "Tomate.mp3");
  rain = new SoundFile(this, "Rain.mp3");
  thunder = new SoundFile(this, "Thunder.mp3");
  
  //musica.loop();
  rain.loop();
  
  Raio = loadImage("Raio Poofy.png");
  Nuvem = loadImage("Nuvem Poofy.png");
  Chuva = loadImage("Chuva Poofy.png");
  Mar = loadImage("Mar Poofy.png");
  Barco = loadImage("Barco Poofy.png");
  
  background(0, 255, 0);
  
  for (int i = 0; i < drops.length; i++) {
      drops[i] = new Drop();
  }
    
}
void draw(){
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
  }
  if (keyPressed) {
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
