#include <avr/interrupt.h>
#include "Arduino.h"

volatile int led_state = 1;

void blink(void)
{
  led_state = !led_state;
  delay(200);
}

int main(void)
{
  init();

#if defined(USBCON)
  USBDevice.attach();
#endif
  attachInterrupt(0, blink, FALLING);
  pinMode(7, OUTPUT);
  randomSeed(analogRead(0));

  for (;;) {
    if (led_state) 
      {
	digitalWrite(7, HIGH);
	delay(random(0, 1000));
	digitalWrite(7, LOW);
	delay(random(0, 1000));
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
