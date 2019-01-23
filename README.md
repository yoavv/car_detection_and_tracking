# car_detection_and_tracking

We would like to measure how many vehicles cross a certain line and their movement direction while
crossing it.
For example, in the frame below, we would like to know how many vehicles crossed the blue line while
moving in the red arrow direction and how many crossed while moving in the green arrow direction.

<img src="images/parking.png" alt="drawing" width="400"/>

## detecting the cars in the image
Find background using a Gaussian model

<img src="images/1.jpg" alt="drawing" width="200"/>

Subtract background

<img src="images/2.jpg" alt="drawing" width="200"/>

Morphologically open image

<img src="images/3.jpg" alt="drawing" width="200"/>

Morphologically close image

<img src="images/4.jpg" alt="drawing" width="200"/>

Fill image regions and holes

<img src="images/5.jpg" alt="drawing" width="200"/>

Filter by size

<img src="images/6.jpg" alt="drawing" width="200"/>

Remove Images Classified as non Cars

## Track Cars From Previous Frames
Compare 3 key features:

	Car orientation change
  
	Position change
  
	Color similarity
  

If a match is not found a new car is created




