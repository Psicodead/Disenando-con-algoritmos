import processing.serial.*;

public class Comunicacion extends Thread {
  private Serial myPort;
  //--SENSORES DIGITALES--////
  private int pulsadorCreador;
  private int pulsadorEliminador;
  private int celdaCreador; 
  private int celdaEliminador;

  //---SENSORES ANALOGOS--///
  private int acelerometro;
  private int potenciometro; 

  private boolean activado;
  private char entero;
  private int sensores[]= new int [6];       // array to read the 4 values


  public Comunicacion (PApplet app) {

    activado = true;

    myPort = new Serial(app, Serial.list()[0], 9600); 
    myPort.bufferUntil(59);
    println(myPort.list());

    start();
  }

  public void run() {
    while (activado) {
      try {
        sleep(10);
        serialEvent();


        if (sensores != null && sensores.length >= 7) {

          pulsadorCreador = sensores [0];
          pulsadorEliminador = sensores [1];
          celdaCreador= sensores[2];
          celdaEliminador = sensores [3];
          acelerometro = sensores [4];
          potenciometro = sensores [5];
        }
      }

      catch(InterruptedException e) {
      }
    }
  }

  public void serialEvent() {

    String myString = myPort.readStringUntil(10);

    // if you got any bytes other than the linefeed:
    if (myString != null) {

      myString = trim(myString);

      sensores = int(split(myString, ';'));
      ////      println(sensors);
    }
  }

  public int getPulsadorCreador() {
    return sensores[0];
  }

  public int getPulsadorEliminador() {
    return sensores[1];
  } 

  public int getCeldaCreador() {
    return sensores[2];
  } 

  public int getCeldaEliminador() {
    return sensores[3];
  } 

  public float getAcelerometro() {
    float mapeado= map(sensores[5], 0, 1023, -90, 90);
    return mapeado;
  } 

  public float getPotenciometro() {
    float mapeado= map(sensores[6], 0, 1023, 30, width-30);
    return mapeado;
  }
}

