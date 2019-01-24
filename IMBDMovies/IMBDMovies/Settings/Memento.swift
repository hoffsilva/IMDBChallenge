//
//  ConstantsUtil.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 30/11/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

enum Memento {
    static func movieTrailersURL(from movieID: Int) -> String {
        return UrlsEnum.apiMainUrl +
            EndpointsEnum.getMovieTrailer.replacingOccurrences(of: "<MOVIE-ID>", with: String(movieID), options: .literal, range: nil) +
            ParametersEnum.apiKeyParam +
            UserDefaultManager.get(valueFrom: UserDefaults.Keys.apiKeyParamValue)
    }
    
    static func genresListURL() -> String {
        return UrlsEnum.apiMainUrl +
            EndpointsEnum.getGenresList +
            ParametersEnum.apiKeyParam +
            UserDefaultManager.get(valueFrom: UserDefaults.Keys.apiKeyParamValue) +
            ParametersEnum.languageParam +
            UserDefaultManager.get(valueFrom: UserDefaults.Keys.languageParamValue)
    }
    
    static func upcomingMoviesURL() -> String {
        return UrlsEnum.apiMainUrl +
            EndpointsEnum.getUpcomingMovies +
            ParametersEnum.apiKeyParam +
            UserDefaultManager.get(valueFrom: UserDefaults.Keys.apiKeyParamValue) +
            ParametersEnum.languageParam +
            UserDefaultManager.get(valueFrom: UserDefaults.Keys.languageParamValue) +
            ParametersEnum.pageParam +
            UserDefaultManager.get(valueFrom: UserDefaults.Keys.currentPageNumberValue)
    }
    
    static func searchMoviesURL() -> String {
        return UrlsEnum.apiMainUrl +
            EndpointsEnum.getSearchMovie +
            ParametersEnum.apiKeyParam +
            UserDefaultManager.get(valueFrom: UserDefaults.Keys.apiKeyParamValue) +
            ParametersEnum.languageParam +
            UserDefaultManager.get(valueFrom: UserDefaults.Keys.languageParamValue) +
            ParametersEnum.pageParam +
            UserDefaultManager.get(valueFrom: UserDefaults.Keys.currentPageNumberValue) +
            ParametersEnum.queryParam +
            UserDefaultManager.get(valueFrom: UserDefaults.Keys.queryValue) +
            ParametersEnum.includeAdultParam +
            UserDefaultManager.get(valueFrom: UserDefaults.Keys.includeAdultValue)
    }
    
    static func primaryTranslationsURL() -> String {
        return UrlsEnum.apiMainUrl +
            EndpointsEnum.getTranslates +
            ParametersEnum.apiKeyParam +
            UserDefaultManager.get(valueFrom: UserDefaults.Keys.apiKeyParamValue)
    }
    
    static func countriesURL() -> String {
        return UrlsEnum.apiMainUrl +
            EndpointsEnum.getCountries +
            ParametersEnum.apiKeyParam +
            UserDefaultManager.get(valueFrom: UserDefaults.Keys.apiKeyParamValue)
    }
    
    static func languagesURL() -> String {
        return UrlsEnum.apiMainUrl +
            EndpointsEnum.getLanguages +
            ParametersEnum.apiKeyParam +
            UserDefaultManager.get(valueFrom: UserDefaults.Keys.apiKeyParamValue)
    }
}
