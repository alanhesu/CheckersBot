#include <Servo.h>
int servoPin = 9;
int closePos = 80;
int openPos = 110;
int dir;
Servo serv;

void setup() {
  // put your setup code here, to run once:
  pinMode(LED_BUILTIN, OUTPUT);
  Serial.begin(9600);
  serv.attach(servoPin);
}

void loop() {
  // put your main code here, to run repeatedly:
  while (Serial.available() > 0) {
    dir = Serial.parseInt();
  }
  if (dir > 0) {
    digitalWrite(LED_BUILTIN, HIGH);
    serv.write(openPos);
  } else {
    serv.write(closePos);
    digitalWrite(LED_BUILTIN, LOW);
  }
}
