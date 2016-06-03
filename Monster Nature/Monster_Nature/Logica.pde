public class Logica {

  private Comunicacion comunicacion;
  private Minim minim;
  private AudioPlayer bgMusic, fxMonster, bgThunder, fxPower, fxBoom, gameOver;
  
  private int cargadorPoder, indiFlecha, explosion;
  private boolean jugador; // variable que identifica a los dos jugadores player1=true player2=false
  private int carga; // variable que define la carga.
  private boolean cargado, exploten; // variable que indica si esta o no cargado el mundo.
  private PImage inicio, inicioB, instrucciones, instruccionesB, fondo, gui, aguja, ico, perdiste, perdisteB;//variables de imagen
  private PImage[] rayo, flecha, boom;
  private float anguloTotal;//valor del angulo total de rotacion resultante de anguloMundo-anguloControl
  private float anguloMundo;//valor de la rotacion del mundo dependiendo de los pesos.
  private float anguloControl;//valor del angulo del mando.
  private float pesoPersonaje;//valor del peso segun la distancia al eje de rotacion
  private int pantalla;//contador de pantallas
  private int tipoMonstruo; //indicador del tipo de monstruo a crear
  private float posXeliminado; //posX del monsturo que se elimino
  private float posYeliminado; //posY del monsturo que se elimino
  private boolean creando; //indicador si se esta o no creando un monstruo
  private LinkedList<Monstruo> monstruos;//lista donde se guardaran los objetos monstuo
  private LinkedList <Thread> misHilos;
  private int anim; //variable indice de la animacion del rayo

  public Logica(PApplet app) {
    comunicacion= new Comunicacion(app);

    minim = new Minim (app);
    bgMusic = minim.loadFile("audio/bgMusic.mp3");
    fxMonster = minim.loadFile("audio/fxMonster.mp3");
    bgThunder = minim.loadFile("audio/bgThunder.mp3");
    fxPower=minim.loadFile("audio/fxPower.wav");
    fxBoom=minim.loadFile("audio/fxBoom.wav");
    gameOver=minim.loadFile("audio/gameOver.mp3");
    boom = new PImage[29];
    rayo = new PImage[28]; 
    flecha = new PImage [11];
    anim=0;
    for (int i=0;i<rayo.length-1;i++) {
      rayo[i] = loadImage("rayo/rayo_"+i+".png");
    }
    for (int i=0;i<flecha.length-1;i++) {
      flecha[i] = loadImage("interfaz/flecha_"+i+".png");
    }
    for (int i=0;i<boom.length-1;i++) {
      boom[i] = loadImage("boom/BOOOOOM_"+i+".png");
    }

    perdiste = loadImage("interfaz/perdiste.png");
    perdisteB = loadImage("interfaz/perdisteB.png");
    fondo = loadImage("interfaz/escenario.png");
    instrucciones = loadImage("interfaz/instrucciones.png");
    instruccionesB = loadImage("interfaz/instruccionesB.png");
    ico = loadImage ("rayo/ico.png");
    gui = loadImage("interfaz/gui.png");
    inicio = loadImage("interfaz/inicio.png");
    inicioB = loadImage("interfaz/inicioB.png");
    aguja = loadImage("interfaz/aguja.png");
    carga =150;
    monstruos = new LinkedList<Monstruo>();
    misHilos = new LinkedList<Thread>();
    imageMode(CENTER);
    indiFlecha =0;
    pantalla =0;
    explosion=0;
  }
  public void ejecutar() {//metodo encargado de pintar el fondo del escenario y ejecutar los movimientos de los personajes

    switch(pantalla) {
      //--INICIO--//
    case 0:
      if (dist(mouseX, mouseY, 600, 500)<50) {
        image (inicioB, width/2, height/2);
        cursor(HAND);
      }
      else {
        image (inicio, width/2, height/2);
        cursor(ARROW);
      }

      break;
      //--INSTRUCCIONES--//
    case 1:
      image (instrucciones, width/2, height/2);
      noCursor();

      break;
      //--INTERFAZ DE JUEGO--//
    case 2:
      bgMusic.play();
      noCursor();
      creacion();
      cargarRayo();
      println(carga);
      println(cargado);
      anguloTotal=0;
      mouseX=width/2;
      break;
    case 3:
      /* JUST FOR DEBUGING 
      println("Mundo: "+anguloMundo);
       println("Control: "+anguloControl);
       println("Total: "+anguloTotal);
      /* 
       if (monstruos.size()!=0) {
       println("qweqw: "+monstruos.get(0).getPeso());
       }
       */


      translate(width/2, height/2);
      pushMatrix();
      rotate(radians(anguloTotal));
      translate(-width/2, -height/2);
      pushMatrix();
      creadorMonstruos(); //---crear monstruo---//
      posicionarMonstruos();//--posicionar monstruo--///
      image(fondo, width/2, height/2);
      if (frameCount%3==0) {
        indiFlecha++;
      }
      if (indiFlecha>9) {
        indiFlecha=0;
      }
      if (exploten) {
        explosion++;
        if (explosion>27) {
          explosion=0;
          exploten = false;
        }
      }
      for (int i=0; i<monstruos.size(); i++) {
        monstruos.get(i).pintar();
        monstruos.get(i).pesar();
        if (monstruos.get(i).getNuevo()) {
          monstruos.get(i).caer();

          image(flecha[indiFlecha], monstruos.get(i).getPosX(), 430);

          if (monstruos.get(i).getPosY()>430) {
            monstruos.get(i).setNuevo(false);
            monstruos.get(i).resetValores();
            misHilos .get(i).start();
            creando=false;
          }
        }
      }
      if (exploten) {
        image(boom[explosion], posXeliminado, posYeliminado);
      }

      calcularPeso();
     
      popMatrix();
      popMatrix();
      //imagen de la interfaz grafica de usuario
      image (gui, 0, -(height/2-gui.height/2));
      tint(200, 0, 0);
      image (aguja, anguloTotal, -(height/2-aguja.height/2));
      noTint();

      if (frameCount%30==0) {
        if (cargadorPoder<30) {
          cargadorPoder++;
        }
      }
      if (cargadorPoder<30) {
        fill(255, 0, 0);

        fxPower.rewind();
        fxPower.pause();
      }
      else {
        fill(0, 255, 0);
        fxPower.play();
      }
      ellipse(-550, -300, 30, 30);
      
      ///--CODIGO PARA PERDER--///
      if (anguloTotal>90||anguloTotal<-90) {
        pantalla=4;
      }

      if (fxBoom.position()>=fxBoom.length()) {
        fxBoom.rewind();
        fxBoom.pause();
      }

      break;
      //--FIN DEL JUEGO--//
    case 4:
      fxMonster.pause();
      bgMusic.pause();
      gameOver.play();

      if (dist(mouseX, mouseY, 600, 550)<70) {
        image (perdisteB, width/2, height/2);
        cursor(HAND);
      }
      else {
        image (perdiste, width/2, height/2);
        cursor(ARROW);
      }
      break;
    }
  }
  public void creadorMonstruos() {//metodo que se encarga de añadir monstruos a la lista que los guarda
    if (comunicacion.getPulsadorCreador()==1) {
      fxMonster.loop();
      if (!creando) {

        tipoMonstruo=(int)random(0, 4);

        switch(tipoMonstruo) {

        case 0:
          Monstruo m1=new Corredor(random(1, 2));
          monstruos.add(m1);  
          misHilos.add(new Thread((Corredor)m1));
          break;
        case 1:
          Monstruo m2=new Saltador(random(2, 3));
          monstruos.add(m2);  
          misHilos.add(new Thread((Saltador)m2));
          break;
        case 2:
          Monstruo m3=new Volador(0);
          monstruos.add(m3);  
          misHilos.add(new Thread((Volador)m3));
          break;
        case 3:
          Monstruo m4=new Especial(random(2, 4));
          monstruos.add(m4);  
          misHilos.add(new Thread((Especial)m4));
          break;
        }

        creando=true;
      }
    }
  }
  public void posicionarMonstruos() {
    if (creando) {

      for (int i=0;i<monstruos.size();i++) {
        if (monstruos.get(i).getNuevo()==true) {
          //          switch(keyCode) {
          //          case LEFT:
          //            monstruos.get(i).setPosX(monstruos.get(i).getPosX()-20);
          //            break;
          //          case RIGHT:
          //            monstruos.get(i).setPosX(monstruos.get(i).getPosX()+20);
          //            break;
          //          }
          monstruos.get(i).setPosX(comunicacion.getPotenciometro());
        }
      }
    }
  }

  public void poderEspecial() {//metodo encargado de remover monstruos aleatoriamente
    if (comunicacion.getPulsadorEliminador()==1) {
      if (cargadorPoder==30) {
        //for (int i = monstruos.size()-1;i>=0;i--) {
        //explosion++;
        cargadorPoder=0;
        fxBoom.play();
        exploten =true;

        int indice = (int)random(0, monstruos.size()-1);
        posXeliminado= monstruos.get(indice).getPosX();
        posYeliminado= monstruos.get(indice).getPosY();
        monstruos.remove(indice);
        misHilos.remove(indice);
        println(monstruos.size());
      }
    }
  }
  
  /*metodo encargado de modificar la inclinación de la pantalla dependiendo del 
  soporte otorgado por acelerometro / mouse y la diferencia entre el torque de los
  monstruos y la inclinacion del acelerometro*/
  public void balance() {
    //------ANGULO DEL MANDO---///
    anguloControl= comunicacion.getAcelerometro();
    
    //----ANGULO DEL MUNDO---///
    anguloMundo= norm(pesoPersonaje, -90, 90);
    
    //---ANGULO TOTAL--////
    anguloTotal=anguloMundo-anguloControl;
  }
  
  /*Metodo para calcular el peso total del mundo, se calcula dependiendo la cantidad total
  de monstruos, cada uno con su peso expecifico multiplicado por la distancia de este hacia
  el centro de la tierra*/
  public void calcularPeso() {
    pesoPersonaje=0;
    for (int i=0; i<monstruos.size();i++) {
      float auxPeso=4*(monstruos.get(i).getPeso())*(monstruos.get(i).getPosX()-(width/2));
      pesoPersonaje+=auxPeso;
    }
  }


  /** metodo que hace que disminuya la carga, y que si llega a la carga total llame la animacion y 
   cambie de pantalla provocando que inicie la aplicacion en si.*/
  public void creacion() {

    if (!cargado) {
      if (carga>125) {
        if (frameCount%10==0) {
          carga-=5;
        }
      }
      if (carga>=500) {
        cargado=true;
      }
    }
    fill(255);
    rect(width/4, height+50, width/2 -carga, 30);
    image (ico, width/2, height/2+60);

    if (cargado) {
      bgThunder.play();
      anim ++;
      println(anim);
      if (anim>26) {
        anim =0;
        pantalla=3;
      }
      image(rayo[anim], width/2, height/2);
    }
  }

  // metodo que sirve para caargar el rayo y dar inicio a la aplicacion
  public void cargarRayo() {
    if (pantalla==2) {
      if (!cargado) {
        if (comunicacion.getCeldaCreador()==1) {
          if (jugador) {
            println("entroUno");
            carga+=8;
            jugador=false;
          }
        }
        if (comunicacion.getCeldaEliminador()==1) {
          if (!jugador) {
            println("entroDos");
            carga+=8;
            jugador=true;
          }
        }
      }
    }
  }

  public void setP(int p) {
    pantalla = p;
  }
  public int getP() {
    return pantalla;
  }
}

