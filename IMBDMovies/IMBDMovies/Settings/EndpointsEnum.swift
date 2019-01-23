//
//  Endpoints.swift
//  IMBDMovies
//
//  Created by Cast Group on 08/01/19.
//  Copyright © 2019 Hoff Henry Pereira da Silva. All rights reserved.
//

enum EndpointsEnum: String, PlistManager {
    
    static let plistName = "Endpoints"
    
    case get_upcoming_movies
    case get_search_movie
    case get_translates
    case get_countries
    case get_languages
    case get_movie_trailer
    case get_genres_list
}
