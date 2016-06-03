public class Especial extends Monstruo implements Runnable {//clase de monstruos corredores 
  private PImage[] tipoUno, tipoTres;
  private PImage tipoDos;
  public Especial(float peso) {//constructor de monstruo que recibe el peso como parametro, el peso determina el tipo de monstruo
    super(peso);
    animacion=0;
    tipoDos = loadImage("especial/06/06_0.png");

    tipoUno = new PImage[29];
    for (int i=0;i<tipoUno.length-1;i++) {
      tipoUno[i] = loadImage("especial/02/02_"+i+".png");
    }

    tipoTres = new PImage[29];
    for (int i=0;i<tipoTres.length-1;i++) {
      tipoTres[i] = loadImage("especial/09/09_"+i+".png");
    }
  }
  //02, //06 IMAGEN SOLA // 09
  public void run() {
    while (getR ()) {

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
      image(tipoDos, getPosX(), getPosY());
      break;
    case 2:
      image(tipoTres[animacion], getPosX(), getPosY());
      break;
    }
  }

  public void mover() {
    if (!getNuevo()) {
      //mover
    }
  } //metodo abstracto de mover
}

