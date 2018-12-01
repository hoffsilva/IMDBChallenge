//
//  Movie.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 30/11/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Unbox

struct Movie {
    
    let vote_count        : Int!
    let id                : Int!
    let video             : Bool!
    let vote_average      : Double!
    let title             : String!
    let popularity        : Double!
    let poster_path       : String!
    let original_language : String!
    let original_title    : String!
    let genre_ids         : [Int]!
    let backdrop_path     : String!
    let adult             : Bool!
    let overview          : String!
    let release_date      : String!
    
    init(vote_count        : Int,
         id                : Int,
         video             : Bool,
         vote_average      : Double,
         title             : String,
         popularity        : Double,
         poster_path       : String,
         original_language : String,
         original_title    : String,
         genre_ids         : [Int],
         backdrop_path     : String,
         adult             : Bool,
         overview          : String,
         release_date      : String) {
         self.vote_count        = vote_count
         self.id                = id
         self.video             = video
         self.vote_average      = vote_average
         self.title             = title
         self.popularity        = popularity
         self.poster_path       = poster_path
         self.original_language = original_language
         self.original_title    = original_title
         self.genre_ids         = genre_ids
         self.backdrop_path     = backdrop_path
         self.adult             = adult
         self.overview          = overview
         self.release_date      = release_date
    }
    
//    init( ) {
//        self.init(vote_count: 0, id: 0, video: false, vote_average: 0, title: "", popularity: 0, poster_path: "", original_language: "", original_title: "", genre_ids: [], backdrop_path: "", adult: false, overview: "", release_date: "")
//    }
}

extension Movie: Unboxable {
    
    init(unboxer: Unboxer) throws {
        self.vote_count        = unboxer.unbox(key: "vote_count")
        self.id                = unboxer.unbox(key: "id" )
        self.video             = unboxer.unbox(key: "video")
        self.vote_average      = unboxer.unbox(key: "vote_average" )
        self.title             = unboxer.unbox(key: "title" )
        self.popularity        = unboxer.unbox(key: "popularity" )
        self.poster_path       = unboxer.unbox(key: "poster_path")
        self.original_language = unboxer.unbox(key: "original_language")
        self.original_title    = unboxer.unbox(key: "original_title")
        self.genre_ids         = unboxer.unbox(key: "genre_ids")
        self.backdrop_path     = unboxer.unbox(key: "backdrop_path")
        self.adult             = unboxer.unbox(key: "adult")
        self.overview          = unboxer.unbox(key: "overview")
        self.release_date      = unboxer.unbox(key: "release_date")
    }
    
}
