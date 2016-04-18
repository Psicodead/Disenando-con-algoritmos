public class Cuatro extends Elemento{
  public Cuatro(float x,float y){
    super(x,y);
   setImagen( loadImage("Cuatro.png"));
  }
  public void pintar(){
  // se sobre escribe el metodo pintar para cargar la imagen del "virus" 4
    tint(getRojo(),getVer(),getAzu());
   image(getImagen(),getPosX(),getPosY());
   noTint();
  }
}
