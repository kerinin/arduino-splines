#include <spline.h>

Spline tempCurve;

void setup(void) {
  Serial.begin(9600);
  
  double x[7] = {-1,0,1,2,3,4, 5};
  double y[7] = { 0,0,8,5,2,10,10};
  tempCurve.setPoints(x,y,7);
  tempCurve.setDegree( Catmull );
  
  for( float i = 0; i <= 4; i+= .1 ) {
    float temp = tempCurve.value(i);
    Serial.print(i);
    for(float j=0; j<= temp; j += .2) {
      Serial.print( "*" );
    }
    Serial.print( "   " );
    Serial.println(temp);
  }
}

void loop(void) {

}
