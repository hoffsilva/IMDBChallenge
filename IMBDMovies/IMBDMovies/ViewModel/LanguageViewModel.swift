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
    
    private func treatResponse(result: Any?) {
        
        guard let resultFromApi = result as? UnboxableDictionary else {
            self.langaugeViewModelDelegate?.didNotLoadLanguages(message: "The movie database is not available.")
            return
        }
        
        do {
            let error: ErrorResponse = try unbox(dictionary: resultFromApi)
            self.langaugeViewModelDelegate?.didNotLoadLanguages(message: error.status_message)
            return
        } catch {
            print(error.localizedDescription)
            return
        }
    }
    
    func getPrimaryTranslations() {
        ServiceRequest.fetchData(endPointURL: ConstantsUtil.primaryTranslationsURL()) { (result) in
        
            if let resultFromApi = result as? UnboxableDictionary {
                
                do {
                    let error: ErrorResponse = try unbox(dictionary: resultFromApi)
                    self.langaugeViewModelDelegate?.didNotLoadLanguages(message: error.status_message)
                    return
                } catch {
                    print(error.localizedDescription)
                    return
                }
        
            } else if let array = result as? Array<String> {
                self.primaryTranslations = array
                self.langaugeViewModelDelegate?.didLoadPrimaryTranslations()
            } else {
                self.langaugeViewModelDelegate?.didNotLoadLanguages(message: "The movie database is not available.")
                return
            }
            
        }
    }
    
    func getCountries() {
        ServiceRequest.fetchData(endPointURL: ConstantsUtil.countriesURL()) { (result) in
            
           self.treatResponse(result: result)
            
            do {
                let countries : [Country] = try unbox(dictionaries: result as! [UnboxableDictionary])
                self.contries = countries
                self.langaugeViewModelDelegate?.didLoadCountries()
            } catch {
                print(error)
                self.langaugeViewModelDelegate?.didNotLoadLanguages(message: error.localizedDescription)
            }
        }
    }
    
    func getLanguages() {
        ServiceRequest.fetchData(endPointURL: ConstantsUtil.languagesURL()) { (result) in
            
            self.treatResponse(result: result)
            
            do {
                let languages : [Language] = try unbox(dictionaries: result as! [UnboxableDictionary])
                self.languages = languages
                self.langaugeViewModelDelegate?.didLoadLanguages()
            } catch {
                print(error)
                self.langaugeViewModelDelegate?.didNotLoadLanguages(message: error.localizedDescription)
            }
        }
    }
    
    func getTranslations() {
        for primary_translation in primaryTranslations {
            var translation = Translation(language: "", name: "", code: "", country: "")
            let countryString   = String(describing: primary_translation.suffix(2))
            let lang      = String(describing: primary_translation.prefix(2))
            for language in languages {
                if language.iso_639_1 == lang {
                    translation.name     = language.name ?? language.english_name ?? ""
                    translation.language = language.iso_639_1 ?? ""
                    translation.code = language.iso_639_1 ?? ""
                }
            }
            for country in contries {
                if country.iso_3166_1 == countryString {
                    translation.country = country.english_name ?? ""
                    translation.code.append("-\(country.iso_3166_1 ?? "")")
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
        return getTranslation(by: indexPath).name
    }
    
    func getTranslationCountry(by indexPath: IndexPath) -> String {
        return getTranslation(by: indexPath).country
    }
    
    func setDefaulTranslation(by indexPath: IndexPath) {
        ConstantsUtil.setLanguageValue(language: getTranslation(by: indexPath).code)
        ConstantsUtil.setLanguageChanged(value: "")
    }
    
    func selectedLanguage() -> String {
        return ConstantsUtil.getLanguageValue()
    }
    
    func isSelectedLanguage(by indexPath: IndexPath) -> Bool {
        return getTranslation(by: indexPath).code == selectedLanguage()
    }
    
    func isLanguageChanged() -> Bool {
        return ConstantsUtil.isLanguageChanged()
    }

}


