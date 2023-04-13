//
//  ContentView.swift
//  Calendarize
//
//  Created by Krish Vijayan on 2023-04-07.
//

import SwiftUI
import RegexBuilder

struct HomeView: View {
    @State var image: UIImage?
    var imageUI: UIImage?
    @State var show = false
    @State var imageData : Data = .init(capacity: 0)
    @State var imagePicker = false
    @State var imageCropper = false
    @State var source : UIImagePickerController.SourceType = .photoLibrary
    
    @State private var images: UIImage?
    @State private var showImageCropper = false
    @State private var tempInputImage = UIImage(named: "2B")
    @State private var day = 0
    @State private var imageArr: [UIImage?] = []
    @State private var timetable: [String : [String?]] = [:]
    @State private var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", ""]
    @State private var courses: [String?] = []
    @State private var timings: [String?] = []
    @State private var finalTimetable: [String: [[String]]] = ["Monday": [[],[]],"Tuesday": [[],[]], "Wednesday":[[],[]], "Thursday":[[],[]], "Friday":[[],[]] ]
    @State private var checkIfEmpty: [String] = []
    @State private var done: Bool = false
    
    
    func imageCropped(image: UIImage){
        //              self.tempInputImage = nil
    }
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Button("SHOW"){
                        print(finalTimetable)
                        
                    }
                    Button("Count"){
                        print(checkIfEmpty)
                    }
                    
                    Button("Choose your Calendar!"){
                        self.show.toggle()
                    }
                    .actionSheet(isPresented: $show){
                        ActionSheet(title: Text("Take a photo or select from photo library"), message: Text(""), buttons:
                                        [.default(Text("Photo Library "), action:{
                            self.source = .photoLibrary
                            self.imagePicker.toggle()
                        }),.default(Text("Camera"), action: {
                            self.source = .camera
                            self.imagePicker.toggle()
                        })])
                    }
                    .sheet(isPresented: $imagePicker){
                        ImagePicker(show: $imagePicker, image: $imageData, imageCropper: $imageCropper, imageUI: $image, source: source)
                        
                    }
                    if let notEmptyImage = image {
                        Text("Chop your calendar up!")
                        
                        Button(days[day]){
                            
                            self.imageCropper = true
                            
                        }
  
                        .sheet(isPresented: $imageCropper){
                            ImageCropper(image: $image, visible: $showImageCropper, day: $day, imageArr: $imageArr, timetable: $timetable, imageCropper: $imageCropper, done: $done)
                                .zIndex(10)
                        }
                        .onChange(of: timetable){ _ in
                            print(days[day])
                            if (timetable.isEmpty == false){
                                for word in timetable[days[day-1]]!{
                                    let courseCode = /^[A-Z]{3,5}\s[0-9]{2,4}/
                                    if let course = word!.firstMatch(of: courseCode){
                                        finalTimetable[days[self.day-1]]![0].append(String(course.output))
                                    }
                                    let timeRange = /(?-)\s*[0-9]{0,2}:[0-9]{0,2}\s*[A-Za-z]{2}\s*(?-)/
                                    if let timing = word!.firstMatch(of: timeRange){
                                        finalTimetable[days[self.day-1]]![1].append(String(timing.output))
                                    }
                                }
                            }

                        }
                        .padding()
                        
                        if (day == 5){
                            NavigationLink(destination: TimeTable().navigationBarHidden(true)){
                                Text("Done")
                            }
                        }
                        Button("Reset"){
                            day = 0
                            timetable.removeAll()
                            finalTimetable = ["Monday": [[],[]],"Tuesday": [[],[]], "Wednesday":[[],[]], "Thursday":[[],[]], "Friday":[[],[]] ]
                            print(timetable)
                            print(finalTimetable)
                        }
                        
                        
                    }
                    
                }
                
                
            }
            
        }
    }
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }
    
    
    
}
