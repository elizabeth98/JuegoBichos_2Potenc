int sensorValue;
int sensorValue2; 

int inputPin = A0;
int inputPin2 = A1;       

void setup() 
{
  Serial.begin(9600);  
}

void loop() 
{
 
  sensorValue = analogRead(inputPin);
  sensorValue2 = analogRead(inputPin2);

  //sensorValue = analogRead(inputPin)/4;
  //sensorValue2 = analogRead(inputPin2)/4;
  
  
  //imprimo el dato en consola DEC para poderlo ver yo, Byte para ke lo vea la makina, solo se imprime cuando no se este usando serial.write
 // Serial.println(sensorValue, DEC);
  //Serial.println(sensorValue2, DEC);

  Serial.print(sensorValue);
  Serial.print('T');
  Serial.print(sensorValue2);
  Serial.println();

  //cada 100 me envia el dato  
  delay(100); 
}
