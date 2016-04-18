public class VirusC extends Elemento {
 
  public VirusC(float x, float y) {
    super(x, y);
    setFus(false);
     setImagen(  loadImage("virusC.png"));
setDest(600,300);
  }
  public void pintar() {
    // se sobre escribe el metodo pintar para cargar la imagen del "virus" C
    tint(getRojo(),getVer(),getAzu());
    image(getImagen(),getPosX(),getPosY());
    noTint();
    
  }
}

