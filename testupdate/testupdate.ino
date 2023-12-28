#include <WiFi.h>
#include <HTTPClient.h>
#include <WiFiClient.h>
#include <Update.h>
#include <SoftwareSerial.h>
String oku;
String ssid;
String pass;
String artik;
int relay1=13;
int relay2=12;
int relay3=14;
int relay4=27;
float temp = 25.5;
unsigned long previousMillis=0;
const long interval=500; //5 sec
int coolingSetting = 0;
const char* update_url = "http://yusufcirak.com.tr/test.bin"; // URL of the update file
 float targetTemp; // Target temperature

float measuredTemp; // Measured temperature
SoftwareSerial mySerial(16, 17); // RX, TX pins

void setup() {
  Serial.begin(115200);
  mySerial.begin(115200);
  pinMode(relay1,OUTPUT);
   pinMode(relay2,OUTPUT);
    pinMode(relay3,OUTPUT);
     pinMode(relay4,OUTPUT);
 
 
}

void loop() {

   
if (WiFi.status() == WL_CONNECTED)  // Connect to WiFi network
  {
    Serial.println("\nConnected to WiFi.");
    String mac = WiFi.macAddress();

   unsigned long currentMillis =millis();
  if (currentMillis-previousMillis>=interval){
    previousMillis=currentMillis;
   
      mySerial.print("MAC Address:");
  mySerial.print(mac);
      mySerial.print(";");
        mySerial.print("PowerCheck;");
       mySerial.print("TemperatureCheck;");
      mySerial.print("Temperature");
       mySerial.print(temp);
        mySerial.print(";");
    }
  }

  else {

    Serial.println("No connection...");

 
  if (mySerial.available() > 0) {

    ssid = mySerial.readStringUntil(';');
    pass = mySerial.readStringUntil(';');

    artik = mySerial.readString();

    WiFi.begin(ssid, pass);

    delay(10000);

  }
 }

 
  if (mySerial.available()) {
      String receivedValue = mySerial.readStringUntil('\n');
    int lastIndex = 0;
    while (receivedValue.indexOf(';', lastIndex) != -1) {
      int nextIndex = receivedValue.indexOf(';', lastIndex);
      String token = receivedValue.substring(lastIndex, nextIndex);
     
    if (token == "update") {
      Serial.println("Starting update...");
      if (!performUpdate(update_url)) {
        Serial.println("Update failed!");
      }
    } else if (token == "HydroWandOn") {
        Serial.println("HydroWandStart");
        digitalWrite(relay1, HIGH);
      } else if (token == "HydroWandOff") {
        Serial.println("HydroWandStop");
        digitalWrite(relay1, LOW);
      } else if (token == "CoolingOn") {
        Serial.println("CoolingStart");
        digitalWrite(relay2, HIGH);
      } else if (token == "CoolingOff") {
        Serial.println("CoolingStop");
        digitalWrite(relay2, LOW);
      } else if (token == "OxyOn") {
        Serial.println("OxyStart");
        digitalWrite(relay3, HIGH);
      } else if (token == "OxyOff") {
        Serial.println("OxyStop");
        digitalWrite(relay3, LOW);
      }else if (token.startsWith("CoolingSetting:")) {
     
        coolingSetting = token.substring(15).toInt();
        Serial.print("Cooling Setting: ");
        Serial.println(coolingSetting);
     
      }
     
      lastIndex = nextIndex + 1;
    }
  }
  delay(100);
}


 
bool performUpdate(String url) {
  WiFiClient client;
  HTTPClient http;

  // Send HTTP request to update URL
  http.begin(client, url);
  int httpCode = http.GET();

  // If HTTP request is successful, start the update
  if (httpCode == 200) {
    Update.onProgress(updateProgress);
    if (Update.begin(http.getSize())) {
      size_t written = Update.writeStream(http.getStream());
      if (written == http.getSize()) {
        Serial.println("Writing complete. Restarting...");
        if (Update.end()) {
          Serial.println("Update successful!");
          ESP.restart();
          return true;
        } else {
          Update.printError(Serial);
        }
      } else {
        Serial.println("Written and expected sizes do not match!");
      }
    } else {
      Update.printError(Serial);
    }
  } else {
    Serial.println("Failed to download update file: " + String(httpCode));
  }
  return false;
}

void updateProgress(size_t done, size_t total) {
  Serial.printf("Update Progress: %u%%\r\n", (done * 100) / total);
}
