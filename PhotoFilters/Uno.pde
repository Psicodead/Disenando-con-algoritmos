public class Uno extends Filtro {
  private PImage reflejoUno, reflejoDos; // son las dos nuevas imagenes que creare con opacidad para dar la sensacion de movimiento
  public Uno() {
    reflejoUno=createImage(width, height, ARGB); // creo el reflejo uno
    reflejoDos=createImage(width, height, ARGB); // creo el reflejo dos
  }
  public void pintar(Capture camara) {
    /**realiza las modificaciones del filtro
     cargando pixeles y modificandolos y luego
     actualizando los pixeles, todo esto de un
     captruca de video*/
    colorMode(RGB, 255, 255, 255);
    camara.loadPixels();
    reflejoUno.loadPixels();
    reflejoDos.loadPixels();
    for (int i=0; i<camara.height*camara.width; i++) { // asigno a los dos reflejos los valores de la camara, pero con una opacidad 
      reflejoUno.pixels[i]=color(red(camara.pixels[i]), green(camara.pixels[i]), blue(camara.pixels[i]), 90);
      reflejoDos.pixels[i]=color(red(camara.pixels[i]), green(camara.pixels[i]), blue(camara.pixels[i]), 80);
    }
    camara.updatePixels();
    reflejoUno.updatePixels();
    reflejoDos.updatePixels();

    image(camara, 0, 0);
    image(reflejoUno, -20, 0); // pinto el reflejo uno desfazado
    image(reflejoDos, -40, 0);  // pinto el reflejo dos desfazado
  }
}

