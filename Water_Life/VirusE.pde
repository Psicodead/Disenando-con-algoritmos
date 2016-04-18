public class VirusE extends Elemento{
 
  public VirusE(float x,float y){
    super(x,y);
    setImagen( loadImage("virusE.png"));
    setFus(false);
setDest(600,300);
  }
  public void pintar(){
  // se sobre escribe el metodo pintar para cargar la imagen del "virus" E
   tint(getRojo(),getVer(),getAzu());
  image(getImagen(),getPosX(),getPosY());
  noTint();
  }
}
