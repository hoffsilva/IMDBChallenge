//
//  Movie.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 30/11/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Unbox

struct Movie {
    
    let vote_count        : Int?
    let id                : Int?
    let video             : Bool?
    let vote_average      : Double?
    let title             : String?
    let popularity        : Double?
    let poster_path       : String?
    let original_language : String?
    let original_title    : String?
    let genre_ids         : [Int]?
    let backdrop_path     : String?
    let adult             : Bool?
    let overview          : String?
    let release_date      : String?
    
}

extension Movie: Unboxable {
    
    init(unboxer: Unboxer) throws {
        self.vote_count        = try? unboxer.unbox(key: "vote_count")
        self.id                = try? unboxer.unbox(key: "id" )
        self.video             = try? unboxer.unbox(key: "video")
        self.vote_average      = try? unboxer.unbox(key: "vote_average" )
        self.title             = try? unboxer.unbox(key: "title" )
        self.popularity        = try? unboxer.unbox(key: "popularity" )
        self.poster_path       = try? unboxer.unbox(key: "poster_path")
        self.original_language = try? unboxer.unbox(key: "original_language")
        self.original_title    = try? unboxer.unbox(key: "original_title")
        self.genre_ids         = try? unboxer.unbox(key: "genre_ids")
        self.backdrop_path     = try? unboxer.unbox(key: "backdrop_path")
        self.adult             = try? unboxer.unbox(key: "adult")
        self.overview          = try? unboxer.unbox(key: "overview")
        self.release_date      = try? unboxer.unbox(key: "release_date")
    }
    
}
