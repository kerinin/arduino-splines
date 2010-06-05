/*
  Library for 1-d splines
  Copyright Ryan Michael
  Licensed under the GPLv3 
*/
#ifndef spline_h
#define spline_h

#include "WProgram.h"

#define Hermite 10
#define Catmull 11

class Spline
{
  public:
    Spline( void );
    Spline( double x[], double y[], int numPoints, int degree = 1 );
    Spline( double x[], double y[], double m[], int numPoints );
    double value( double x );
    void setPoints( double x[], double y[], int numPoints );
    void setPoints( double x[], double y[], double m[], int numPoints );
    void setDegree( int degree );
    
  private:
    double calc( double, int);
    double* _x;
    double* _y;
    double* _m;
    int _degree;
    int _length;
    int _prev_point;
    
    double hermite( double t, double p0, double p1, double m0, double m1, double x0, double x1 );
    double hermite_00( double t );
    double hermite_10( double t );
    double hermite_01( double t );
    double hermite_11( double t );
    double catmull_tangent( int i );
};

#endif
