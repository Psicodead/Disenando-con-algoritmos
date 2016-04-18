public class VirusA extends Elemento{
   
  public VirusA(float x,float y){
    super(x,y);
    setFus(false);
    setImagen( loadImage("virusA.png"));
    setDest(600,300);
  }
  public void pintar(){
  // se sobre escribe el metodo pintar para cargar la imagen del "virus" A
  tint(getRojo(),getVer(),getAzu());
  image(getImagen(),getPosX(),getPosY());
  noTint();
  }
}
