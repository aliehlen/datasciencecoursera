## Codebook for data tidying of *Human Activity Recognitition Using Smartphones Dataset* from the UCI Machine Learning Repository.

The final dataset, summarydata_mean_std.csv, contains a summary of the original test and training datasets, which were taken from smartphone motion data while test subjects were performing specified activities. The original dataset contained accelerometer and gyroscope data, filtered, broken down into 3 axes and magnitude, decomposed into linear acceleration, angular velocity, and jerk signals. These were presented in time and frequency domains (based on a fast fourier transform). These data were provided as summary statics such as mean, max, standard deviation, skewness, etc, per time interval, see original readme and codebook text below.

The data in summarydata_mean_std.csv contains a summary of the original data. It is presented in terms of seven variables. These are:
* subject: 1-30. indicates which subject performed the experiment.
* activity: laying, sitting, standing, walking, walkingupstairs, walking downstairs. indicates in activity the subject was performing.
* feature: BodyAcc, BodyAccJerk, BodyBodyAccJerk, BodyBodyGyro, BodyBodyGyroJerk, BodyGyro, BodyGyroJerk, GravityAcc
* domain: t or f for time or frequency
* direction: x, y, z, or magnitude of the vector
* averagemean: average of given means by subject, activity, feature, domain, direction
* averagestandarddev: average of given standard deviations by subject, activity, feature, domain, direction

Note: all values are noralized to [-1,1].

This data was compiled from features.txt (feature names), activity_labels.tst (mapping of activity label numbers to descriptions), train/X_train.txt(data for all features), train/y_train.txt (activity labels for each observation), train/subject_train.txt (subject number for each observation), and test/X_test.txt, test/y_test.txt, and test/subject_test.csv.


## Original codebook

Feature Selection
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

These signals were used to estimate variables of the feature vector for each pattern:
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are:

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values.
iqr(): Interquartile range
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal
kurtosis(): kurtosis of the frequency domain signal
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'
              
