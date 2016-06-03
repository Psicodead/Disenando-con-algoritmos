public class Volador  extends Monstruo implements Runnable {//clase de monstruos corredores 
  private PImage[] tipoUno, tipoDos;
  public Volador(float peso) {//constructor de monstruo que recibe el peso como parametro, el peso determina el tipo de monstruo
    super(peso);
    animacion=0;
    tipoUno = new PImage[29];
    for (int i=0;i<tipoUno.length-1;i++) {
      tipoUno[i] = loadImage("volador/07/07_"+i+".png");
    }


    tipoDos = new PImage[29];
    for (int i=0;i<tipoDos.length-1;i++) {
      tipoDos[i] = loadImage("volador/08/08_"+i+".png");
    }
  }
  //7 y 8
  public void run() {
    while (getR ()) {
      mover();
      animacion ++ ;
      if (animacion >27) {
        animacion=0;
      }

      try {
        Thread.sleep(20);
      }
      catch(InterruptedException ie) {
        println("fui detenido"+ ie);
      }
    }
  }
  //metodo abstracto de pintar
  public void pintar() {
    switch(getTipo()) {
    case 0:      
      image(tipoUno[animacion], getPosX(), getPosY());
      break;
    case 1:
      image(tipoDos[animacion], getPosX(), getPosY());
      break;
    case 2:
      image(tipoDos[animacion], getPosX(), getPosY());
      break;
    }
  }


  public void mover() {
    if (!getNuevo()) {
      PVector vuelo= new PVector (random (width), random (height));
      PVector dir = PVector.sub(vuelo, getP());
      dir.normalize();
      dir.mult(0.5);
      setAce(dir.x, dir.y);
      setVel();
      setPosicion();
    }
  } //metodo abstracto de mover
}

