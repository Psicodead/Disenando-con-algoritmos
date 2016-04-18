public class Logica {
  // se debe crear el arraylist
  private ArrayList<Elemento> virus;
  private ArrayList<Elemento> fusionados;
  // crear arreglo para imagenes de fondo
  private PImage[] imagenes;
  private int angulo;
  private int pant; // variable de pantallas
  public Logica() {
    fusionados= new ArrayList<Elemento>();
    virus= new ArrayList<Elemento>();
    pant=0; //pantalla inicial

    ///--ARREGLO IMAGENES--///
    angulo=0;
    imagenes= new PImage[5]; 
    imagenes[0]= loadImage("inicio.png"); // inicio
    imagenes[1]= loadImage("instrucciones.png"); //instrucciones
    imagenes[2]= loadImage("fusiones.png"); // fusiones posibles
    imagenes[3]= loadImage("area.png"); // area
    imagenes[4]= loadImage("fondo.png"); // fondo
    /////////////////////////

    //--AGREGAR LOS ELEMENTOS BASICOS INICIALES--//
    virus.add(new Uno(random(50, 900), random(50, 400)));
    virus.add(new Dos(random(50, 900), random(50, 400)));
    virus.add(new Tres(random(50, 900), random(50, 400)));
    virus.add(new Cuatro(random(50, 900), random(50, 400)));
  }
  public void ejecutar() {
    angulo++;
    background(255);
    ////----FONDO----////
    imageMode(CORNER);
    switch(pant) {
    case 0:
      image(imagenes[0], 0, 0);
      break;
    case 1:
      image(imagenes[1], 0, 0);
      break;
    case 2:
      image(imagenes[2], 0, 0);
      break;
    case 3:
      image(imagenes[3], 0, 0);
      break;
    case 4:    
      // aqui se desarrolla la logica de la aplicacion en si.
      //--FONDO--//
      translate(width/2,height/2);
      rotate(radians(angulo));
      pushMatrix();
      translate(-width/2,-height/2);
      pushMatrix();
      image(imagenes[4], 0, 0);
      for (int i =0; i<virus.size(); i++) {
        //--PINTAR--//
        imageMode(CENTER);
        virus.get(i).pintar();
      }
      popMatrix();
      popMatrix();
      /////////////
      //--VIRUS BASICOS--//
      for (int i =0; i<virus.size(); i++) {
        //--PINTAR--//
        //--MOVER--//
        if (virus.get(i).getEstado()==false) {
          virus.get(i).mover();
        }
        ///--- METODO FUSIONAR --///
        fusionar();
        ////////////
        ///---METODO TENIR--//
        tenir();
        //////
        //--METODO ELIMINAR IGUALES--///
        eliminar();
      }
      break;
    }
  }
  public void coger(float mX, float mY) {
    /** mX y mY representaran mouseX y mouseY que se deberan ingresar al llamar el metodo coger en mousePressed
     se modifica el estado del objeto para pasar a estar sugetado y poder arrastrarlo posteriormente a la sona de fusion o separacion*/
    for (int i=0;i<virus.size();i++) {
      if (dist(virus.get(i).getPosX(), virus.get(i).getPosY(), mX, mY)<60) {
        virus.get(i).setEstado(true);
      }
    }
  }
  public void soltar(float mX, float mY) {
    // mX y mY representaran mouseX y mouseY que se deberan ingresar al llamar el metodo soltar en mouseReleased
    /** aqui se realizaran los ejercicios logicos de modificaran en que area se solto el elemento, llamando al 
     metodo fusionar o separar tambien se llamara al metodo eliminar si los elementos
     son del mismo tipo. Tambien se llamara el metodo tenir que es un indicativo de si se pueden o no fusionar los elementos*/
    //---METODO SEPARAR---///
    //se llama para separar los objetos al ser soltados en la esquina
    separar();
    //////////////////////
    for (int i=0;i<virus.size();i++) {

      virus.get(i).setEstado(false);
      if (dist(virus.get(i).getPosX(), virus.get(i).getPosY(), 0, 700)<350) {
        if (virus.get(i).getFus()==false) {
          virus.get(i).setFus(true);
          virus.get(i).setDest(150, 550);
        }
      }

      else if (dist(virus.get(i).getPosX(), virus.get(i).getPosY(), 0, 700)>350) {
        virus.get(i).setFus(false);
      }
    }
  }
  public void eliminar() {
    //metodo para eliminar los objetos del arraylist que sean soltados en el area de fusion y sean del mismo tipo
    if (virus.size()>0) {
      for (int j=0; j<virus.size();j++) {
        Elemento tempA= (Elemento) virus.get(j);
        for (int k=0; k<virus.size();k++) {
          Elemento tempB= (Elemento) virus.get(k);
          if (j!=k) {
            if (dist(tempA.getPosX(), tempA.getPosY(), 0, 700)<350&&dist(tempB.getPosX(), tempB.getPosY(), 0, 700)<350) {
              if (dist(tempA.getPosX(), tempA.getPosY(), tempB.getPosX(), tempB.getPosY())<40) {
                /*for (int j=virus.size()-1;j>0;j--) {
                 for (int k=virus.size()-1; k>0;k--) {
                 if (tempA.equals(tempA)) {  // el monitor sugirio comparar tempA con tempA pero de este modo eliminaba todos los elementos que no fueran fuisonables.          
                 println("kkk");
                 virus.remove(tempA);
                 virus.remove(tempB);
                 }*/

                // no pude eliminarlos con el .equals por lo que hice una serie de condiciones que compara a todos si son de la misma instancia
                if (tempA instanceof Uno && tempB instanceof Uno) {
                  virus.remove(tempA);
                  virus.remove(tempB);
                }
                if (tempA instanceof Dos && tempB instanceof Dos) {
                  virus.remove(tempA);
                  virus.remove(tempB);
                }
                if (tempA instanceof Tres && tempB instanceof Tres) {
                  virus.remove(tempA);
                  virus.remove(tempB);
                }
                if (tempA instanceof Cuatro && tempB instanceof Cuatro) {
                  virus.remove(tempA);
                  virus.remove(tempB);
                }
                if (tempA instanceof VirusA && tempB instanceof VirusA) {
                  virus.remove(tempA);
                  virus.remove(tempB);
                }
                if (tempA instanceof VirusB && tempB instanceof VirusB) {
                  virus.remove(tempA);
                  virus.remove(tempB);
                }
                if (tempA instanceof VirusC && tempB instanceof VirusC) {
                  virus.remove(tempA);
                  virus.remove(tempB);
                }
                if (tempA instanceof VirusD && tempB instanceof VirusD) {
                  virus.remove(tempA);
                  virus.remove(tempB);
                }
                if (tempA instanceof VirusE && tempB instanceof VirusE) {
                  virus.remove(tempA);
                  virus.remove(tempB);
                }
                if (tempA instanceof VirusF && tempB instanceof VirusF) {
                  virus.remove(tempA);
                  virus.remove(tempB);
                }
              }
            }
          }
        }
      }
    }
  }
  public void arrastrar(float mX, float mY) {
    //metodo para arrastrar los objetos, y refrescar las posiciones meientras es arrastrado por el mouse.
    for (int i =0; i<virus.size(); i++) {
      if (virus.get(i).getEstado()==true) {
        virus.get(i).arrastrar(mX, mY);
      }
    }
  }
  public void fusionar() {
    //agregando un elemento de nivel superior al arraylist y elimina los dos inferiores.
    // al fusionar los elementos tendran unas cordenadas destino seran definidas por un periodo de tiempo para que el elemento salga del area de fusion
    for (int j=0;j<virus.size();j++) {
      Elemento tempA= (Elemento) virus.get(j);
      for (int k=0; k<virus.size();k++) {
        Elemento tempB= (Elemento) virus.get(k);
        if (j!=k) {
          if (dist(tempA.getPosX(), tempA.getPosY(), 0, 700)<350&&dist(tempB.getPosX(), tempB.getPosY(), 0, 700)<350) {
            if (dist(tempA.getPosX(), tempA.getPosY(), tempB.getPosX(), tempB.getPosY())<60) {
              ////// FUSIONES CON BASICO Uno ////
              if (tempA instanceof Uno) {
                if (tempB instanceof Dos) {
                  fusionados.add(tempA);
                  virus.remove(tempA);
                  fusionados.add(tempB);
                  virus.remove(tempB);
                  virus.add(new VirusA(300, 580));
                } 
                if (tempB instanceof Tres) {
                  fusionados.add(tempA);
                  virus.remove(tempA);
                  fusionados.add(tempB);    
                  virus.remove(tempB);
                  virus.add(new VirusB(300, 580));
                } 
                if (tempB instanceof Cuatro) {
                  fusionados.add(tempA);
                  virus.remove(tempA);
                  fusionados.add(tempB);
                  virus.remove(tempB);
                  virus.add(new VirusC(300, 580));
                }
              }
              //////////////////
              //-- FUSIONES VIRUS A y 3--//
              if (tempA instanceof VirusA) {
                if (tempB instanceof Tres) {
                  fusionados.add(tempA);
                  virus.remove(tempA);
                  fusionados.add(tempB);
                  virus.remove(tempB);
                  virus.add(new VirusD(300, 580));
                }
              }
              //////////////////////////
              //-- FUSIONES VIRUS C y 4--//
              if (tempA instanceof VirusC) {
                if (tempB instanceof Cuatro) {
                  fusionados.add(tempA);
                  virus.remove(tempA);
                  fusionados.add(tempB);
                  virus.remove(tempB);
                  virus.add(new VirusE(300, 580));
                }
              }
              //////////////////////////
              //-- FUSIONES VIRUS B y E--//
              if (tempA instanceof VirusB) {
                if (tempB instanceof VirusE) {
                  fusionados.add(tempA);
                  virus.remove(tempA);
                  fusionados.add(tempB);
                  virus.remove(tempB);
                  virus.add(new VirusF(300, 580));
                }
              }
              //////////////////////////
            }
          }
        }
      }
    }
  }

  public void separar() {
    //agregando elementos de niveles inferiores, dependiendo del objeto de nivel superior que es liberado.
    // al separarse los elementos tendran unas cordenadas destino seran definidas por un periodo de tiempo para que el elemento salga del area de separacion
    /*for (int i=virus.size()-1; i>0; i--) { el menitor me sugirio que uno de los problemas podria solucionarse comparando alrevez, no encontre nungun error recorriendolo al derecho
     pero aun asi dejo comentado este for dado el caso que genere un error*/
      for(int i=0;i<virus.size();i++){
      if (dist(virus.get(i).getPosX(), virus.get(i).getPosY(), 1200, 0)<200) {
        if (virus.get(i) instanceof VirusA) {
          virus.remove(i);
          for (int j=fusionados.size()-1; j>0; j--) {
            if (fusionados.get(j) instanceof Dos) {
              fusionados.get(j).setPos(600, 300);
              virus.add(fusionados.get(j));
              fusionados.remove(fusionados.get(j));
              break;
            }
          }
          for (int j=fusionados.size()-1; j>0; j--) {
            if (fusionados.get(j) instanceof Uno) {
              fusionados.get(j).setPos(600, 300);
              virus.add(fusionados.get(j));
              fusionados.remove(fusionados.get(j));
              break;
            }
          }
          break;
        }
        if (virus.get(i) instanceof VirusB) {
          println("entreOtra");
          virus.remove(i);
          for (int j=fusionados.size()-1; j>0; j--) {
            if (fusionados.get(j) instanceof Uno) {
              fusionados.get(j).setPos(600, 300);
              virus.add(fusionados.get(j));
              fusionados.remove(fusionados.get(j));
              break;
            }
          }
          for (int j=fusionados.size()-1; j>0; j--) {
            if (fusionados.get(j) instanceof Tres) {
              fusionados.get(j).setPos(600, 300);
              virus.add(fusionados.get(j));
              fusionados.remove(fusionados.get(j));
              break;
            }
          }
          break;
        }
        if (virus.get(i) instanceof VirusC) { 
          println("entreoootraaaa");
          virus.remove(i);
          for (int j=fusionados.size()-1; j>0; j--) {
            if (fusionados.get(j) instanceof Uno) {
              fusionados.get(j).setPos(600, 300);
              virus.add(fusionados.get(j));
              fusionados.remove(fusionados.get(j));
              break;
            }
          }
          for (int j=fusionados.size()-1; j>0; j--) {
            if (fusionados.get(j) instanceof Cuatro) {
              fusionados.get(j).setPos(600, 300);
              virus.add(fusionados.get(j));
              fusionados.remove(fusionados.get(j));
              break;
            }
          }
          break;
        }
        if (virus.get(i) instanceof VirusD) {  
          println("entreoootraaaa");
          virus.remove(i);
          for (int j=fusionados.size()-1; j>0; j--) {
            if (fusionados.get(j) instanceof VirusA) {
              fusionados.get(j).setPos(600, 300);
              virus.add(fusionados.get(j));
              fusionados.remove(fusionados.get(j));
              break;
            }
          }
          for (int j=fusionados.size()-1; j>0; j--) {
            if (fusionados.get(j) instanceof Tres) {
              fusionados.get(j).setPos(600, 300);
              virus.add(fusionados.get(j));
              fusionados.remove(fusionados.get(j));
              break;
            }
          }
          break;
        }
        if (virus.get(i) instanceof VirusE) { 
          println("entreoootraaaa");
          virus.remove(i);
          for (int j=fusionados.size()-1; j>0; j--) {
            if (fusionados.get(j) instanceof VirusC) {
              fusionados.get(j).setPos(600, 300);
              virus.add(fusionados.get(j));
              fusionados.remove(fusionados.get(j));
              break;
            }
          }
          for (int j=fusionados.size()-1; j>0; j--) {
            if (fusionados.get(j) instanceof Cuatro) {
              fusionados.get(j).setPos(600, 300);
              virus.add(fusionados.get(j));
              fusionados.remove(fusionados.get(j));
              break;
            }
          }
          break;
        }
        if (virus.get(i) instanceof VirusF) { 
          println("entreoootraaaa");
          virus.remove(i);
          for (int j=fusionados.size()-1; j>0; j--) {
            if (fusionados.get(j) instanceof VirusB) {
              fusionados.get(j).setPos(600, 300);
              virus.add(fusionados.get(j));
              fusionados.remove(fusionados.get(j));
              break;
            }
          }
          for (int j=fusionados.size()-1; j>0; j--) {
            if (fusionados.get(j) instanceof VirusE) {
              fusionados.get(j).setPos(600, 300);
              virus.add(fusionados.get(j));
              fusionados.remove(fusionados.get(j));
              break;
            }
          }
          break;
        }
      }
    }
  }

  public void tenir() {
    //// la idea es que tina los elementos dependiendo si son o no fusionables pero no esta funcionando no entiendo por que, si si esta entrando al println aveces si aveces no 
    for (int j=0;j<virus.size();j++) {
      Elemento tempA= (Elemento) virus.get(j);
      for (int k=0; k<virus.size();k++) {
        Elemento tempB= (Elemento) virus.get(k);
        if (j!=k) {
          if (dist(tempA.getPosX(), tempA.getPosY(), 0, 700)<350&&dist(tempB.getPosX(), tempB.getPosY(), 0, 700)<350) {
            if (tempA instanceof Uno) { // tenir las fusiones posibles con 1
              if ((tempB instanceof Dos) ||(tempB instanceof Tres) || (tempB instanceof Cuatro) ) {

                tempA.colorear(0, 255, 0);
                tempB.colorear(0, 255, 0);
              }
              else {
                tempA.colorear(255, 0, 0);
                tempB.colorear(255, 0, 0);
              }
            }
            if (tempA instanceof VirusA) { // tenir fusiones posibles con VirusA
              if (tempB instanceof Tres) {
                tempA.colorear(0, 255, 0);
                tempB.colorear(0, 255, 0);
              }
              else {
                tempA.colorear(255, 0, 0);
                tempB.colorear(255, 0, 0);
              }
            }
            if (tempA instanceof VirusD) {
              tempA.colorear(255, 0, 0);
              tempB.colorear(255, 0, 0);
            }
            if (tempA instanceof VirusF) {
              tempA.colorear(255, 0, 0);
              tempB.colorear(255, 0, 0);
            }
            if (tempA instanceof VirusC) { // tenir fusiones posibles con VirusC
              if (tempB instanceof Cuatro) {
                tempA.colorear(0, 255, 0);
                tempB.colorear(0, 255, 0);
              }
              else {
                tempA.colorear(255, 0, 0);
                tempB.colorear(255, 0, 0);
              }
            }
            if (tempA instanceof VirusB) { // tenir fusiones posibles con VirusB 
              if (tempB instanceof VirusE) {
                tempA.colorear(0, 255, 0);
                tempB.colorear(0, 255, 0);
              }
              else {
                tempA.colorear(255, 0, 0);
                tempB.colorear(255, 0, 0);
              }
            }
          }
          if (dist(tempA.getPosX(), tempA.getPosY(), 0, 700)>400&&dist(tempB.getPosX(), tempB.getPosY(), 0, 700)>400) {
            tempA.colorear(255, 255, 255);
            tempB.colorear(255, 255, 255);
          }
        }
      }
    }
  }
  public void crear(char c) {
    /** agrega elementos basicos al arraylist dependiendo de que tecla se precione, se plantea la posibilidad de que se pueda utilizar solo cada
     cierto periodo de tiempo */
    println(c);
    if (pant>3) {
      switch(c) {
      case '1':
        virus.add(new Uno(random(50, 900), random(50, 400)));
        break;
      case '2' :
        virus.add(new Dos(random(50, 900), random(50, 400)));
        break;
      case '3':    
        virus.add(new Tres(random(50, 900), random(50, 400)));
        break;
      case '4':
        virus.add(new Cuatro(random(50, 900), random(50, 400)));
        break;
      }
    }
  }


  ///-- METODO CAMBIO DE PANTALLA--///
  public void cambPant() {
    if (pant<4) {
      pant++;
    }
  }
}

