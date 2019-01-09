//
//  Movie.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 30/11/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

struct Movie: Decodable {
    
    let voteCount        : Int!
    let id                : Int!
    let video             : Bool!
    let voteAverage      : Double!
    let title             : String!
    let popularity        : Double!
    let posterPath       : String!
    let originalLanguage : String!
    let originalTitle    : String!
    let genreIds         : [Int]!
    let backdropPath     : String!
    let adult             : Bool!
    let overview          : String!
    let releaseDate      : String!

}

extension Movie {
    enum CodingKeys: String, CodingKey {
        case id, video, title, popularity, adult, overview
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIds = "genre_ids"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
    }
}
