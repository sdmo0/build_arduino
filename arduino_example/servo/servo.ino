#include <Arduino.h>
#include <Servo.h>

int servoPin = 9;

Servo servo;

int servoAngle = 0;

// the setup function runs once when you press reset or power the board
void setup() {
  Serial.begin(9600);
  servo.attach(servoPin);
}

// the loop function runs over and over again forever
void loop() {
  servo.write(45);
  delay(1000);
  servo.write(90);
  delay(1000);
  servo.write(135);
  delay(1000);
  servo.write(90);
  delay(1000);

  for (servoAngle = 0; servoAngle < 180; servoAngle++) {
    servo.write(servoAngle);
    delay(50);
  }

  for (servoAngle = 180; servoAngle > 0; servoAngle--) {
    servo.write(servoAngle);
    delay(10);
  }

  delay(1500);  // wait for a second
}
