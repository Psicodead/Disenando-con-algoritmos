public abstract class Monstruo {//clase padre monstruo 
  private PVector posicion, velocidad, aceleracion;//vectores que controlan posicion velocidad y aceletación de los monstruos
  private int tipo;
  private boolean nuevo, running;
  protected int animacion;
  private float peso, pesoLimite;//variables flotantes correspondientes a posiciones y peso
  public Monstruo(float peso) {//constructor de monstruo que recibe el peso como parametro, el peso determina el tipo de monstruo
    pesoLimite=peso;
    nuevo=true;

    tipo=(int)random(0, 3);
    posicion=new PVector(random(100, width-100), 40);
    velocidad=new PVector(0, 0);
    aceleracion=new PVector(0, 0);
    running=true;
  }
  public abstract void pintar(); //metodo abstracto de pintar
  public abstract void mover(); //metodo abstracto de mover

    public void caer() {
    aceleracion.set(0, 1);
    velocidad.add(aceleracion);
    velocidad.limit(4);
    posicion.add(velocidad);
  }

  public void pesar() {
    if (!nuevo) {
      if (peso<pesoLimite) {
        peso+=0.1;
      }
    }
  }

  public float getPeso() {
    return peso;
  }
  public float getPosX() {
    return posicion.x;
  }
  public float getPosY() {
    return posicion.y;
  }
  public float getV() {
    return velocidad.x;
  }
  public void setPosX(float nX) {
    posicion.set(nX, posicion.y);
  }
  public void setPeso(float nP) {
    peso=nP;
  }
  public int getTipo() {
    return tipo;
  }
  public boolean getNuevo() {
    return nuevo;
  }
  public boolean getR() {
    return running;
  }

  public void setAce(float x, float y) {
    aceleracion.set(x, y);
  }
  public void setVel() {
    velocidad.add(aceleracion);
    velocidad.limit(4);
  }
  public PVector getP() {
    return posicion;
  }
  public float getAccX() {
    return aceleracion.x;
  }
  public float getAccY() {
    return aceleracion.y;
  }
  public void setPosicion() {
    posicion.add(velocidad);
  }
  public void setNuevo(boolean nN) {
    nuevo=nN;
  }
  public void resetValores() {
    velocidad.set(0, 0);
    aceleracion.set(1, 0);
  }
}

