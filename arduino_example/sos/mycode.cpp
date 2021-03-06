#include "Arduino.h"


int main(void)
{
  int ledPin = 13;

  init();

#if defined(USBCON)
  USBDevice.attach();
#endif

  pinMode(ledPin, OUTPUT);
  randomSeed(analogRead(0));

  for (;;) {
    for (int x=0; x<3; x++)
      {
	digitalWrite(ledPin, HIGH);
	delay(150);
	digitalWrite(ledPin, LOW);
	delay(100);
      }
    delay(100);

    for (int x=0; x<3; x++)
      {
	digitalWrite(ledPin, HIGH);
	delay(400);
	digitalWrite(ledPin, LOW);
	delay(100);
      }
    delay(100);

    for (int x=0; x<3; x++)
      {
	digitalWrite(ledPin, HIGH);
	delay(150);
	digitalWrite(ledPin, LOW);
	delay(100);
      }
    delay(5000);

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
