Arduino Splines
===============

This is a simple library for differnent types of 1-D Splines, written
for the arduino environment.

Usage
---------------
Checkout the code

    git clone git://github.com/kerinin/arduino-splines.git ~/sketchbook/libraries/

Add the library header to your code

    #include <spline.h>

There are currently 4 types of spline interpolation available:

1. Degree 0:  This generates a step function.  Between any two points the
spline evaluates to the previous point

2. Degree 1:  Linear interpolation.  Between any two points the spline returns
the value of a straight line connecting the bounding points

3. Hermite:  Uses a Hermite spline to interpolate between the points.  This
method requires that you specify an array of tangent values _m_ as well as
the point arrays _x_ and _y_.

4. Catmull:  Uses a Catmull-Rom spline to interpolate between the points.  This
is an easy way to obtain smooth interpolation - you don't need to specify the
tangent points.

Be aware that when using Catmull-Rom splines, the first and last points
are not part of the spline - they are used to determine the tangency of the start
and end of the spline.  The spline itself starts at the second and second-to-last
point.

For all splines, values requested outside the defined spline bounds will return
the value of either the start or end point.

Using the library is fairly straightforward, simply pass it an array of points
and use the _value()_ function to interpolate between them.  The spline points 
can be specified either when you instantiate the class or using the _setPoints()_
and _setDegree()_ functions.

    double x[10] = {0,1,2,3,4,5,6,7,8,9};
    double y[10] = {0,0,5,5,0,0,3,4,5,6};
    doulbe m[10] = {0,.5,.5,.5.,.25,.25,.75,1,1,1}

    Spline stepSpline(x,y,10,0);
    Spline linearSpline(x,y,10,1);
    Spline hermiteSpline(x,y,m,10);       // No neet to specify type since m passed
    Spline catmullsSpline(x,y,10,Catmull);

    stepSpline.value(5.5);    // => 0
    linearSpline.value(5.5);  // => 1.5

    Spline mySpline();
    mySpline.setPoints(x,y);
    mySpline.setDegree(1);

    mySpline.value(5.5);      // => 1.5


