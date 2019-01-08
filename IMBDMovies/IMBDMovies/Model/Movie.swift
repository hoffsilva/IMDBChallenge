//
//  Movie.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 30/11/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Unbox

struct Movie: Codable {
    
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
    
    init(voteCount       : Int,
        id               : Int,
        video            : Bool,
        voteAverage      : Double,
        title            : String,
        popularity       : Double,
        posterPath       : String,
        originalLanguage : String,
        originalTitle    : String,
        genreIds         : [Int],
        backdropPath     : String,
        adult            : Bool,
        overview         : String,
        releaseDate      : String) {
         self.voteCount         = voteCount
         self.id                = id
         self.video             = video
         self.voteAverage       = voteAverage
         self.title             = title
         self.popularity        = popularity
         self.posterPath        = posterPath
         self.originalLanguage  = originalLanguage
         self.originalTitle     = originalTitle
         self.genreIds          = genreIds
         self.backdropPath      = backdropPath
         self.adult             = adult
         self.overview          = overview
         self.releaseDate       = releaseDate
    }

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
