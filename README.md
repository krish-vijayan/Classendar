#  WWDC23 Swift Student Challenge Submission


## Classendar 

An app that takes an image of a post-secondary/higher-education student's class calendar and turns it into a deck of cards.

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
dictionary stored in UserDefaults and is then passed through some logic to then be displayed on the deck of cards.  


## Screenshots


## Demo


