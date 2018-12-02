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
}

class LanguageViewModel {
    
    var langaugeViewModelDelegate: LangaugeViewModelDelegate?
    
    var primaryTranslations = [String]()
    
    var contries = [Country]()
    
    var languages = [Language]()
    
    var translations = [Translation]()
    
    func getPrimaryTranslations() {
        ServiceRequest.fetchData(endPointURL: ConstantsUtil.primaryTranslationsURL()) { (result) in
            self.primaryTranslations = result as! Array
            self.langaugeViewModelDelegate?.didLoadPrimaryTranslations()
        }
    }
    
    func getCountries() {
        ServiceRequest.fetchData(endPointURL: ConstantsUtil.countriesURL()) { (result) in
            do {
                let countries : [Country] = try unbox(dictionaries: result as! [UnboxableDictionary])
                self.contries = countries
                self.langaugeViewModelDelegate?.didLoadCountries()
            } catch {
                print(error)
            }
        }
    }
    
    func getLanguages() {
        ServiceRequest.fetchData(endPointURL: ConstantsUtil.languagesURL()) { (result) in
            do {
                let languages : [Language] = try unbox(dictionaries: result as! [UnboxableDictionary])
                self.languages = languages
                self.langaugeViewModelDelegate?.didLoadLanguages()
            } catch {
                print(error)
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
    
    func setDefaulTranslation(by indexPath: IndexPath) {
        ConstantsUtil.setLanguageValue(language: getTranslation(by: indexPath).code)
    }
    
}


