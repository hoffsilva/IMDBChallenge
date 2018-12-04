//
//  ConstantsUtil.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 30/11/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import SwiftyPlistManager

struct ConstantsUtil {
    
    fileprivate static let constants = "Constants"
    
    //MARK - Get methods
    
    fileprivate static func getFile() -> SwiftyPlistManager {
        return SwiftyPlistManager.shared
    }
    
    fileprivate static func getValue(from key: String) -> String {
        guard let value = getFile().fetchValue(for: key, fromPlistWithName: constants) else {
            return "Value not found from key \(key)"
        }
        return "\(value)"
    }
    
    static func getLastPageNumber() -> Int {
        guard let value = Int(getValue(from: "last_page_number")) else {
            return -1
        }
        return value
    }
    
    static func getCurrentPageNumber() -> Int {
        guard let value = Int(getValue(from: "current_page_number")) else {
            return -1
        }
        return value
    }
    
    private static func getQueryParam() -> String {
        return String(getValue(from: "query_param"))
    }
    
    static func getQueryValue() -> String {
        return String(getValue(from: "query_value"))
    }
    
    private static func getAdultParam() -> String {
        return String(getValue(from: "include_adult_param"))
    }
    
    private static func getAdultValue() -> Bool {
        return Bool(getValue(from: "include_adult_value")) ?? false
    }
    
    private static func getPageParam() -> String {
        return String(getValue(from: "page_param"))
    }
    
    private static func getLanguageParam() -> String {
        return String(getValue(from: "language_param"))
    }
    
    static func getLanguageValue() -> String {
        return String(getValue(from: "language_param_value"))
    }
    
    static func getPosterMainUrl() -> String {
        return String(getValue(from: "poster_main_url"))
    }
    
    private static func getApiMainUrl() -> String {
        return String(getValue(from: "api_main_url"))
    }
    
    private static func getApiKeyParam() -> String {
        return String(getValue(from: "api_key_param"))
    }
    
    private static func getApiKeyValue() -> String {
        return String(getValue(from: "api_key_param_value"))
    }
    
    private static func getUpcomingMoviesPath() -> String {
        return String(getValue(from: "GET_UPCOMING_MOVIES"))
    }
    
    private static func getSearchMoviesPath() -> String {
        return String(getValue(from: "GET_SEARCH_MOVIES"))
    }
    
    private static func getTranslatesPath() -> String {
        return String(getValue(from: "GET_TRANSLATES"))
    }
    
    private static func getCountriesPath() -> String {
        return String(getValue(from: "GET_COUNTRIES"))
    }
    
    private static func getLanguagesPath() -> String {
        return String(getValue(from: "GET_LANGUAGES"))
    }
    
    static func getHostThemoviedbWeb() -> String {
        return String(getValue(from: "host_themoviedb_web"))
    }
    
    static func getGenreListPath() -> String {
        return String(getValue(from: "GET_GENRES_LIST"))
    }
    
    static func isLanguageChanged() -> Bool {
        return Bool(getValue(from: "language_changed").isEmpty)
    }
    
    static func hostTrailerURL(from key: String) -> String {
        return String(getValue(from:"host_trailer_url") + key)
    }
    
    static func movieTrailersURL(from movieID: Int) -> String {
        return getApiMainUrl() +
               getValue(from: "GET_MOVIE_TRAILERS").replacingOccurrences(of: "<MOVIE-ID>", with: "\(movieID)", options: .literal, range: nil) +
               getApiKeyParam() +
               getApiKeyValue()
    }
    
    static func genresListURL() -> String {
        return getApiMainUrl() +
               getGenreListPath() +
               getApiKeyParam() +
               getApiKeyValue() +
               getLanguageParam() +
               getLanguageValue()
    }
    
    static func upcomingMoviesURL() -> String {
            return getApiMainUrl() +
                   getUpcomingMoviesPath() +
                   getApiKeyParam() +
                   getApiKeyValue() +
                   getLanguageParam() +
                   getLanguageValue() +
                   getPageParam() +
                   "\(getCurrentPageNumber())"
    }
    
    
    static func searchMoviesURL() -> String {
        return getApiMainUrl() +
               getSearchMoviesPath() +
               getApiKeyParam() +
               getApiKeyValue() +
               getLanguageParam() +
               getLanguageValue() +
               getPageParam() +
               "\(getCurrentPageNumber())" +
               getQueryParam() +
               getQueryValue() +
               getAdultParam() +
               "\(getAdultValue())"
    }
    
    static func primaryTranslationsURL() -> String {
        return getApiMainUrl() +
               getTranslatesPath() +
               getApiKeyParam() +
               getApiKeyValue()
    }
    
    static func countriesURL() -> String {
        return getApiMainUrl() +
               getCountriesPath() +
               getApiKeyParam() +
               getApiKeyValue()
    }
    
    static func languagesURL() -> String {
        return getApiMainUrl() +
               getLanguagesPath() +
               getApiKeyParam() +
               getApiKeyValue()
    }
    
    
    //MARK - Set methods
    
    private static func set<T>(value: T, into key: String) {
        getFile().save(value, forKey: key, toPlistWithName: constants, completion: { (error) in
            if error != nil {
                print("The value \(value) could not be saved into the key \(key) with the error \(String(describing: error))")
            }
        })
    }
    
    static func setLastPageNumber(lastPageNumber: Int) {
        set(value: lastPageNumber, into: "last_page_number")
    }
    
    static func setCurrentPageNumber(currentPageNumber: Int) {
        set(value: currentPageNumber, into: "current_page_number")
    }
    
    static func setLanguageValue(language: String) {
        set(value: language, into: "language_param_value")
    }
    
    static func setQueryValue(value: String) {
        set(value: value, into: "query_value")
    }
    
    static func setAdultValue(value: Bool) {
        set(value: value, into: "include_adult_value")
    }
    
    static func setLanguageChanged(value: String) {
        set(value: value, into: "language_changed")
    }

    
}
