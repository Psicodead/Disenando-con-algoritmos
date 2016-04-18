public class Tres extends Elemento{
  
  public Tres(float x,float y){
    super(x,y);
   setImagen (loadImage("Tres.png"));
  }
  public void pintar(){
  // se sobre escribe el metodo pintar para cargar la imagen del "virus" 3
  tint(getRojo(),getVer(),getAzu());
  image(getImagen(),getPosX(),getPosY());
  noTint();
  }
}
