int FSR1 = A0; //the FSR is connected to analog pin 0 (A0)
int FSR2 = A1;
int FSR3 = A2;
int FSR4 = A3;
int FSR5 = A4;

void setup() {
  Serial.begin(9600);
}

void loop() {
  int FSRValue1 = analogRead(FSR1);//this takes a reading of the analog value of the FSR
  int FSRValue2 = analogRead(FSR2);
  int FSRValue3 = analogRead(FSR3);
  int FSRValue4 = analogRead(FSR4);
  int FSRValue5 = analogRead(FSR5);

  float a[] = {FSRValue1, FSRValue2, FSRValue3, FSRValue4, FSRValue5};

  //Serial.println(FSRValue1);//this gives a printout of the reading of the analog value that is measured
  //Serial.println(FSRValue2);
  //Serial.println(FSRValue3);
  //Serial.println(FSRValue4);
  //Serial.println(FSRValue5);

  for (int i = 0; i < 4; i++) {
    if (a[i] > 0) {
      Serial.println(a[i], 5);
    }
  }
  delay(1000); //this slows down the readings so that they're given every 5 seconds
}
