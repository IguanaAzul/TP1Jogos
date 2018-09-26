//Poofy e Bluno, vulgo Isadora Souza e Bruno Bruno
import processing.sound.*;
SoundFile music, rain, thunder;
class Drop {
  float x;
  float y;
  float z;
  float len;
  float yspeed;

  Drop() {
    x  = random(width);
    y  = random(-500, -50);
    z  = random(0, 20);
    len = map(z, 0, 20, 10, 20);
    yspeed  = map(z, 0, 20, 1, 20);
  }

  void fall() {
    y = y + yspeed;
    float grav = map(z, 0, 20, 0, 0.2);
    yspeed = yspeed + grav;

    if (y > height) {
      y = random(-200, -100);
      yspeed = map(z, 0, 20, 4, 10);
    }
  }

  void show() {
    float thick = map(z, 0, 20, 1, 3);
    strokeWeight(thick);
    stroke(50, 50, 100);
    line(x, y, x, y+len);
  }
}
Drop[] drops = new Drop[200];
PImage Nuvem, Chuva, Mar, Barco, Raio;
float xC=0, xN=0, xM=0, vC = -10, vN = -1, vM=-3, yM=450, vyM = -1, xB=0, yB=450, vxB=0, k=0;
void setup(){
  size (1280, 720);
  
  music = new SoundFile(this, "Bla.mp3");
  rain = new SoundFile(this, "Rain.mp3");
  thunder = new SoundFile(this, "Thunder.mp3"); 
  music.loop();
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
  image(Barco, xB, yB);
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