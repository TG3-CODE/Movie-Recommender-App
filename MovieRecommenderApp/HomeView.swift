//
//  HomeView.swift
//  TalluriGHW3
//
//  Created by Gayatri Talluri on 5/14/25.
//
import SwiftUI

@main
struct MovieNightPlannerApp: App {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @AppStorage("loggedIn") var loggedIn: Bool = false
    @AppStorage("notificationMinutes") var notificationMinutes: Int = 30

    @StateObject var store = EventStore()

    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
    }

    var body: some Scene {
        WindowGroup {
            if loggedIn {
                HomeView()
                    .environmentObject(store) 
                    .preferredColorScheme(isDarkMode ? .dark : .light)
            } else {
                LoginView()
                    .environmentObject(store)
            }
        }
    }
}
extension View {
    func sandalBackground() -> some View {
        self.background(Color(red: 1.0, green: 0.94, blue: 0.84)) // sandal color
    }
}
struct HomeView: View {
    @AppStorage("username") var username: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome, \(username)")
                    .font(.title)
                    .padding()
                NavigationLink("Browse Movies", destination: MovieListView())
                NavigationLink("Recommended by Genre", destination: RecommendationsView())
                NavigationLink("Plan an Event", destination: EventPlanningView())
                NavigationLink("Listed Events", destination: EventListView())
                NavigationLink("Settings", destination: SettingsView())
            }
            .padding()
            
        }
        .sandalBackground()
    }
}
