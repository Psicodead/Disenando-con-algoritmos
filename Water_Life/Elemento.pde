public abstract class Elemento {
  private PVector posicion; //coordenadas x,y del elemento
  private PVector vel; // velocidades x,y del elemento
  private PVector acce; // aceleracion x y del elemento
  private boolean estado; // booleano que indica si el objeto esta siendo sostenido por el click o se solto
  private PVector destino; // punto al que se dirigira el virus
  private PImage imagen;
  private int rojo;
  private int verde;
  private int azul;
  private boolean fusionando;// esta o no dentro del area de fusion

  public Elemento(float x, float y) {
    imagen= loadImage("Uno.png");
    fusionando=false;
    posicion= new PVector( x, y); //inicializo el vector
    vel= new PVector(0, 0); 
    estado=false;
    destino= new PVector(random(50, 900), random(50, 350)); // pendiente
    rojo= 255;
    verde=255;
    azul=255;
  }

  public abstract void pintar(); // metodo abstracto que hara que el objeto se pinte 


  public void arrastrar(float x, float y) {
    posicion.x= x;
    posicion.y= y;
  }

  public void mover() {
    /*el objeto se movera dirigiendose a destinos randomicos dentro del area de la pantalla, es por
     esto que se decidio utilizar PVector, para que el movimiento sea mas fluido.
     **/
    float selector= random(-3, 3); // me permite darle cordenadas al destino que no esten dentro de las areas sensibles.

    if (frameCount%50==0) {
      if (fusionando==false) {
        if (selector>0) {
          destino= new PVector(random(50, 900), random(50, 350)); //destino esquina superior izquierda
        }
        else {
          destino= new PVector(random(350, 1150), random(250, 650)); //destino esquina inferior derecha
        }
      }
    }
    PVector dir = PVector.sub(destino, posicion);
    // normalizar mi direccion
    dir.normalize();
    // escalar mi direccion
    dir.mult(0.2);
    //setear mi aceleracion
    acce = dir;
    //vel se actualiza por acceleracion y mi location por vel
    vel.add(acce);
    vel.limit(4); // limite de mi velocidad
    posicion.add(vel); // setea mi poscicion,
  }

  public void colorear(int r, int g, int a) {
    // cambia color rojo o verde, resive solo rojo y verde
    rojo=r;
    verde=g;
    azul=a;
  }

  public float getPosX() { // muestra cordenada x del vector posicion
    return posicion.x;
  }
  public float getPosY() { // muestra cordenada y del vector posicion
    return posicion.y;
  }
  public boolean getEstado() {
    return estado;
  }
  public void setEstado(boolean nC) {
    estado= nC;
  }
  public void setDest(float x, float y) {
    destino.x=x;
    destino.y=y;
  }
  public PImage getImagen() {
    return imagen;
  }
  public void setImagen(PImage nI) {
    imagen=nI;
  }
  public void setFus(boolean nFus) {
    fusionando=nFus;
  }
  public boolean getFus() {
    return fusionando;
  }
  public void setPos(float x, float y) {
    posicion.x= x;
    posicion.y= y;
  }
  public int getRojo(){
  return rojo;
  }
  public int getVer(){
    return verde;
  }
    public int getAzu(){
    return azul;
  }
}

