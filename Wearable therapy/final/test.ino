#include "pitches.h"

int melody[] = {
  NOTE_C4, NOTE_G3, NOTE_G3, NOTE_A3, NOTE_G3, 0, NOTE_B3, NOTE_C4
};

int noteDurations[] = {
  4, 8, 8, 4, 4, 4, 4, 4
};

int bendSensor;
int touchSensor=4;
int led1 = 12;
int led2 = 13;
int audio = 11;

int last_times=0;
int times = 0;


void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(A0, INPUT_PULLUP);
  pinMode(led1, OUTPUT);
  pinMode(led2, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  touchSensor = digitalRead(touchSensor);
  //Serial.print("Touch Sensor:");
  //Serial.println(touchSensor);
  if (touchSensor > 50) {
    if (bendSensor < 30) {
      digitalWrite(led2, LOW);
      digitalWrite(led1, HIGH);
      //times+=1;
    } else {
      digitalWrite(led1, LOW);
      digitalWrite(led2, LOW);
    }
  } else {
    int noteDuration = 1000 / noteDurations[0];
    //tone(audio, melody[0], noteDuration);
    int pauseBetweenNotes = noteDuration * 1.30;
    delay(pauseBetweenNotes);
    noTone(audio);
    digitalWrite(led1, LOW);
    if (bendSensor < 30) {
      digitalWrite(led2, HIGH);
      times+=1;
    } else {
      digitalWrite(led1, LOW);
      digitalWrite(led2, LOW);
    }
  }

  bendSensor = analogRead(A1);
  Serial.print("Bend Sensor:");
  Serial.println(bendSensor);
  //Serial.println(times);
}
