#include <WiFi.h>
#include <FirebaseESP32.h>
#include <Adafruit_Sensor.h>
#include <DHT.h>
#include <DHT_U.h>

// WiFi credentials
#define WIFI_SSID "POCO F6"
#define WIFI_PASSWORD "12345678"

// Firebase config
#define FIREBASE_HOST "https://projectmobile-46937-default-rtdb.firebaseio.com/"
#define FIREBASE_AUTH "qWrTvvJpuEclvWTSqBGGvKoVKN8BUS1cHqka2HQY"

// Firebase instances
FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

// Pins
#define DHTPIN 2
#define DHTTYPE DHT11
#define SOIL_PIN 32         // Analog
#define IR_PIN 19          // Digital
#define RELAY_PIN 15       // Digital

DHT dht(DHTPIN, DHTTYPE);

void setup() {
  Serial.begin(115200);

  // Pin Modes
  pinMode(IR_PIN, INPUT);
  pinMode(RELAY_PIN, OUTPUT);

  // Start DHT
  dht.begin();

  // Connect WiFi
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to WiFi");
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("\nConnected!");

  // Firebase setup
  config.database_url = FIREBASE_HOST;
  config.signer.tokens.legacy_token = FIREBASE_AUTH;

  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);
}

void loop() {
  // === Sensor Readings ===
  float temp = dht.readTemperature();
  float hum = dht.readHumidity();
  int soilRaw = analogRead(SOIL_PIN);
  int soilPercent = map(soilRaw, 3000, 1200, 0, 100); // adjust range
  soilPercent = constrain(soilPercent, 0, 100);
  int irState = digitalRead(IR_PIN);

  // === Upload to Firebase ===
  if (!isnan(temp)) Firebase.setFloat(fbdo, "/Sensor/temperature", temp);
  if (!isnan(hum)) Firebase.setFloat(fbdo, "/Sensor/humidity", hum);
  Firebase.setInt(fbdo, "/Sensor/moisture", soilPercent);
  Firebase.setInt(fbdo, "/Sensor/ir", irState);

  // === Pump Control from Firebase ===
  if (Firebase.getString(fbdo, "/Actuator/pump")) {
    String pumpState = fbdo.stringData();
    pumpState.toUpperCase();
    if (pumpState == "ON" || pumpState == "1") {
      digitalWrite(RELAY_PIN, HIGH);
      Serial.println("Pump: ON");
    } else {
      digitalWrite(RELAY_PIN, LOW);
      Serial.println("Pump: OFF");
    }
  } else {
    Serial.println("Fail fetch pump state");
  }

  // === Serial Debug ===
  Serial.print("Temp: "); Serial.print(temp);
  Serial.print("°C | Hum: "); Serial.print(hum);
  Serial.print("% | Soil: "); Serial.print(soilPercent);
  Serial.print("% | IR: "); Serial.println(irState);

  delay(1000);
}
