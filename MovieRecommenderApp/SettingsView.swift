//
//  SettingsView.swift
//  TalluriGHW3
//
//  Created by Gayatri Talluri on 5/14/25.
//
import SwiftUI
struct SettingsView: View {
    @State private var notificationsEnabled = true
    @State private var volume = 0.5
    @AppStorage("username") var username: String = ""
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @AppStorage("loggedIn") var loggedIn: Bool = false
    @AppStorage("notificationMinutes") var notificationMinutes: Int = 30

    var body: some View {
        Form {
            Section(header: Text("Profile")) {
                HStack {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 60, height: 60)
                    Text(username.isEmpty ? "Your Name" : username)
                }
                Button("Logout") {
                    loggedIn = false
                }
                .foregroundColor(.red)
            }

            Section(header: Text("Preferences")) {
                Toggle("Enable Notifications", isOn: $notificationsEnabled)
                HStack {
                    Text("Volume")
                    Spacer()
                    Slider(value: $volume, in: 0...1, step: 0.1)
                        .frame(width: 150)
                }
                Picker("Notify Before", selection: $notificationMinutes) {
                    Text("30 mins").tag(30)
                    Text("5 mins").tag(5)
                }
                .pickerStyle(SegmentedPickerStyle())
                Toggle("Dark Mode", isOn: $isDarkMode)
            }
        }
        .navigationTitle("Settings")
        .sandalBackground()
    }
}
