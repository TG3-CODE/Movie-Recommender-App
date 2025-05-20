//
//  EventPlanningView.swift
//  TalluriGHW3
//
//  Created by Gayatri Talluri on 5/14/25.
//
import SwiftUI
struct MovieEvent: Identifiable, Codable {
    let id = UUID()
    let eventName: String
    let movieName: String
    let date: Date
    let time: Date
}

class EventStore: ObservableObject {
    @Published var events: [MovieEvent] = []

    func add(event: MovieEvent, notifyIn minutes: Int) {
        events.append(event)

        let eventDate = Calendar.current.date(bySettingHour: Calendar.current.component(.hour, from: event.time),
                                              minute: Calendar.current.component(.minute, from: event.time),
                                              second: 0,
                                              of: event.date) ?? event.date

        let notifyDate = Calendar.current.date(byAdding: .minute, value: -minutes, to: eventDate) ?? eventDate

        let content = UNMutableNotificationContent()
        content.title = "Upcoming Movie Night!"
        content.body = "Don't miss \(event.eventName) for \(event.movieName)"
        content.sound = .default

        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: notifyDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: event.id.uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}

struct EventPlanningView: View {
    @EnvironmentObject var store: EventStore
    
    @State private var eventName = ""
    @State private var movieName = ""
    @State private var selectedDate = Date()
    @State private var selectedTime = Date()
    @State private var attendees = 1
    @State private var eventNote = ""
    @State private var showAlert = false

    var body: some View {
        Form {
            Section(header: Text("Event Info")) {
                TextField("Event Name", text: $eventName)
                TextField("Movie Name", text: $movieName)
                DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                DatePicker("Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                Stepper("Attendees: \(attendees)", value: $attendees, in: 1...20)
                TextEditor(text: $eventNote)
                    .frame(height: 100)
            }

            Button("Save Event") {
                // Create and save the event
                let newEvent = MovieEvent(
                    eventName: eventName,
                    movieName: movieName,
                    date: selectedDate,
                    time: selectedTime
                )
                
                // Add the event to the store with notification
                store.add(event: newEvent, notifyIn: 30)
                
                // Show confirmation
                showAlert = true
                
                // Reset fields
                eventName = ""
                movieName = ""
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Event Saved"), message: Text("Event \(eventName) on \(selectedDate, style: .date) saved."), dismissButton: .default(Text("OK")))
            }
        }
        .navigationTitle("Plan Event")
        .sandalBackground()
    }
}
