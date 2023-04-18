//
//  File.swift
//  
//
//  Created by Krish Vijayan on 2023-04-10.
//

import Foundation
import SwiftUI
import ShuffleDeck

struct TimeTable: View{
    @Binding var finalTimetable: [String: [String]]
    @State var curr = 0
    
    let days = [0,1,2,3,4]
    let gradients = [LinearGradient(colors: [.yellow, .orange],startPoint: .top, endPoint: .center),
                     LinearGradient(colors: [.orange, .red],startPoint: .top, endPoint: .center),
                     LinearGradient(colors: [.red, .purple],startPoint: .top, endPoint: .center),
                     LinearGradient(colors: [.purple, .indigo],startPoint: .top, endPoint: .center),
                     LinearGradient(colors: [.indigo, .green],startPoint: .top, endPoint: .center),
    ]
    var body: some View {
        ZStack{
            
            Circle()
                .frame(width: 400, height: 400)
                .foregroundStyle(gradients[curr])
                .blur(radius: 10.0)
                .position(x: 700, y: 100)
                .opacity(0.4)
            
            Circle()
                .frame(width: 400, height: 400)
                .foregroundStyle(gradients[curr])
                .blur(radius: 10.0)
                .position(x: 400, y: 900)
                .opacity(0.4)
            
            Circle()
                .frame(width: 1200, height: 1000)
                .opacity(0.4)
                .foregroundColor(.black)
            
            VStack{
                Text(Constants.weekdays[curr])
                    .font(.system(size: 50))
                    .fontWeight(.semibold)
                    .foregroundStyle(gradients[curr])
                
                ZStack{
                    
                    
                    ShuffleDeck(
                        days,
                        initialIndex: 0
                    ) { day in
                        
                        Text("")
                            .frame(width: 300, height: 500)
                            .background(
                                gradients[day]
                            )
                            .cornerRadius(30)        
                    }
                    .onShuffleDeck { (context: ShuffleDeckContext) in
                        curr = context.index
                    }
                    .shadow(radius: 10)
                    
                    VStack{
                        ForEach(Array(finalTimetable[Constants.weekdays[curr]]!.enumerated()), id:\.offset){ index, course in
                            //Reading next two indicies to get time range for class
                            let startIndex = index + 1
                            let endIndex = index + 2
                            //Reading class code
                            if let courseCode = course.first, courseCode.isLetter {
                                //Making sure current index has 1 or 2 indices after it
                                let startTime = startIndex < finalTimetable[Constants.weekdays[curr]]!.count ? finalTimetable[Constants.weekdays[curr]]![startIndex] : "?"
                                let endTime = endIndex < finalTimetable[Constants.weekdays[curr]]!.count ? finalTimetable[Constants.weekdays[curr]]![endIndex] : "?"
                                if (endTime.contains("-")){
                                    Weekday(gradient:  gradients[curr], course: course, timeFrame: "\(startTime.first!.isLetter ? "Time not found" : endTime)")
                                        .onTapGesture{
                                            print(course)
                                        }
                                    
                                }else {
                                    Weekday(gradient:  gradients[curr], course: course, timeFrame: "\(startTime.first!.isLetter ? "?" : startTime) - \(endTime.first!.isLetter ? "?" : endTime)")
                                        .onTapGesture{
                                            print(course)
                                        }
                                    
                                }
                            }
                        }
                    }
                }
            }
            
        }
        .background(.black)
    }
    
    
    
}

struct Circle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.addEllipse(in: CGRect(x: 0.00028*width, y: 0.00028*height, width: 0.9985*width, height: 0.9985*height))
        return path
    }
    static func circle(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, foregroundStyle: LinearGradient) -> any View {
        var body: some View  {
            Circle()
                .frame(width: width, height: height)
                .foregroundStyle(foregroundStyle)
                .position(x: x, y: y)
        }
        return body
    }
}

struct Weekday: View {
    let gradient: LinearGradient
    let course: String
    let timeFrame: String
    
    init(gradient: LinearGradient, course: String, timeFrame: String){
        self.gradient = gradient
        self.course = course
        self.timeFrame = timeFrame
    }
    let colors = [Color.yellow.opacity(0.7), Color.orange, Color.red, Color.purple, Color.indigo]
    var body: some View  {
        HStack{
            Text(course)
            Text(timeFrame)
            
        }
        .fontWeight(.semibold)
        .frame(width: 270, height: 60)
        .background(gradient)
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
        .shadow(radius: 8.0)
        .padding(1)
    }
    
}
