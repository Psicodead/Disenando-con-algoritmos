/*Bolaños Jose - Juan Camilo Ramon
 Proyecto final */
 
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
//import ddf.minim.ugens.*;
import ddf.minim.effects.*;
//import processing.serial.*;

import java.util.*;
Logica app;//declaración de app  como Instancia de la clase Logica
void setup() {
  size (1200, 675);
  app = new Logica(this);//inicializacion de la instancia app de clase logica
}
void draw() {
  background(0);
  app.ejecutar();//llamado del metodo ejecutar de la clase logica
  app.balance();//llamado del metodo balance de la clase logica
}
void keyPressed() {
 // app.cargarRayo();
  switch (key) {
  case ' ':
    app.creadorMonstruos();//llamado del metodo creadorMonstruos de la clase logica
    break;
  }
  app.posicionarMonstruos();//metodo para modificar la posicion en X de los personajes mientras caen.
}
void mousePressed() {
  switch (app.getP()) {
  case 0:
    if (dist(mouseX, mouseY, 600, 500)<50) {
      app.setP(1);
    }
    break;
  case 1:
    
      app.setP(2);
    
    break;
  case 3:
    app.poderEspecial();//llamado del metodo poderEspecial de la clase logica
    break;
  case 4:
    if (dist(mouseX, mouseY, 600, 550)<70) {
      exit();
    }
    break;
  }
}

