public class VirusD extends Elemento {

  public VirusD(float x, float y) {
    super(x, y);
    setImagen(  loadImage("virusD.png"));
    setFus(false);
    setDest(600, 300);
  }
  public void pintar() {
    // se sobre escribe el metodo pintar para cargar la imagen del "virus" D
    image(getImagen(), getPosX(), getPosY());
  }
}

