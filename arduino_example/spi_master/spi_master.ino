#include <SPI.h>

int led = 13;
void blink(void)
{
    digitalWrite(led, HIGH); // turn the LED on (HIGH is the voltage level)
    delay(1000);             // wait for a second
    digitalWrite(led, LOW);  // turn the LED off by making the voltage LOW
    delay(1000);
}

void setup(void)
{
    Serial.begin(9600);
    digitalWrite(SS, HIGH);
    SPI.begin();
    SPI.setClockDivider(SPI_CLOCK_DIV32);
}

void loop(void)
{
    digitalWrite(SS, LOW);

    const char *p = "Hello, Sangdok\r\n";
    for (; *p != 0; p++)
    {
        SPI.transfer(*p);
        Serial.print(*p);
    }

    digitalWrite(SS, HIGH);
    blink();
    blink();
    delay(2000);
}
