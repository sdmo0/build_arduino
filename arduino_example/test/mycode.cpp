#include <Arduino.h>


int main(void)
{
  init();

#if defined(USBCON)
  USBDevice.attach();
#endif

  pinMode(13, OUTPUT);
  randomSeed(analogRead(0));

  for (;;) {
    digitalWrite(13, HIGH);
    delay(random(0, 1000));
    digitalWrite(13, LOW);
    delay(random(0, 1000));

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
