import processing.video.*;
import ddf.minim.*;
import ddf.minim.effects.*;
Logica app;
Minim minim;
void setup() {
  size(1280,720); // ancho y alto de la camara de mi pc
  minim= new Minim(this);
  app= new Logica(this,minim); //pasopor constructor el minim y el PApplet
}
void draw() {
  background(255);
  app.ejecutar();
}
void keyPressed() {
  app.miTeclado(key);
}

