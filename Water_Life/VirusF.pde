public class VirusF extends Elemento{
  
  public VirusF(float x,float y){
    super(x,y);
    setImagen( loadImage("virusF.png"));
    setFus(false);
setDest(600,300);
  }
  public void pintar(){
    
  // se sobre escribe el metodo pintar para cargar la imagen del "virus" F
  image(getImagen(),getPosX(),getPosY());
  }
}
