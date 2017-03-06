#include <SPI.h>
#include "PN532_SPI.h"
#include "PN532.h"
#include "NfcAdapter.h"

String const myUID_membership = "04 D8 A6 7A C8 48 80"; // replace this UID with your NFC tag's UID
String const myUID_personalInfo = "04 2A 7F 7A C8 48 81";
int const buzzerPin = 5;
int val;

PN532_SPI interface(SPI, 10); // create a SPI interface for the shield with the SPI CS terminal at digital pin 10
NfcAdapter nfc = NfcAdapter(interface); // create an NFC adapter object

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  nfc.begin(); // begin NFC comm
  pinMode(buzzerPin, OUTPUT);

}

void loop() {
  if (Serial.available()) {
    val = Serial.read();
  }
  if (nfc.tagPresent()) // check if an NFC tag is present on the antenna area
  {
    NfcTag tag = nfc.read(); // read the NFC tag
    String scannedUID = tag.getUidString(); // get the NFC tag's UID

    if ( myUID_membership.compareTo(scannedUID) == 0) // compare the NFC tag's UID with the correct tag's UID (a match exists when compareTo returns 0)
    {
      // The correct NFC tag was used
      Serial.write(0);
      tone(buzzerPin, 2500, 500);
    }
    if ( myUID_membership.compareTo(scannedUID) != 0) {
      // an incorrect NFC tag was used
      Serial.write(1);
      tone(buzzerPin, 200, 600);
    }
    
      if (myUID_personalInfo.compareTo(scannedUID) == 0) {
        Serial.write(2);
        tone(buzzerPin, 2500, 500);
      }
    
  } delay(2000);
}
