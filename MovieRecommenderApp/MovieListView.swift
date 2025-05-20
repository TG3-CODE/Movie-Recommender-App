//
//  MovieListView.swift
//  TalluriGHW3
//
//  Created by Gayatri Talluri on 5/14/25.
//

import SwiftUI
struct MovieListView: View {
    @StateObject private var viewModel = MovieListViewModel()
    @State private var query = ""

    var body: some View {
        VStack {
            TextField("Search for movies...", text: $query, onCommit: {
                viewModel.searchMovies(query: query)
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()

            List {
                ForEach(viewModel.movies) { movie in
                    NavigationLink {
                        MovieDetailView(movie: movie)
                    } label: {
                        // Safe rendering of movie title with nil/empty check
                        Text(movie.title.isEmpty ? "Untitled Movie" : movie.title)
                            .lineLimit(1)  // Prevent multi-line rendering issues
                    }
                }
            }
        }
        .navigationTitle("Movies")
        .sandalBackground()
    }
}

class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    let apiKey = "ea480eb2e94df2b30366053a61b252ff"
    let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlYTQ4MGViMmU5NGRmMmIzMDM2NjA1M2E2MWIyNTJmZiIsIm5iZiI6MTc0NzYxMzAxNy4yNzgsInN1YiI6IjY4MmE3NTU5YTkyNmU3NDU2OTViNTdjMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.3DZFt_4MrGlOieGeCtduFsv1kdAX3tWpQkiIIaXUXtk"

    func searchMovies(query: String) {
        guard !query.isEmpty,
              let queryEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://api.themoviedb.org/3/search/movie?query=\(queryEncoded)")
        else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching movies: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(MovieSearchResponse.self, from: data)
                DispatchQueue.main.async {
                    // Filter out any movies with problematic titles
                    self.movies = decoded.results.filter { movie in
                        return !movie.title.isEmpty
                    }
                }
            } catch {
                print("Error decoding: \(error.localizedDescription)")
            }
        }.resume()
    }

    func fetchMoviesByGenre(genreId: Int) {
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?with_genres=\(genreId)") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching movies: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(MovieSearchResponse.self, from: data)
                DispatchQueue.main.async {
                    // Filter out any movies with problematic titles
                    self.movies = decoded.results.filter { movie in
                        return !movie.title.isEmpty
                    }
                }
            } catch {
                print("Error decoding: \(error.localizedDescription)")
            }
        }.resume()
    }
}
