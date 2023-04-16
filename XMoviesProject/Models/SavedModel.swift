//
//  SavedModel.swift
//  XMoviesProject
//
//  Created by Denis on 4/7/23.
//

import Foundation

struct SavedMovie: Identifiable {
    var id = UUID()
    let isSavedMovie: Bool?
    let posterPath: String?
    let voteAverage: Double?
    let title: String?
    let name: String?
    let originalLanguage: String?
    let backdropPath: String?
    let overview: String?
    let releaseDate: String?
}
