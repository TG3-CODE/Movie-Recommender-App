//
//  Movie.swift
//  TalluriGHW3
//
//  Created by Gayatri Talluri on 5/14/25.
//
import SwiftUI
struct Movie: Identifiable, Decodable {
    let id: Int
    let title: String
    let overview: String
    let poster_path: String?
}
struct MovieSearchResponse: Decodable {
    let results: [Movie]
}
