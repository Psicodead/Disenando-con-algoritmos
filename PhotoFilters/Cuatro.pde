public class Cuatro extends Filtro {
  private PImage auxiliar; // guada los valores de la camara
  private PImage auxiliarDos; // guarda los pixeles de forma invertida y en negativo
  private PImage finalita; // realiza la resta de los pixeles de auxiliar y finalita, es la que se pinta al final
  public Cuatro() {
    auxiliar= createImage(width, height, RGB); // creo mi imagen
    auxiliarDos= createImage(width, height, RGB);  // creo mi imagen
    finalita= createImage(width, height, RGB);  // creo mi imagen
  }
  public void pintar(Capture camara) {
    /**realiza las modificaciones del filtro
     cargando pixeles y modificandolos y luego
     actualizando los pixeles, todo esto de un
     captruca de video*/
    colorMode(RGB, 255, 255, 255);
    camara.loadPixels();
    camara.loadPixels();
    auxiliar.loadPixels();
    auxiliarDos.loadPixels();
    finalita.loadPixels();
    for (int y=0, yInv=camara.height-1 ; y<camara.height; y++, yInv--) {
      for (int x=0, xInv=camara.width-1; x<camara.width; x++,xInv--) { // me permite invertir completamente los pixeles pintando desde el ultimo hacia el primero
        auxiliar.pixels[y*(camara.width)+x]=color(red(camara.pixels[y*(camara.width)+x]), green(camara.pixels[y*(camara.width)+x]), blue(camara.pixels[y*(camara.width)+x])); // asigno los pixeles de la camara a auxiliar
        auxiliarDos.pixels[yInv*camara.width+xInv]= color(255-red(camara.pixels[y*(camara.width)+x]), 255- green(camara.pixels[y*(camara.width)+x]), 255- blue(camara.pixels[y*(camara.width)+x]));  //modifico los pixeles: invertidos en posicion y en negativo
      }
    }
    for (int y=0 ; y<camara.height; y++) {
      for (int x=0; x<camara.width; x++) {
        //realiza la resta entre auxiliar y auxiliarDos
        finalita.pixels[y*(camara.width)+x]=color(-red(auxiliar.pixels[y*(camara.width)+x])+red(auxiliarDos.pixels[y*(camara.width)+x]), -green(auxiliar.pixels[y*(camara.width)+x])+green(auxiliarDos.pixels[y*(camara.width)+x]), -blue(auxiliar.pixels[y*(camara.width)+x])+ blue(auxiliarDos.pixels[y*(camara.width)+x]));
       // finalita.pixels[y*(camara.width)+x]=color(red(auxiliar.pixels[y*(camara.width)+x])-red(auxiliarDos.pixels[y*(camara.width)+x]), green(auxiliar.pixels[y*(camara.width)+x])-green(auxiliarDos.pixels[y*(camara.width)+x]), blue(auxiliar.pixels[y*(camara.width)+x])- blue(auxiliarDos.pixels[y*(camara.width)+x]));
        // el codigo comentario simplemente invierte el orden de la resta, es decir en vez de A-B, queda B-A, que muestra otro resultado pero no tan llamativo como el elegido
      }
    }
    camara.updatePixels();
    auxiliar.updatePixels();
    auxiliarDos.updatePixels();
    finalita.updatePixels();
    image(finalita, 0, 0); // pinta la imagen final
  }
}

