//
//  Movie.swift
//  Movies
//

import Foundation

struct Movie: Decodable {

    let title: String
    let poster: String
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500/\(poster)")!
    }

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case poster = "poster_path"
    }
}
