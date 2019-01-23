//
//  Endpoints.swift
//  IMBDMovies
//
//  Created by Cast Group on 08/01/19.
//  Copyright © 2019 Hoff Henry Pereira da Silva. All rights reserved.
//

enum EndpointsEnum {
    static let plistName = "Endpoints"
    
    static let getUpcomingMovies = "/movie/upcoming"
    static let getSearchMovie = "/search/movie"
    static let getTranslates = "/configuration/primary_translations"
    static let getCountries = "/configuration/countries"
    static let getLanguages = "/configuration/languages"
    static let getMovieTrailer = "/movie/<MOVIE-ID>/videos"
    static let getGenresList = "/genre/movie/list"
}
