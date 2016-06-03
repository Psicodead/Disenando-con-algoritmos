public class Saltador  extends Monstruo implements Runnable {//clase de monstruos corredores 
  private PImage[] tipoUno, tipoDos, tipoTresIz, tipoTresDer;

  public Saltador(float peso) {//constructor de monstruo que recibe el peso como parametro, el peso determina el tipo de monstruo
    super(peso);
    animacion=0;


    tipoUno = new PImage[29];
    for (int i=0;i<tipoUno.length-1;i++) {
      tipoUno[i] = loadImage("saltador/01/01_"+i+".png");
    }


    tipoDos = new PImage[29];
    for (int i=0;i<tipoDos.length-1;i++) {
      tipoDos[i] = loadImage("saltador/03/03_"+i+".png");
    }


    tipoTresIz = new PImage[29];
    for (int i=0;i<tipoTresIz.length-1;i++) {
      tipoTresIz[i] = loadImage("saltador/05/iz/05_"+i+".png");
    }
    tipoTresDer = new PImage[29];
    for (int i=0;i<tipoTresDer.length-1;i++) {
      tipoTresDer[i] = loadImage("saltador/05/der/05_"+i+".png");
    }
  }
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
  public void pintar() {
    switch(getTipo()) {
    case 0:
      image(tipoUno[animacion], getPosX(), getPosY());
      break;
    case 1:

      image(tipoDos[animacion], getPosX(), getPosY());
      break;
    case 2:
      if (getV()>=0) {
        image(tipoTresDer[animacion], getPosX(), getPosY());
      }
      if (getV()<0) {
        image(tipoTresIz[animacion], getPosX(), getPosY());
      }

      break;
    }
  }

  //metodo abstracto de pintar
  public void mover() {
    if (!getNuevo()) {


      if (getPosY()>430) {
        setAce(getAccX(), -1);
      }
      if (getPosY()<300) {
        setAce(getAccX(), 1);
      }


      if (getPosX()>1090) {
        setAce(-1, getAccY());
      }
      if (getPosX()<100) {
        setAce(1, getAccY());
      }
      setVel();
      setPosicion();
    }
  }
  //metodo abstracto de mover
}

