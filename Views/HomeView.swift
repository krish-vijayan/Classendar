//
//  ContentView.swift
//  Calendarize
//
//  Created by Krish Vijayan on 2023-04-07.
//

import SwiftUI

struct HomeView: View {
    @State var image: UIImage?
    @State var show = false
    @State var imageData : Data = .init(capacity: 0)
    @State var imagePicker = false
    @State var imageCropper = false
    @State var source : UIImagePickerController.SourceType = .photoLibrary
    @State private var showImageCropper = false
    @State private var day = 0
    @State private var imageArr: [UIImage?] = []
    @State private var timetable: [String : [String?]] = [:]
    @State private var done: Bool = false
    @State var finalTimetable: [String: [String]] =  UserDefaults.standard.dictionary(forKey: "UserCalendar") as? [String: [String]] ?? ["Monday": [],"Tuesday": [], "Wednesday":[], "Thursday":[], "Friday":[] ]
    @State var userCalendar: Bool = false
    var imageUI: UIImage?

    @State private var showTutorial = false
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack{
                    Circle()
                        .frame(width: 400, height: 400)
                        .foregroundStyle(.white)
                        .blur(radius: 10.0)
                        .position(x: 700, y: 100)
                        .opacity(0.4)
                        .ignoresSafeArea()
                    
                    
                    Circle()
                        .frame(width: 400, height: 400)
                        .foregroundStyle(.white)
                        .blur(radius: 10.0)
                        .position(x: 400, y: 900)
                        .opacity(0.4)
                    
                    Circle()
                        .frame(width: 1200, height: 1000)
                        .opacity(0.4)
                        .foregroundColor(.black)
                    
                    VStack {
                        if (userCalendar){
                            NavigationLink(destination: TimeTable(finalTimetable: $finalTimetable).navigationBarHidden(true)){
                                VStack{
                                    Text("My Calendar")
                                        .frame(height: 200)
                                        .font(.title)
                                        .fontWeight(.bold)
                                    Button("Reset"){
                                        userCalendar.toggle()
                                        UserDefaults.standard.removeObject(forKey: "UserCalendar")
                                        day = 0
                                        timetable.removeAll()
                                        finalTimetable = ["Monday": [],"Tuesday": [], "Wednesday":[], "Thursday":[], "Friday":[]]
                                        image = nil
                                    }
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.red)
                                }
                            }
                            
                            
                        }else {
                            
                            
                            if(image != nil ){
                                if (day >= 5){
                                    NavigationLink(destination: TimeTable(finalTimetable: $finalTimetable).navigationBarHidden(true)){
                                        Text("Done")
                                            .frame(height: 200)
                                            .font(.title)
                                            .fontWeight(.bold)
                                    }.onAppear{
                                        UserDefaults.standard.set(finalTimetable, forKey: "UserCalendar")
                                    }
                                }else {
                                    Button(action: {self.imageCropper = true}){
                                        Text(Constants.days[day])
                                            .font(.title)
                                            .fontWeight(.semibold)
                                            .frame(height: 200)
                                    }
                                }
                                
                                Button("Reset"){
                                    UserDefaults.standard.removeObject(forKey: "UserCalendar")
                                    day = 0
                                    timetable.removeAll()
                                    finalTimetable = ["Monday": [],"Tuesday": [], "Wednesday":[], "Thursday":[], "Friday":[]]
                                    image = nil
                                }
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                                
                                
                                .sheet(isPresented: $imageCropper){
                                    ImageCropper(image: $image, visible: $showImageCropper, day: $day, imageArr: $imageArr, timetable: $timetable, imageCropper: $imageCropper, done: $done)
                                        .zIndex(10)
                                }
                                .onChange(of: timetable){ _ in
                                    if (timetable.isEmpty == false){
                                        for word in timetable[Constants.days[day-1]]!{
                                            //Regex expression for class code
                                            let courseCode = /^[A-Z]{2,5}\s[0-9]{2,4}/
                                            if let course = word!.firstMatch(of: courseCode){
                                                //Appending to dictionary with key being current weekday
                                                finalTimetable[Constants.days[self.day-1]]!.append(String(course.output))
                                            }
                                            //Regex expression single time i.e 8:30AM (sometimes time range is split into two lines hence vision will return two strings for one time range)
                                            let singleTime = /(?-)\s*[0-9]{0,2}:[0-9]{0,2}\s*[A-Za-z]{2}\s*(?-)/
                                            if let timing = word!.firstMatch(of: singleTime){
                                                finalTimetable[Constants.days[self.day-1]]!.append(String(timing.output))
                                            }
                                            //Regex expression for time range i.e 8:30AM - 9:30AM
                                            let timeRange = /\s*[0-9]{0,2}:[0-9]{0,2}\s*[A-Za-z]{2}\s*-\s*[0-9]{0,2}:[0-9]{0,2}\s*[A-Za-z]{2}/
                                            if let timing = word!.firstMatch(of: timeRange){
                                                finalTimetable[Constants.days[self.day-1]]!.append(String(timing.output))
                                            }
                                        }
                                    }
                                    
                                }
                            }else {
                                
                                Button(action: {self.show.toggle()}){
                                    Label("Select Calendar ", systemImage: "calendar.badge.plus")
                                        .font(.title)
                                        .fontWeight(.semibold)
                                        .frame(height: 550)
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
                                Button(action: {self.showTutorial.toggle()}){
                                    //Showing introduction/tutorial sheet
                                    Label("", systemImage: "questionmark.circle")
                                        .font(.title)
                                }
                            }
                            
                        }
                    }
                    
                }
                .background(.black)
                
            }.onAppear {
                if UserDefaults.standard.dictionary(forKey: "UserCalendar") is [String: [String]] {
                    self.userCalendar.toggle()
                } else {
                    self.showTutorial = true
                }
            }.sheet(isPresented: $showTutorial, content: {
                CalendarizeTutorial()
                
            })
            
        }
    }
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }
    
    
    
}

struct CalendarizeTutorial: View {
    @Environment(\.presentationMode) var presentationMode
    @State var step = 0
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text("Welcome to Calendarize")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding()
                Image(uiImage: UIImage(named: Constants.stepScreenshots[step])!)
                    .resizable()
                    .frame(width: 200, height: 400)
                Spacer()
                VStack{
                    Spacer()
                    Text("Step. \(step)")
                        .underline()
                        .fontWeight(.semibold)
                    Spacer()
                    Text("\(Constants.steps[step])")
                        .frame(width: 300)
                        .lineLimit(2)
                        .minimumScaleFactor(0.8)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                Spacer()
                HStack{
                    Button("Back"){
                        if (step > 0 ){
                            step -= 1
                        }
                    }
                    if (step == Constants.steps.count - 1) {
                        Button("Start"){
                            
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }else {
                        Button("Next"){
                            if (step < Constants.steps.count - 1 ){
                                step += 1
                            }
                        }
                    }
                    
                }
                .padding()
            }
        }
        
    }
}

