public class Dos extends Elemento{
  
  public Dos(float x,float y){
    super(x,y);
   setImagen (loadImage("Dos.png"));
  }
  public void pintar(){
  // se sobre escribe el metodo pintar para cargar la imagen del "virus" 2
   tint(getRojo(),getVer(),getAzu());
  image(getImagen(),getPosX(),getPosY());
  noTint();
  }
}
