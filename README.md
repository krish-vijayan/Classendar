#  WWDC23 Swift Student Challenge Submission

<h1>Classendar
  <img align="right" src="https://user-images.githubusercontent.com/96496079/232795273-67325589-82e1-45a6-aeca-ecc2f4688dd3.png" width=74px>
</h1>
<br/>

An iOS app that takes an image of a post-secondary/higher-education student's class calendar and turns it into a deck of cards.

## Technologies Used

* Xcode 14.3 
* Swift 
* SwiftUI
* UIKit
* Vision
* ShuffleIt (https://github.com/dscyrescotti/ShuffleIt#shuffledeck) 
* TOCropViewController (https://github.com/TimOliver/TOCropViewController)

## How It Works 

After user selects class calendar either from their photo library or their camera, they will then have to crop the column of classes for each day of 
the week. After each crop, the text is then read by Vision and parsed using Regex to identify class codes and time ranges. This information is  then 
stored inside of a dictionary with the key being the day of the week, and the value being an array of class codes and the following time ranges. This 
dictionary is stored in UserDefaults and is then passed through some logic to finally be displayed on the deck of cards.  

## Screenshots

<p float="left"> 
  <img src="https://user-images.githubusercontent.com/96496079/232663310-da4d62b2-210f-438d-8159-6d10ed04a1a7.png" width="400" />
  <img src="https://user-images.githubusercontent.com/96496079/232660933-ad326fcc-56bc-42ea-9b92-28e38c24dfb6.png" width="400" /> 
</p>
<p float="left">
  <img src="https://user-images.githubusercontent.com/96496079/232660993-887ab4ee-a6be-43f6-a69a-88fbe2de579a.png" width="400" />
  <img src="https://user-images.githubusercontent.com/96496079/232661005-6fd84705-5295-4493-a122-cf80b685e8c5.png" width="400" />
</p>

## Demo
https://youtu.be/RqfgMU-SmhA


