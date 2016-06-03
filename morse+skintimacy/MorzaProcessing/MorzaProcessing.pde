/**
 * comunication based on wiring simple read example
 * Using skintimacy and arduino.
 */


import processing.serial.*;

Serial myPort;  // Create object from Serial class
int val;      // Data received from the serial port
int contPunto; //Counter for dots
int contSpace; //Counter for spaces (lines)
boolean unaVez; 
boolean unSpace;
String morse; // The message in morse code
String traducida; // the message translated from morse
HashMap abecedario; //The dictionary that help us make the translation.

void setup() 
{
  size(200, 200);
  String portName = Serial.list()[0]; // on windows use to be COM4 in array[0]
  myPort = new Serial(this, portName, 57600 );
  unaVez = false;
  morse = "";
  traducida = "";
  asignar();
}

void draw()
{
  background(0);             // Set background to white
  if ( myPort.available() > 0) {  // If data is available,
    val = myPort.read();         // read it and store it in val
  }
  
  escribir();
  rect(50, 50, 10, 10);
  //println(morse);
  fill(255);
  text(traducida, 60,60);
}

void escribir() {
  if (val == 'H') {              // If the serial value is 1
    fill(0);
    contPunto++; //help to find out if it is a dot or a line.
    unaVez = true; //Help to add just one letter per event.
    if (unSpace == true) {
      // if time between each signal is less than 2 seconds add a separator por the letters
      if (contSpace > 60 && contSpace <120) {
        morse += "/";
      }
      //else if it is higher than 2 seconds put a space that is represented by "-" the "/" are for splitting purpose. purpose
      else if (contSpace >= 120) {
        morse += "/-/";
      }
      unSpace = false;
    }
    contSpace = 0;
    //println(contPunto);
  } 
  else {    // If the serial value is not 1,
  contSpace++;
  unSpace=true;
  
    if (unaVez == true) {
      if (contPunto < 20 && contPunto > 0) {
        morse += "punto,";
      }
      else if (contPunto >= 20) {
        morse += "linea,";
      }
      unaVez = false;
    }
    contPunto = 0;

    fill(204);                 // set fill to light gray
  }
 
}

/*DEFINE THE ALPHABET*/
void asignar(){
  abecedario = new HashMap();
  abecedario.put("punto,linea,", new String("A"));
  abecedario.put("linea,punto,punto,punto,", new String("B"));
  abecedario.put("linea,punto,linea,punto,", new String("C"));
  abecedario.put("linea,punto,punto,", new String("D"));
  abecedario.put("punto,", new String("E"));
  abecedario.put("punto,punto,linea,punto,", new String("F"));
  abecedario.put("linea,linea,punto,", new String("G"));
  abecedario.put("punto,punto,punto,punto,", new String("H"));
  abecedario.put("punto,punto,", new String("I"));
  abecedario.put("punto,linea,linea,linea,", new String("J"));
  abecedario.put("linea,punto,linea,", new String("K"));
  abecedario.put("punto,linea,punto,punto,", new String("L"));
  abecedario.put("linea,linea,", new String("M"));
  abecedario.put("linea,punto,", new String("N"));
  abecedario.put("linea,linea,linea,", new String("O"));
  abecedario.put("punto,linea,linea,punto,", new String("P"));
  abecedario.put("linea,linea,punto,linea", new String("Q"));
  abecedario.put("linea,punto,linea", new String("R"));
  abecedario.put("punto,punto,punto,", new String("S"));
  abecedario.put("linea,", new String("T"));
  abecedario.put("punto,punto,linea,", new String("U"));
  abecedario.put("punto,punto,punto,linea,", new String("V"));
  abecedario.put("punto,linea,linea,", new String("W"));
  abecedario.put("linea,punto,punto,linea,", new String("X"));
  abecedario.put("linea,punto,linea,linea,", new String("Y"));
  abecedario.put("linea,linea,punto,punto,", new String("Z"));
  abecedario.put("-", new String(" "));
}

void traducir(){
  println(morse);
  String[] temp = morse.split("/");
  for(int i = 0; i < temp.length; i++){
    traducida += abecedario.get(temp[i]);
 //   println(abecedario.get(temp[0]));
  }
}

void mousePressed(){
  traducir();
 // println(traducida);
}

