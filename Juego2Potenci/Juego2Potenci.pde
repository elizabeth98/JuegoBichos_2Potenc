import processing.serial.*;
import processing.sound.*;
import ddf.minim.*;
Minim cadena;
AudioPlayer efecto;


Serial puerto;

String potenciometros;
int poten1;
int poten2;

float posX1;
float posX2;

float mapeado1;
float mapeado2;

int numEnemigos=3;
PFont font;
int puntaje = 0;
int puntaje2 = 0;
String time = "000";
bichos[] enemigos = new bichos[numEnemigos];
int puntajeMax;
int interval = 3800;
int savedTime;
int tiempoTrans;
int totalTime=30000;
int spawnerTime;
//Tiempo del timer
int s=5200;
int s2=2000;
boolean jugar = true;

//imgenes
PImage enemigo;
PImage arma;
PImage fondo;
PImage inicio;
PImage arma2;
PImage fondoGanador;
PImage relojito;


void setup(){
  
size(1000,1000);

cadena=new Minim(this); efecto=cadena.loadFile("efecto.mp3"); 
puerto = new Serial(this, Serial.list()[0], 9600);

spawnerTime = millis();

font = createFont("Arial", 30);

enemigo = loadImage("araña.png");
arma = loadImage("espatula.png");
arma2 = loadImage("espatula2.png");
fondo= loadImage("fondoMadera.png");
inicio = loadImage("pantallaInicio.png");
fondoGanador = loadImage("fondoGanador.png");
relojito = loadImage("relojito.png");
savedTime =millis();

for (int i=0; i< enemigos.length;i++){
    
  enemigos [i] = new bichos();

}

}

void draw(){
 
 if (keyPressed == true){ 
   
   jugar = false;
    
   
 
 }
  if (jugar==true){
 image(inicio,0,0);
 fill(#000000);
 textSize(50);
 text ("Oprime cualquier tecla para comenzar",30,600);

 text ("Record:"+puntajeMax,400,700);
 
 
 }
 
 else{
  image(fondo,0,0);
  
  
for (int i=0; i< enemigos.length;i++){
  fill (155,50);
  enemigos[i].spawner();
  enemigos [i].vel();
  enemigos [i].colision();
  enemigos [i].puntajes();
  enemigos[i].gameOverD();
  
fill(00000);
textSize(40);
if (0<puerto.available()){
   potenciometros =  puerto.readStringUntil('\n');  
 if(potenciometros!=null){
   
   println(potenciometros);
   String []datosPoten = split(potenciometros,'T');
   
   if(datosPoten.length == 2){
   
   println(datosPoten[0]);
   println(datosPoten[1]);
   poten1=int(trim(datosPoten[0]));
   poten2=int(trim(datosPoten[1]));
     
   }
 }
  mapeado1 = map(poten1,0,1023,0,768);
  mapeado2 = map(poten2,0,1023,0,768);
 
  }
   posX1=mapeado1;
   posX2=mapeado2;
   image(arma,posX1,500);
   image(arma2,posX2,500);
 
 }
 image(relojito,460,7);
   puntajeMax = max(puntaje,puntaje2,puntajeMax); 
   
}

}
class bichos {
float tw = 150;
float th = 160;
float x=random(1000);
float y = random(-1000);

void vel (){
y=y+11;
image(enemigo,x,y,tw,th);
}

void colision(){
  
float distancia1 = dist(posX1,500,x,y);
float distancia2 = dist(posX2,500,x,y);


if(distancia1 <tw){
x=random(1000);
y=random(-400,-500);
puntaje++;
efecto.play();
efecto.rewind();


}
if(distancia2 <tw){
x=random(1000);
y=random(-400,-500);
puntaje2++;
efecto.play();
efecto.rewind();




}
//puntajeMax = max(puntaje,puntaje2,puntajeMax);
}
void puntajes (){

fill (#FF4E00);
textSize(40);
text ("Aplastadas= "+puntaje,50,100);
fill (#0CA93E);
text ("Aplastadas= "+puntaje2,650,100);
}



//void gameOver(){
  //fill(#000000);
  //text(""+tiempoTrans/170+"",450,100);
 //tiempoTrans = millis() - savedTime;
//if (tiempoTrans>totalTime){
  //jugar=true;
//puntaje=0;
//tiempoTrans=0;
//savedTime=millis();


//}
//}

void gameOverD(){
  fill(#FFFFFF);
  stroke(30);
  fill(#000000);
  circle(489,86,110);
  fill(#FFFFFF);
 

text(""+s/170+" s",450,110);

s--;

if (s<=0){
    efecto.pause(); 
     if(puntaje2>puntaje){
       s2--;
        background(fondoGanador);
        fill(#000000);
        textSize(70); 
        text("La espatula roja \n es la ganadora",220,210);
     if(s2<=0){
        jugar=true;
        s=5000;
        }
     
      }
      if(puntaje>puntaje2){
        s2--;
        background(fondoGanador);
        fill(#000000);
        textSize(70);
        text("La espatula verde \n es la ganadora",220,210);
        if(s2<=0){
        jugar=true;
         s=5000;
        }
      }
      
     


}
}
void spawner(){
 if (millis() -spawnerTime >interval){
 time= nf(int(millis()/3800),3);
  spawnerTime= millis();
 for (int i=0; i< enemigos.length;i++){
    
  enemigos [i] = new bichos();

}

 
 }
    }



}
 
