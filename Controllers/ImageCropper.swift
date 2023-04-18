//
//  ImageCropper.swift
//  Calendarize
//
//  Created by Krish Vijayan on 2023-04-08.
//

import Foundation
import UIKit
import SwiftUI
import CropViewController

struct ImageCropper: UIViewControllerRepresentable{
    @Binding var image: UIImage?
    @Binding var visible: Bool
    let days = ["Monday", "Tuesday", "Wedneday", "Thursday", "Friday", ""]
    @Binding var day: Int
    @Binding var imageArr: [UIImage?]
    @Binding var timetable: [String : [String?]]
    @Binding var imageCropper: Bool
    @Binding var done: Bool
    var testImage =  UIImage(named: "tester")
   
    
    
    class Coordinator: NSObject, UINavigationControllerDelegate, CropViewControllerDelegate{
        let parent: ImageCropper

        init(_ parent: ImageCropper){
            self.parent = parent
        }
        
        func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
            let originalImage = self.parent.image!
            self.parent.image = image
            self.parent.imageArr.append(image)
            
            
            if (TextRecognition.recognizeText(image: image).isEmpty == false){
                let dayOfWeek = self.parent.days[self.parent.day]
            switch dayOfWeek{
            case "Monday":
                self.parent.timetable["Monday"] = TextRecognition.recognizeText(image: image)
            case "Tuesday":
                self.parent.timetable["Tuesday"] = TextRecognition.recognizeText(image: image)
            case "Wedneday":
                self.parent.timetable["Wednesday"] = TextRecognition.recognizeText(image: image)
            case "Thursday":
                self.parent.timetable["Thursday"] = TextRecognition.recognizeText(image: image)
            case "Friday":
                self.parent.timetable["Friday"] = TextRecognition.recognizeText(image: image)
                self.parent.done = true
            default:
                print("default")
            }
            }
                self.parent.day += 1
            
            self.parent.imageCropper = false
            
            self.parent.image = originalImage
            cropViewController.dismiss(animated: true)
        }
        
        func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
            self.parent.imageCropper = false
            cropViewController.dismiss(animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let img = self.image ?? UIImage() //change back to self.image
        let cropViewController = CropViewController(image: img)
        cropViewController.delegate = context.coordinator
       
        cropViewController.doneButtonTitle = days[day]
        cropViewController.cancelButtonColor = .red
        cropViewController.doneButtonColor = .systemBlue
        
//        cropViewController.doneButtonTitle = "Monday"
        return cropViewController
    }
}
