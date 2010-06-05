#include <spline.h>
#include <buttons.h>
#include <OneWire.h>
#include <DallasTemperature.h>
#include <LiquidCrystal.h>
#include <PID_Beta6.h>


// Constants

// Sensors
#define oneWirePin 11

// Control
#define relayPin 10

// UI
#define lcdRsPin 12
#define lcdEnablePin 13
#define lcdD4Pin 4
#define lcdD5Pin 5
#define lcdD6Pin 6
#define lcdD7Pin 7

#define modeButtonPin 2
#define selectButtonPin 3

#define modActive 0
#define modTargetMode 1
#define modSetTarget 2
#define modHardwareProfile 3
#define modTune 4
#define modCount 5

#define tModeConstant 0
#define tModeSmokedPork 1
#define tModeSmokedBrisket 2
#define tModeCount 3

#define hwSmoker 0
#define hwSousVide 1
#define hwCount 2

// Sensor Variables
//byte oneWireData[12];
//byte oneWireAddr[8];
DeviceAddress insideThermometer;
double temperature;
OneWire oneWire(oneWirePin);
DallasTemperature tempSensor(&oneWire);

// Control Variables
Spline tempCurve;
double setPoint = 225;
double pidOutput = 0;
int pValue = 50;
int iValue = 600;
int dValue = 10;
PID controller(&temperature, &pidOutput, &setPoint, pValue, iValue, dValue);

// UI variables
LiquidCrystal lcd(lcdRsPin, lcdEnablePin, lcdD4Pin, lcdD5Pin, lcdD6Pin, lcdD7Pin);
Button bMode;
Button bSelect;
int mode = modActive;
int tMode = 0;
int hwProfile = 0;
int setupMode = true;

void setup(void) {
  Serial.begin(9600);
  
  // Setup UI
  setup_ui();
  
  double x[5] = {0,1,2,3,4};
  double y[5] = {0,8,5,2,10};
  tempCurve.setPoints(x,y,5);
  tempCurve.setDegree( Catmull );
  
  for( float i = 0; i <= 4; i+= .1 ) {
    Serial.print(i);
    for(float j=0; j<= tempCurve.value(i); j += .2) {
      Serial.print( "*" );
    }
    Serial.print( "   " );
    Serial.println(tempCurve.value(i));
  }
}

void loop(void) {

}


void setup_ui(void) {
  bMode.assign( modeButtonPin );
  bMode.setMode( Memory );
  bSelect.assign( selectButtonPin );
  bSelect.setMode( MemoryTimer );
  bSelect.setTimer( 1500 );
  bSelect.setRefresh( 200 );

  lcd.begin( 16, 2);
  lcd.print("initialized...");
}

