public class Corredor extends Monstruo implements Runnable {//clase de monstruos corredores 
  private PImage[] tipoUno, tipoDosIz, tipoDosDer, tipoTresIz, tipoTresDer;
  public Corredor(float peso) {//constructor de monstruo que recibe el peso como parametro, el peso determina el tipo de monstruo
    super(peso);
    animacion=0;

    tipoUno = new PImage[29];
    for (int i=0;i<tipoUno.length-1;i++) {
      tipoUno[i] = loadImage("corredor/04/04_"+i+".png");
    }


    tipoDosIz = new PImage[29];
    for (int i=0;i<tipoDosIz.length-1;i++) {
      tipoDosIz[i] = loadImage("corredor/10/iz/10_"+i+".png");
    }
    tipoDosDer = new PImage[29];
    for (int i=0;i<tipoDosDer.length-1;i++) {
      tipoDosDer[i] = loadImage("corredor/10/der/10_"+i+".png");
    }
    tipoTresIz = new PImage[29];
    for (int i=0;i<tipoTresIz.length-1;i++) {
      tipoTresIz[i] = loadImage("corredor/11/iz/11_"+i+".png");
    }
    tipoTresDer = new PImage[29];
    for (int i=0;i<tipoTresDer.length-1;i++) {
      tipoTresDer[i] = loadImage("corredor/11/der/11_"+i+".png");
    }
  }
  
  //4, 10 der, 10 iz, 11 der, 11 iz
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
      if (getV()<=0) {
        image(tipoDosIz[animacion], getPosX(), getPosY());
      }
      if (getV()>0) {
        image(tipoDosDer[animacion], getPosX(), getPosY());
      }
      break;
    case 2:
      if (getV()<=0) {
        image(tipoTresIz[animacion], getPosX(), getPosY());
      }
      if (getV()>0) {
        image(tipoTresDer[animacion], getPosX(), getPosY());
      }

      break;
    }
  } 


  public void mover() {
    //--si no se esta creando (es nuevo) entonces se mueve horizontalmente   ///----NUEVO NUEVNO NUEVNO----////   ///----NUEVO NUEVNO NUEVNO----////
    if (!getNuevo()) {
      if (getPosX()>1090) {
        setAce(-1, 0);
      }
      if (getPosX()<100) {
        setAce(1, 0);
      }
      setVel();
      setPosicion();
    }
  } //metodo abstracto de mover
}

