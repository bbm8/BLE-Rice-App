
#include <SoftwareSerial.h>

SoftwareSerial mySerial(10, 11); // RX, TX
boolean isOn = false; 
boolean isOutputtingAnalog = false;
int buttonState = 0;
long lastDebounceTime = 0;
void setup() {
  // put your setup code here, to run once:
  pinMode(7, OUTPUT);
  pinMode(2, INPUT);
  mySerial.begin(9600); 
}

void loop() {
  // put your main code here, to run repeatedly:
  buttonState = digitalRead(2);
  if (buttonState == HIGH && lastDebounceTime+200 < millis()) 
  {
    mySerial.println("3:Clr");
    mySerial.println("1:Color Change");
    lastDebounceTime = millis();
  }
  if(mySerial.available())
  {
    String s = mySerial.readString();
    mySerial.print("1:");
    if(s.equals("Hi"))
        mySerial.println("Hello");
     else
     {  
        if(s.equals("rand"))
          mySerial.println(random(10));
        else
        {
          if(s.equals("LED") || s.equals("1"))
          {
            if(isOn)
            {
              digitalWrite(7, LOW); 
              mySerial.println("LED OFF");
            }
            else
            {
              digitalWrite(7, HIGH); 
              mySerial.println("LED ON");

            }               
            isOn=!isOn;
          }
          else
          {
            if(s.equals("A0"))
            {
                isOutputtingAnalog = !isOutputtingAnalog;
                if(isOutputtingAnalog)
                  mySerial.println("Outputting A0");
                if(!isOutputtingAnalog)
                  mySerial.println("Stopped A0");
            }
            else
            {
              mySerial.println("Don't Understand");  
            }
          }
        }
     }
    
     
  }
  if(isOutputtingAnalog)
  {
     int sensorValue = analogRead(A0);
     mySerial.print("2:");
     mySerial.print(sensorValue);
     mySerial.print("\n");
     delay(25);
  }
}
