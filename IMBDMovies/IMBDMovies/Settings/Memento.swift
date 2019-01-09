//
//  ConstantsUtil.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 30/11/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation


enum MementoEnum: String, PlistManager {
    
    static let plistName: String = "Memento"
    
    case language_changed
    case include_adult_value
    case query_value
    case api_key_param_value
    case language_param_value
    case last_page_number_value
    case current_page_number_value
    
}



struct Memento {
    
    
    static func movieTrailersURL(from movieID: Int) -> String {
        return UrlsEnum.api_main_url.getValue()         +
            EndpointsEnum.get_movie_trailer.getValue().replacingOccurrences(of: "<MOVIE-ID>", with: String(movieID), options: .literal, range: nil) +
            ParametersEnum.api_key_param.getValue()    +
            MementoEnum.api_key_param_value.getValue()
    }
    
    static func genresListURL() -> String {
        return UrlsEnum.api_main_url.getValue() +
            EndpointsEnum.get_genres_list.getValue() +
            ParametersEnum.api_key_param.getValue() +
            MementoEnum.api_key_param_value.getValue() +
            ParametersEnum.language_param.getValue() +
            MementoEnum.language_param_value.getValue()
    }
    
    static func upcomingMoviesURL() -> String {
        return UrlsEnum.api_main_url.getValue() +
            EndpointsEnum.get_upcoming_movies.getValue() +
            ParametersEnum.api_key_param.getValue() +
            MementoEnum.api_key_param_value.getValue() +
            ParametersEnum.language_param.getValue() +
            MementoEnum.language_param_value.getValue() +
            ParametersEnum.page_param.getValue() +
            MementoEnum.current_page_number_value.getValue()
    }
    
    
    static func searchMoviesURL() -> String {
        return UrlsEnum.api_main_url.getValue() +
            EndpointsEnum.get_search_movie.getValue() +
            ParametersEnum.api_key_param.getValue() +
            MementoEnum.api_key_param_value.getValue() +
            ParametersEnum.language_param.getValue() +
            MementoEnum.language_param_value.getValue() +
            ParametersEnum.page_param.getValue() +
            MementoEnum.current_page_number_value.getValue() +
            ParametersEnum.query_param.getValue() +
            MementoEnum.query_value.getValue() +
            ParametersEnum.include_adult_param.getValue() +
            MementoEnum.include_adult_value.getValue()
    }
    
    static func primaryTranslationsURL() -> String {
        return UrlsEnum.api_main_url.getValue() +
            EndpointsEnum.get_translates.getValue() +
            ParametersEnum.api_key_param.getValue() +
            MementoEnum.api_key_param_value.getValue()
    }
    
    static func countriesURL() -> String {
        return UrlsEnum.api_main_url.getValue() +
            EndpointsEnum.get_countries.getValue() +
            ParametersEnum.api_key_param.getValue() +
            MementoEnum.api_key_param_value.getValue()
    }
    
    static func languagesURL() -> String {
        return UrlsEnum.api_main_url.getValue() +
            EndpointsEnum.get_languages.getValue() +
            ParametersEnum.api_key_param.getValue() +
            MementoEnum.api_key_param_value.getValue()
    }
    
    
}
