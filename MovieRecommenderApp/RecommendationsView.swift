//
//  RecommendationView.swift
//  TalluriGHW3
//
//  Created by Gayatri Talluri on 5/14/25.
//
import SwiftUI
struct RecommendationsView: View {
    @StateObject private var viewModel = MovieListViewModel()
    @State private var selectedGenre = "28" // Action by default

    let genres = [
        ("Action", "28"),
        ("Comedy", "35"),
        ("Drama", "18"),
        ("Horror", "27"),
        ("Science Fiction", "878")
    ]

    var body: some View {
        VStack {
            Picker("Genre", selection: $selectedGenre) {
                ForEach(genres, id: \.1) { genre in
                    Text(genre.0).tag(genre.1)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .onChange(of: selectedGenre) { newGenre in
                if let genreId = Int(newGenre) {
                    viewModel.fetchMoviesByGenre(genreId: genreId)
                }
            }

            List(viewModel.movies) { movie in
                NavigationLink(destination: MovieDetailView(movie: movie)) {
                    Text(movie.title)
                }
            }
        }
        .onAppear {
            viewModel.fetchMoviesByGenre(genreId: Int(selectedGenre) ?? 28)
        }
        .navigationTitle("Recommendations")
        .sandalBackground()
    }
}
