int switchpin = 8;    // switch connected to pin 8

void setup()
{
  pinMode(switchpin, INPUT); // pin 0 as INPUT
  Serial.begin(57600 ); // start serial communication at 57600bps
}

void loop()
{
  int sensorReading = analogRead(0);
 
  int thisPitch = map(sensorReading, 0, 200, 120, 1500);
 // Serial.println(sensorReading);
  if(sensorReading>25){
    Serial.write('H'); // send 1 to Processing
  }
  else{
    Serial.write('L');
  }
  // play the pitch:
  tone(8, thisPitch, 10);
  delay(33); // wait 100ms for next print
}

