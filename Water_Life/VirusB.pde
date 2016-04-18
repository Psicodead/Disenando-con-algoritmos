public class VirusB extends Elemento{
  
  public VirusB(float x,float y){
    super(x,y);
    setFus(false);
    setImagen( loadImage("virusB.png"));
setDest(600,300);
  }
  public void pintar(){
  // se sobre escribe el metodo pintar para cargar la imagen del "virus" B
  tint(getRojo(),getVer(),getAzu());
  image(getImagen(),getPosX(),getPosY());
  noTint();
  }
}
