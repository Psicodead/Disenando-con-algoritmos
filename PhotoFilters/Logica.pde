public class Logica {
  private Minim auxMinim; // permite traer minim desde ejecutar
  private int filtro; // permite cambiar entre los diferentes filtros
  private PImage mascara;
  private Efecto reflejar;
  private Boolean reversa; // me permite saber si el efecto reflejar esta activo o no

  private Filtro filtroUno, filtroDos, filtroTres, filtroCuatro;// filtros a aplicar

  private AudioPlayer sonido; // sonido que se reproduce
  private AudioPlayer delay; // sonido que hace el efecto de delay
  private Capture cam; // mi camara

  public Logica(PApplet app, Minim min) {
    /** inicializo todas las variables y creo los 4 filtros
     tambien paso el minim de ejecutar a mi logica para poder
     utilizarlo.
     */
    reversa=false;
    auxMinim=min;
    sonido= auxMinim.loadFile("sonido.mp3"); // cargo mi cancion.
    delay= auxMinim.loadFile("sonido.mp3"); // cargo mi cancion.
    reflejar= new Efecto();
    filtro=0;
    filtroUno= new Uno();
    filtroDos= new Dos(); 
    filtroTres= new Tres();
    filtroCuatro= new Cuatro();
    ///---CAPTURA D LA CAMARA---///
    String[] cameras = Capture.list();

    if (cameras.length == 0) {
      println("La camara no esta disponible para captura.");
      exit();
    } 
    else {
      println("camara disponible:");
      for (int i = 0; i < cameras.length; i++) {
        println(cameras[i]);
      }
      cam = new Capture(app, cameras[14]);
      cam.start();
      sonido.loop();
    }
    mascara=createImage(width, height, ARGB);
    for (int i=0; i<width*height; i++) {
      mascara.pixels[i]=color(255);
    }
  }
  /////--FINALIZA CAPTURA CAMARA--//////

  public void ejecutar() {

    if (frameCount==5) {// permite que el delay comince 5 frames despues de la cancion.
      delay.loop();
    }
    /**aplica la comparacion mediante switch para saber que filtro
     se esta aplicando, tambien se llama el pintar de los filtros.
     */
    ////---CAPTURAR CAMARA---////
    if (cam.available() == true) {
      cam.read();
    }
    ///--- PINTAR CAMARA ----////
    switch(filtro) {
    case 0:
      filtroUno.pintar(cam);
      delay.unmute();  // quita el mute al delay
      break;
    case 1:
      filtroDos.pintar(cam);
      delay.mute();  // silencia el delay
      break;
    case 2: 
      filtroTres.pintar(cam);
      delay.mute(); // silencia el delay
      break;
    case 3:
      filtroCuatro.pintar(cam);
      delay.mute();  // silencia el delay
      break;
    }
    mascara.loadPixels();
    for (int i=0;i<cam.height; i++) {
      for (int j=0;j<cam.width; j++) {
        if (dist(j, i, mouseX, mouseY)<80) {
          mascara.pixels[i*cam.width+j]=color(0, 0);
        }
      }
    }
    for (int i=0;i<cam.width*cam.height; i++) {
      if (alpha(mascara.pixels[i])>0) {
        mascara.pixels[i]=cam.pixels[i];
      }
    }

    mascara.updatePixels();
    image(mascara, 0, 0);
    modifAudio();
    ////---FINAL PINTAR CAMARA---///
  }
  public void miTeclado(char letra) {
    /**hace de control para mis validaciones que
     involucren al teclado */
    switch(letra) {
    case '1':
      // resetear pixeles//
      if (filtro!=0) { // si se cambia de filtro entonces se resetea
        for (int i=0;i<cam.width*cam.height; i++) {
          mascara.pixels[i]=cam.pixels[i];
        }
      }
      /////////////////////
      filtro=0;     //cambia al primer filtro 
      sonido.setGain(0); 
      sonido.setBalance(0); 
      if (reversa==true) {
        sonido.addEffect(reflejar);
        reversa=false;
      }   
      break;
    case '2':
      // resetear pixeles//
      if (filtro!=1) { // si se cambia de filtro entonces se resetea
        for (int i=0;i<cam.width*cam.height; i++) {
          mascara.pixels[i]=cam.pixels[i];
        }
      }
      /////////////////////
      filtro=1;  //cambia al segundo filtro 
      sonido.setBalance(0); 
      if (reversa==true) {  // si la cancion tiene reversa entonces se la quita
        sonido.addEffect(reflejar);
        reversa=false;
      }
      break;
    case '3':
      // resetear pixeles//
      if (filtro!=2) { // si se cambia de filtro entonces se resetea
        for (int i=0;i<cam.width*cam.height; i++) {
          mascara.pixels[i]=cam.pixels[i];
        }
      }
      /////////////////////
      sonido.setGain(0); 
      filtro=2; //cambia al tercer filtro 
      if (reversa==true) { // si la cancion tiene reversa entonces se la quita
        sonido.addEffect(reflejar);
        reversa=false;
      }
      break;
    case'4':
      // resetear pixeles//
      if (filtro!=3) { // si se cambia de filtro entonces se resetea
        for (int i=0;i<cam.width*cam.height; i++) {
          mascara.pixels[i]=cam.pixels[i];
        }
      }
      /////////////////////
      sonido.setGain(0); 
      sonido.setBalance(0); 
      filtro=3;  //cambia al cuarto filtro 
      reversa=!reversa; // si la cancion tiene reversa entonces se la quita
      sonido.addEffect(reflejar);
      break;
    }
    if (filtro==2) {
      switch(keyCode) {
      case UP:
        ((Tres)filtroTres).graduar(0);
        break;
      case DOWN:
        ((Tres)filtroTres).graduar(1);
        break;
      }
    }
  }
  public void modifAudio() {
    /** realiza las modificaciones de sonido
     dependiendo de que filtro se esta utilizando
     en el momento. Las modificaciones son paneos,
     volumen, reverberación y silenciar */
    switch(filtro) {
    case 0:

      break;
    case 1:
      float val = map(mouseY, 0, height, 3, -48); // setea el volumen (ganancia) del audio dependiendo su posicion en y, a mayor Y menos volumen.
      sonido.setGain(val); 
      ((Dos)filtroDos).graduar(val);
      break;
    case 2:

      float paneo = map(mouseX, 0, width, -1, 1); // setea el volumen (ganancia) del audio dependiendo su posicion en y, a mayor Y menos volumen.
      sonido.setBalance(paneo); 
      break;
    }
  }
}

