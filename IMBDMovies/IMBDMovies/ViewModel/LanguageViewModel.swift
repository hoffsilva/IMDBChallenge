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
    
    var primaryTranslations = [String]()
    
    var contries = [Country]()
    
    var languages = [Language]()
    
    var translations = [Translation]()
    
    @discardableResult private func treatResponse(result: Data?) -> Data {
        guard let resultFromApi = result else {
            langaugeViewModelDelegate?.didNotLoadLanguages(message: "The movie database is not available.")
            return Data()
        }
        
        do {
            let error: ErrorResponse = try JSONDecoder().decode(ErrorResponse.self, from: resultFromApi)
            langaugeViewModelDelegate?.didNotLoadLanguages(message: error.statusMessage)
            return Data()
        } catch {
            print(error.localizedDescription)
            return resultFromApi
        }
    }
    
    func getPrimaryTranslations() {
        ServiceRequest.fetchData(endPointURL: Memento.primaryTranslationsURL()) { result in
            
            let data = self.treatResponse(result: result)
            let str = String(decoding: data, as: UTF8.self)
            let arrayOfStrings = str.split(separator: ",").map {
                $0.replacingOccurrences(of: "[", with: "")
                    .replacingOccurrences(of: "\"", with: "")
                    .replacingOccurrences(of: "]", with: "")
            }
            self.primaryTranslations = arrayOfStrings
            self.langaugeViewModelDelegate?.didLoadPrimaryTranslations()
        }
    }
    
    func getCountries() {
        ServiceRequest.fetchData(endPointURL: Memento.countriesURL()) { result in
            
            let countriesData = self.treatResponse(result: result)
            
            do {
                let countries: [Country] = try JSONDecoder().decode([Country].self, from: countriesData)
                self.contries = countries
                self.langaugeViewModelDelegate?.didLoadCountries()
            } catch {
                print(error)
                self.langaugeViewModelDelegate?.didNotLoadLanguages(message: error.localizedDescription)
            }
        }
    }
    
    func getLanguages() {
        ServiceRequest.fetchData(endPointURL: Memento.languagesURL()) { result in
            
            let languageData = self.treatResponse(result: result)
            
            do {
                let languages: [Language] = try JSONDecoder().decode([Language].self, from: languageData)
                self.languages = languages
                self.langaugeViewModelDelegate?.didLoadLanguages()
            } catch {
                print(error)
                self.langaugeViewModelDelegate?.didNotLoadLanguages(message: error.localizedDescription)
            }
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
                if country.iso3166 == countryString {
                    translation.country = country.englishName
                    translation.code.append("-\(country.iso3166)")
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
        MementoEnum.languageParamValue.setValue(value: getTranslation(by: indexPath).code ?? "No name")
        MementoEnum.languageChanged.setValue(value: "")
    }
    
    func selectedLanguage() -> String {
        return MementoEnum.languageParamValue.getValue()
    }
    
    func isSelectedLanguage(by indexPath: IndexPath) -> Bool {
        return getTranslation(by: indexPath).code == selectedLanguage()
    }
    
    func isLanguageChanged() -> Bool {
        return !MementoEnum.languageChanged.getValue().isEmpty
    }
}
