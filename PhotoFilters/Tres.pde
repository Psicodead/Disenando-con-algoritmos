public class Tres extends Filtro {
  private PImage miCaptura; // esta variable es la que se modificara en vez de los pixeles de la camara, al iniciarlizarla se inicializa con los pixeles de la camara
  private int intensida; // permite modificar la intencidad del filtro
  public Tres() {
    intensida=0;
    miCaptura= createImage(width, height, HSB);
  }
  public void pintar(Capture camara) {
    /**realiza las modificaciones del filtro
     cargando pixeles y modificandolos y luego
     actualizando los pixeles, todo esto de un
     captruca de video*/
    // miCaptura= camara;
    colorMode(HSB, 360, 100, 100);
    miCaptura.loadPixels();
    camara.loadPixels();
    for (int k=0; k<camara.width*camara.height;k++) {
      miCaptura.pixels[k]=camara.pixels[k];
    }
    for (int y=0; y<miCaptura.height; y++) {
      for (int x=0, xInv= miCaptura.width-1; x<miCaptura.width/2; x++, xInv--) { // pinta la mitad del lienzo de una imagen y la otra con el reflejo
        if (brightness(miCaptura.pixels[y*(miCaptura.width)+x])>100-intensida) { // si el brillo es mayor a un limete superior entonces es 90
          miCaptura.pixels[y*(miCaptura.width)+x]=color(hue(miCaptura.pixels[y*(miCaptura.width)+x]), 0, 90);
        }
        if (brightness(miCaptura.pixels[y*(miCaptura.width)+x])<0+intensida) { // si el brillo es menor a un limete inferior entonces es 10
          miCaptura.pixels[y*(miCaptura.width)+x]=color(hue(miCaptura.pixels[y*(miCaptura.width)+x]), 0, 10);
        }
        miCaptura.pixels[y*miCaptura.width+xInv]=  miCaptura.pixels[y*(miCaptura.width)+x]; // los pixeles de mi reflejo son igualas a los de la camara comenzando con el x opuesto
      }
    }
    miCaptura.updatePixels();
    image(miCaptura, 0, 0);
  }
  public void graduar(int direccion) {
    // gradua la intencidad del filtro que se esta realizando
    // si se presiona la flecha arriba aumenta la intensidad (direccion=0), si se preciona abajo la intensidad disminuye(direccio=1)
    switch(direccion) {
    case 0:
      if (intensida<85) { // si la intencidad es menor al valor maximo antes de volver la pantalla negra (85) aumenta en 5 unidades
        intensida+=5;
      }
      break;
    case 1:
      if (intensida>0) { // si la intencidad es mayor a cero disminuye 5 unidades
        intensida-=5;
      }
      break;
    }
  }
}

