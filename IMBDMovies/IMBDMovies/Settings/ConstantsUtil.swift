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
    
    static func getPageParam() -> String {
        return String(getValue(from: "page_param"))
    }
    
    static func getLanguageParam() -> String {
        return String(getValue(from: "language_param"))
    }
    
    static func getLanguageValue() -> String {
        return String(getValue(from: "language_param_value"))
    }
    
    static func getPosterMainUrl() -> String {
        return String(getValue(from: "poster_main_url"))
    }
    
    static func getApiMainUrl() -> String {
        return String(getValue(from: "api_main_url"))
    }
    
    static func getApiKeyParam() -> String {
        return String(getValue(from: "api_key_param"))
    }
    
    static func getApiKeyValue() -> String {
        return String(getValue(from: "api_key_param_value"))
    }
    
    static func getUpcomingMoviesPath() -> String {
        return String(getValue(from: "GET_UPCOMING_MOVIES"))
    }
    
    static func getSearchMoviesPath() -> String {
        return String(getValue(from: "GET_SEARCH_MOVIES"))
    }
    
    static func getTranslatesPath() -> String {
        return String(getValue(from: "GET_TRANSLATES"))
    }
    
    static func getCountriesPath() -> String {
        return String(getValue(from: "GET_COUNTRIES"))
    }
    
    static func getLanguagesPath() -> String {
        return String(getValue(from: "GET_LANGUAGES"))
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
    
    static func setLanguageValue(langauge: String) {
        set(value: langauge, into: "language_param_value")
    }

    
}
