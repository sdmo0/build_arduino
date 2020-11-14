#include <SPI.h>

char buff[50] = {0, };
volatile byte indx = 0;
volatile boolean process = false;
volatile int count = 0;

void setup(void)
{
    Serial.begin(9600);
    pinMode(MISO, OUTPUT); // have to send on master in so it set as output
    SPCR |= _BV(SPE);      // turn on SPI in slave mode
    indx = 0;              // buffer empty
    process = false;
    SPI.attachInterrupt(); // turn on interrupt
}

ISR(SPI_STC_vect) // SPI interrupt routine
{
    byte c = SPDR; // read byte from SPI Data Register
    if (indx < (sizeof(buff) - 1))
    {
        buff[indx++] = c; // save data in the next index in the array buff
        if (c == '\n') {    //check for the end of the word
            process = true;
            buff[indx] = 0;
        }
    }
    count++;
}

void loop(void)
{
    if (process)
    {
        Serial.print(count);
        Serial.print(':');
        Serial.println(buff); //print the array on serial monitor
        process = false;      //reset the process
        indx = 0;             //reset button to zero
    }
}
