#include "WProgram.h"
void setup();
void loop();
int ledBPin = 48; // board LED
///int ledUno=5;
//int ledDos=6;
//int ledTres=7;
//int ledCuatro=8;

//--SENSORES DIGITALES--////
int pulsadorCreador;
int pulsadorEliminador;
int celdaCreador; 
int celdaEliminador;

//---SENSORES ANALOGOS--///
int acelerometro;
int potenciometro; 


void setup() {
  pinMode(ledBPin, OUTPUT); // set ledPin pin as output
  // pinMode(ledUno, OUTPUT); // set ledPin pin as output
  // pinMode(ledDos, OUTPUT); // set ledPin pin as output 
  // pinMode(ledTres, OUTPUT); // set ledPin pin as output
  //  pinMode(ledCuatro, OUTPUT); // set ledPin pin as output

  digitalWrite(ledBPin, HIGH); // set the LED on
  delay(2000); // wait for two seconds
  digitalWrite(ledBPin, LOW); // set the LED off

  Serial.begin(9600); // sets the serial port to 9600

} 

void loop() {

  acelerometro = analogRead(0); 
  potenciometro=analogRead(1);

  celdaCreador= digitalRead(9);
  //celdaEliminador= digitalRead(3);
  celdaEliminador= analogRead(3);
  
  pulsadorCreador = digitalRead(8);
  pulsadorEliminador = digitalRead(9);

  Serial.print(pulsadorCreador, DEC);
  Serial.print(';');
  Serial.print(pulsadorEliminador, DEC);
  Serial.print(';');
  Serial.print(celdaCreador, DEC); // prints the value read
  Serial.print(';'); 
  Serial.print(celdaEliminador, DEC);
  Serial.print(';');
  Serial.print(acelerometro, DEC);
  Serial.print(';');
  Serial.print(potenciometro, DEC); // prints the value read
  Serial.println(';');


  delay(100);
}


