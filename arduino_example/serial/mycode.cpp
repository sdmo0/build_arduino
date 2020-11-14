#include <avr/interrupt.h>
#include "Arduino.h"

int val;
int ledpin = 13;

int main(void)
{
  init();

#if defined(USBCON)
  USBDevice.attach();
#endif

  Serial.begin(9600);
  pinMode(ledpin, OUTPUT);
  randomSeed(analogRead(0));

  for (;;) {
    val = Serial.read();
    if (val == 'R')
      {
	digitalWrite(ledpin, HIGH);
	delay(random(0, 1000));
	digitalWrite(ledpin, LOW);
	delay(random(0, 1000));
	Serial.println("Hello World!");
      }

    if (serialEventRun) serialEventRun();
  }
  return 0;
}

/*
void setup(void)
{
  pinMode(13, OUTPUT);
  randomSeed(analogRead(0));
}

void loop(void)
{
  digitalWrite(13, HIGH);
  delay(random(0, 1000));
  digitalWrite(13, LOW);
  delay(random(0, 1000));
}
*/
