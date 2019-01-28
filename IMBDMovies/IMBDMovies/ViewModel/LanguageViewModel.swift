//
//  DetailMovieViewModel.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 01/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Unbox

protocol LangaugeViewModelDelegate {
    func didLoadPrimaryTranslations()
    func didLoadLanguages()
    func didLoadCountries()
    func didLoadTranslations()
    func didNotLoadLanguages(message: String)
}

class LanguageViewModel {
    var langaugeViewModelDelegate: LangaugeViewModelDelegate?
    
    var primaryTranslations = [String]() {
        didSet {
            langaugeViewModelDelegate?.didLoadPrimaryTranslations()
        }
    }
    
    var contries = [Country]() {
        didSet {
            langaugeViewModelDelegate?.didLoadCountries()
        }
    }
    
    var languages = [Language]() {
        didSet {
            langaugeViewModelDelegate?.didLoadLanguages()
        }
    }
    
    var translations = [Translation]()
    
    func getPrimaryTranslations() {
        PerformRequest.primaryTranslations() { [weak self] response in
            self?.primaryTranslations = response
        }
    }
    
    func getCountries() {
        PerformRequest.countries { [weak self] countries in
            self?.contries = countries
        }
    }
    
    func getLanguages() {
        PerformRequest.languages { [weak self] languages in
            self?.languages = languages
        }
    }
    
    func getTranslations() {
        for primaryTranslation in primaryTranslations {
            var translation = Translation()
            let countryString = String(describing: primaryTranslation.suffix(2))
            let lang = String(describing: primaryTranslation.prefix(2))
            for language in languages {
                if language.iso == lang {
                    translation.name = language.name ?? language.englishName ?? ""
                    translation.language = language.iso ?? ""
                    translation.code = language.iso ?? ""
                }
            }
            for country in contries {
                if country.iso == countryString {
                    translation.country = country.englishName
                    translation.code.append("-\(country.iso)")
                }
            }
            print(translation)
            translations.append(translation)
        }
        langaugeViewModelDelegate?.didLoadTranslations()
    }
    
    func getTranslation(by indexPtah: IndexPath) -> Translation {
        return translations[indexPtah.row]
    }
    
    func getTranslationName(by indexPath: IndexPath) -> String {
        return getTranslation(by: indexPath).name ?? "No Name"
    }
    
    func getTranslationCountry(by indexPath: IndexPath) -> String {
        return getTranslation(by: indexPath).country ?? "No Name"
    }
    
    func setDefaulTranslation(by indexPath: IndexPath) {
        guard let translationCode = getTranslation(by: indexPath).code else {
            return
        }
        UserDefaultManager.set(value: translationCode, key: UserDefaults.Keys.languageParamValue)
        UserDefaultManager.set(value: "*", key: UserDefaults.Keys.languageChanged)
    }
    
    func selectedLanguage() -> String {
        return UserDefaultManager.get(valueFrom: UserDefaults.Keys.languageParamValue)
    }
    
    func isSelectedLanguage(by indexPath: IndexPath) -> Bool {
        return getTranslation(by: indexPath).code == selectedLanguage()
    }
    
    func isLanguageChanged() -> Bool {
        return !UserDefaultManager.get(valueFrom: UserDefaults.Keys.languageChanged).isEmpty
    }
}
