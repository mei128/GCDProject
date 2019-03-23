## Getting and Cleaning Data Project Datasets ##
# Code Book #
mei128@infantes.com

This dataset has been produced as a class project for the Getting and Cleaning Data course, and it is based on the *Human Activity Recognition Using Smartphones Dataset [1]*. The original set contained mobile phone accelerometer and gyroscope data for 30 individuals performing 6 activities, taken in overlapping moving windows of 128 samples per window. Acceleration was split in its body and gravity components,along the XYZ axis, total magnitude was computed, and each dimension was derived in time (rate of change) to obtain jerk signals. Finally, a FFT was applied to some of the time based signals to obtain frequency domain signals.

**Accelerometer data** is normalized and **expressed as fractions of g** (9,81$m/s^(2)$). **Angular (gyroscope) data** is expressed in **radians/second**.

#### Nomenclator ####

Variables names are constructed acording to the following rules:

*time*   time based signal
*freq*  frequency base signal

*Body*    body component
*Gravity* gravity component

*Acceleration*  accelerometer data
*Angular*   gyroscope data

*Jerk*  jerk signals

*X* X component
*Y* Y component
*Z* Z component
*Magnitude* total magnitude

*mean*  mean based value
*stdev* standard deviation based value

#### Variables ####

Subject Subject ID
Activity Activity being performed
time.Body.Acceleration.X.mean
time.Body.Acceleration.Y.mean
time.Body.Acceleration.Z.mean
time.Body.Acceleration.X.stdev
time.Body.Acceleration.Y.stdev
time.Body.Acceleration.Z.stdev
time.Gravity.Acceleration.X.mean
time.Gravity.Acceleration.Y.mean
time.Gravity.Acceleration.Z.mean
time.Gravity.Acceleration.X.stdev
time.Gravity.Acceleration.Y.stdev
time.Gravity.Acceleration.Z.stdev
time.Body.Acceleration.Jerk.X.mean
time.Body.Acceleration.Jerk.Y.mean
time.Body.Acceleration.Jerk.Z.mean
time.Body.Acceleration.Jerk.X.stdev
time.Body.Acceleration.Jerk.Y.stdev
time.Body.Acceleration.Jerk.Z.stdev
time.Body.Angular.X.mean
time.Body.Angular.Y.mean
time.Body.Angular.Z.mean
time.Body.Angular.X.stdev
time.Body.Angular.Y.stdev
time.Body.Angular.Z.stdev
time.Body.Angular.Jerk.X.mean
time.Body.Angular.Jerk.Y.mean
time.Body.Angular.Jerk.Z.mean
time.Body.Angular.Jerk.X.stdev
time.Body.Angular.Jerk.Y.stdev
time.Body.Angular.Jerk.Z.stdev
time.Body.Acceleration.Magnitude.mean
time.Body.Acceleration.Magnitude.std
time.Gravity.Acceleration.Magnitude.mean
time.Gravity.Acceleration.Magnitude.std
time.Body.Acceleration.Jerk.Magnitude.mean
time.Body.Acceleration.Jerk.Magnitude.std
time.Body.Angular.Magnitude.mean
time.Body.Angular.Magnitude.std
time.Body.Angular.Jerk.Magnitude.mean
time.Body.Angular.Jerk.Magnitude.std
freq.Body.Acceleration.X.mean
freq.Body.Acceleration.Y.mean
freq.Body.Acceleration.Z.mean
freq.Body.Acceleration.X.stdev
freq.Body.Acceleration.Y.stdev
freq.Body.Acceleration.Z.stdev
freq.Body.Acceleration.Jerk.X.mean
freq.Body.Acceleration.Jerk.Y.mean
freq.Body.Acceleration.Jerk.Z.mean
freq.Body.Acceleration.Jerk.X.stdev
freq.Body.Acceleration.Jerk.Y.stdev
freq.Body.Acceleration.Jerk.Z.stdev
freq.Body.Angular.X.mean
freq.Body.Angular.Y.mean
freq.Body.Angular.Z.mean
freq.Body.Angular.X.stdev
freq.Body.Angular.Y.stdev
freq.Body.Angular.Z.stdev
freq.Body.Acceleration.Magnitude.mean
freq.Body.Acceleration.Magnitude.std
freq.Body.Acceleration.Jerk.Magnitude.mean
freq.Body.Acceleration.Jerk.Magnitude.std
freq.Body.Angular.Magnitude.mean
freq.Body.Angular.Magnitude.std
freq.Body.Angular.Jerk.Magnitude.mean
freq.Body.Angular.Jerk.Magnitude.std


[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
