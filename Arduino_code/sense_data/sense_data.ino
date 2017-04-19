#include <dht.h>


int red = 3;
int yellow = 7;
int green = 8;
int motor = 9;


int waterPin = A1;
int rainPin = A2;
int lightPin = A4;
int soilPin = A5;

float water_level; 
float soil_moisture = 0; 
float rain_val = 0;
float light = 1.0; 

float temperature = 0;
float humidity = 0;

float rain = 0; 
float water = 0;
float hot = 0;

dht DHT;

// Humidity and temperature Sensor

#define DHT11_PIN A0

void setup()
{
  analogReference(INTERNAL);
  pinMode(rainPin, INPUT);
  pinMode(red, OUTPUT);
  pinMode(green, OUTPUT);
  pinMode(yellow, OUTPUT);
  Serial.begin(38400); 
}

void loop()
{
  int flag = 0;
   while(Serial.available()){
     val = Serial.read();
    // Serial.println(val);
     
  }
  if(val == 1)
  {
    digitalWrite(motor, HIGH);
    delay(4000);
  }
  else if (val==0){
    digitalWrite(motor, LOW);
    delay(1000);
  }
  water_alert();
  soil_moisture = analogRead(soilPin);
  Serial.print("Soil MOisture");
  Serial.print(soil_moisture);
  rain_info();  
  light_info();     
  humidity_temp_info();

  flag = water_plants();
  if (flag ==1)
  {
    // Switch on pump
    //Serial.write(motor, HIGH);
    digitalWrite(green, HIGH);
    Serial.write("Motor is on ");
    delay(1800);
   
    digitalWrite(green, LOW);
  }
  
  //Serial.println(millis());
  Serial.println("\n");

  // Check values after every 30 minutes 
  delay(1800);
}


int water_plants()
{
  int i = 0;
  // Plants are not watered during night
  if( light == 0)
    return 0;
  // Plants are not watered when it's raining
  if( rain == 0)
    return 0;
  
  if(soil_moisture > 980)
    return 1;  
}


void humidity_temp_info()

{
  int chk = DHT.read11(DHT11_PIN);
  Serial.print("Humidity (%): ");
  Serial.println((float)DHT.humidity, 2);
 

  Serial.print("Temperature (°C): ");
  Serial.print((float)DHT.temperature, 2);

  if(DHT.temperature > 36)
  {
     hot = 1;
     digitalWrite(yellow,HIGH);// Temp is  high
  }
 
}


void rain_info()
{
   rain_val = analogRead(rainPin); 
   Serial.print(" Rain level " );  
   Serial.print(rain_val);  
   if(rain_val > 1000)
   {
    rain = 0; // NO RAIN
   }
   else{
    rain = 1;
   }
}



void water_alert()
{
  water_level = analogRead(waterPin);    
  Serial.print("Water level");
  Serial.print(water_level);
  if(water_level < 800){
   // NO WATER
   water = 0;
   digitalWrite(red, HIGH);
  }
  else{
    digitalWrite(red, LOW);
    water = 1;
  }
}


// Return 0 when ligh is low, 1 When high
int light_info()
{
  float lightR = analogRead(lightPin); 
  if(lightR > 1000)
  {
    //It is Dark, Low Light
    Serial.println("0");
    return 0;
  }
  Serial.println("1");
  return 1;
}


