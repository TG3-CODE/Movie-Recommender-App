//
//  EventListView.swift
//  TalluriGHW3
//
//  Created by Gayatri Talluri on 5/14/25.
//
import SwiftUI

struct EventListView: View {
    @EnvironmentObject var store: EventStore

    var body: some View {
        List(store.events) { event in
            VStack(alignment: .leading) {
                Text(event.eventName).font(.headline)
                Text("Movie: \(event.movieName)")
                Text("Date: \(event.date, style: .date), Time: \(event.time, style: .time)")
            }
            .padding(.vertical, 4)
        }
        .navigationTitle("Listed Events")
        .sandalBackground()
    }
}
