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
    @Binding var finalTimetable: [String: [[String]]]
    
    //    AngularGradient(gradient: Gradient(colors: [.green, .blue, .black, .green, .blue, .black, .green]), center: .center)
    let days = [0,1,2,3,4]
    let gradients = [LinearGradient(colors: [.yellow, .orange],startPoint: .top, endPoint: .center),
                     LinearGradient(colors: [.orange, .red],startPoint: .top, endPoint: .center),
                     LinearGradient(colors: [.red, .purple],startPoint: .top, endPoint: .center),
                     LinearGradient(colors: [.purple, .indigo],startPoint: .top, endPoint: .center),
                     LinearGradient(colors: [.indigo, .green],startPoint: .top, endPoint: .center),
    ]
    var weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    @State var curr = 0
    @State var offSet = 100
    var body: some View {
        ZStack{
            
            Monday()
                .frame(width: 400, height: 400)
                .foregroundStyle(gradients[curr])
                .blur(radius: 10.0)
                .position(x: 700, y: 100)
                .opacity(0.4)
            
            Monday()
                .frame(width: 400, height: 400)
                .foregroundStyle(gradients[curr])
                .blur(radius: 10.0)
                .position(x: 400, y: 900)
                .opacity(0.4)
            
            //            Color.white.ignoresSafeArea().blur(radius: 1000.0)
            Monday()
                .frame(width: 1000, height: 1000)
                .opacity(0.4)
                .foregroundColor(.black)
            
            VStack{
                Text(weekdays[curr])
                    .font(.system(size: 50))
                    .fontWeight(.semibold)
                    .foregroundStyle(gradients[curr])
                
                ZStack{
                    
                    
                    ShuffleDeck(
                        days,
                        initialIndex: 0
                    ) { day in
                        
                        
                        //                    VStack{
                        //
                        //                        Weekday(gradient:  gradients[day], course: "course", timeFrame: "8:30AM-9:30AM")
                        //                        Weekday(gradient:  gradients[day], course: "course", timeFrame: "8:30AM-9:30AM")
                        //                        Weekday(gradient:  gradients[day], course: "course", timeFrame: "8:30AM-9:30AM")
                        //                        Weekday(gradient:  gradients[day], course: "course", timeFrame: "8:30AM-9:30AM")
                        //
                        //                    }
                        
                        Text("")
                            .frame(width: 300, height: 500)
                            .background(
                                gradients[day]
                            )
                            .cornerRadius(30)
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                    }
                    .onShuffleDeck { (context: ShuffleDeckContext) in
                        /* some stuff */
                        curr = context.index
                    }
                    .shadow(radius: 10)
                    
                    VStack{
                        ForEach(finalTimetable[weekdays[curr]]![0], id:\.self){ course in
                            Weekday(gradient:  gradients[curr], course: course, timeFrame: "8:30AM-9:30AM")
                        }
                    }
                }
            }
            
        }
    }
    
    
    
}
//struct TimeTable_Previews: PreviewProvider {
//    static var previews: some View {
//        TimeTable()
//    }
//}
struct Monday: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.addEllipse(in: CGRect(x: 0.00028*width, y: 0.00028*height, width: 0.9985*width, height: 0.9985*height))
        return path
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
        .fontWeight(.light)
        .frame(width: 250, height: 70)
        .background(gradient)
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
        .shadow(radius: 8.0)
        .padding(10)
    }
    
}
struct ListView: View {
    let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    
    var body: some View {
        List(items, id: \.self) { item in
            Text(item)
        }
    }
}
