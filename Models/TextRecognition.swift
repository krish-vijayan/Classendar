//
//  TextRecognition.swift
//  Calendarize
//
//  Created by Krish Vijayan on 2023-04-07.
//

import Foundation
import SwiftUI
import Vision
import UIKit


struct TextRecognition {
    //function returns the text from inputed image
    static func recognizeText(image: UIImage?) -> [String?]{
        var output: [String?] = []
        // Get the CGImage on which to perform requests.
        guard let cgImage = image?.cgImage else { fatalError("Error converting to CGImage") }
        
        // Create a new image-request handler.
        let requestHandler = VNImageRequestHandler(cgImage: cgImage)
        
        // Create a new request to recognize text.
        let request = VNRecognizeTextRequest {request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation],
                  error == nil else{
                return
            }
            for observation in observations {
                output.append(observation.topCandidates(1).first?.string)
            }
        }
        request.recognitionLevel = VNRequestTextRecognitionLevel.accurate
        do {
            // Perform the text-recognition request.
            try requestHandler.perform([request])
        } catch {
            print("Unable to perform the requests: \(error).")
        }
        return output
    }
}
