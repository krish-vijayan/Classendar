//
//  CalendarizeApp.swift
//  Calendarize
//
//  Created by Krish Vijayan on 2023-04-07.
//

import SwiftUI

@main
struct CalendarizeApp: App {
    @State var finalTimetable: [String: [String]] = ["Monday": [],"Tuesday": [], "Wednesday":[], "Thursday":[], "Friday":[] ]
    var body: some Scene {
        WindowGroup {
            HomeView()
//            TimeTable(finalTimetable: $finalTimetable)
        }
    }
}
