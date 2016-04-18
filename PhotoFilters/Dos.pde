public class Dos extends Filtro {
  private int intensida; // permite modificar la intencidad del filtro
  private PImage miCaptura; // esta variable es la que se modificara en vez de los pixeles de la camara, al iniciarlizarla se inicializa con los pixeles de la camara
  public Dos() {
    intensida=5;
    miCaptura= createImage(width, height, RGB);
  }
  public void pintar(Capture camara) {
    /**realiza las modificaciones del filtro
     cargando pixeles y modificandolos y luego
     actualizando los pixeles, todo esto de un
     captruca de video*/
    colorMode(RGB, 255, 255, 255);
    miCaptura.loadPixels();
    camara.loadPixels();
    for (int k=0; k<camara.width*camara.height;k++) {
      miCaptura.pixels[k]=camara.pixels[k];
    }

    for (int y=0; y<miCaptura.height; y++) {
      for (int x=0; x<miCaptura.width; x++) {
        // verde mayor y es mayor a una intensidad el pixel es verde puro
        if ((green(miCaptura.pixels[y*miCaptura.width+x])>red(miCaptura.pixels[y*miCaptura.width+x]))&&(green(miCaptura.pixels[y*miCaptura.width+x])>blue(miCaptura.pixels[y*miCaptura.width+x]))&&green(miCaptura.pixels[y*miCaptura.width+x])>intensida*25) {
          miCaptura.pixels[y*width+x]=color(0, 255, 0);
        }
        //azul mayor y es mayor a una intensidad entonces el pixel es azul puro
        if ((blue(miCaptura.pixels[y*miCaptura.width+x])>red(miCaptura.pixels[y*miCaptura.width+x]))&&(blue(miCaptura.pixels[y*miCaptura.width+x])>green(miCaptura.pixels[y*miCaptura.width+x]))&&blue(miCaptura.pixels[y*miCaptura.width+x])>intensida*25) {
          miCaptura.pixels[y*width+x]=color(0, 0, 255);
        }
        //rojo mayor y es mayor a una intensidad entonces el pixel es rojo puro
        if ((red(miCaptura.pixels[y*miCaptura.width+x])>blue(miCaptura.pixels[y*miCaptura.width+x]))&&(red(miCaptura.pixels[y*miCaptura.width+x])>green(miCaptura.pixels[y*miCaptura.width+x]))&&red(miCaptura.pixels[y*miCaptura.width+x])>intensida*25) {
          miCaptura.pixels[y*miCaptura.width+x]=color(255, 0, 0);
        }
        //pixeles blanco grises entonces son verdes
        if (green(miCaptura.pixels[y*miCaptura.width+x])>190&&red(miCaptura.pixels[y*miCaptura.width+x])>190&&blue(miCaptura.pixels[y*miCaptura.width+x])>190) {
          miCaptura.pixels[y*width+x]=color(0, 255, 0);
        }
        //pixeles negros grises entonces son azules
        if (green(miCaptura.pixels[y*miCaptura.width+x])<20&&red(miCaptura.pixels[y*miCaptura.width+x])<20&&blue(miCaptura.pixels[y*miCaptura.width+x])<20) {
          miCaptura.pixels[y*width+x]=color(0, 0, 255);
        }
      }
    }
    miCaptura.updatePixels();
    image(miCaptura, 0, 0);
  }
  public void graduar(float volumen) {// permite graduar la intencidad de mi filtro
    intensida=(int)map(volumen, 3, -48, 0, 10);
  }
}

