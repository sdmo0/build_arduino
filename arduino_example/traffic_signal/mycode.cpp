#include "Arduino.h"

int ledDelay = 10000;
int redPin = 10;
int yellowPin = 9;
int greenPin = 8;

int main(void)
{

  init();

  pinMode(redPin, OUTPUT);
  pinMode(yellowPin, OUTPUT);
  pinMode(greenPin, OUTPUT);

#if defined(USBCON)
  USBDevice.attach();
#endif
  for (;;)
    {
      digitalWrite(redPin, HIGH);
      delay(ledDelay);
      digitalWrite(yellowPin, HIGH);
      delay(2000);
      digitalWrite(greenPin, HIGH);
      digitalWrite(redPin, LOW);
      digitalWrite(yellowPin, LOW);
      delay(ledDelay);
      digitalWrite(yellowPin, HIGH);
      digitalWrite(greenPin, LOW);
      delay(2000);
      digitalWrite(yellowPin, LOW);

      if (serialEventRun) serialEventRun();
    }

  return 0;
}
