//
//  MovieDetailView.swift
//  TalluriGHW3
//
//  Created by Gayatri Talluri on 5/14/25.
//
import SwiftUI
struct MovieDetailView: View {
    let movie: Movie

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.largeTitle)
                    .bold()
                Text(movie.overview)
                    .padding(.top)

                if let posterPath = movie.poster_path,
                   let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
                    AsyncImage(url: url) { image in
                        image.resizable()
                             .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 300)
                }
            }
            .padding()
        }
        .navigationTitle("Details")
        .sandalBackground()
    }
}
