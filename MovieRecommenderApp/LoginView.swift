//
//  LoginView.swift
//  TalluriGHW3
//
//  Created by Gayatri Talluri on 5/14/25.
//
import SwiftUI
struct LoginView: View {
    @AppStorage("username") var username: String = ""
    @State private var password: String = ""
    @AppStorage("loggedIn") var loggedIn: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Login to Movie Night Planner")
                .font(.title2)

            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            Button("Login") {
                if !username.isEmpty && !password.isEmpty {
                    loggedIn = true
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .sandalBackground()
    }
}
