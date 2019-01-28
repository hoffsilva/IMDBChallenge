//
//  PerformRequest.swift
//  IMBDMovies
//
//  Created by Cast Group on 28/01/19.
//  Copyright © 2019 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation


//chama o metodo desta classe, depois ele carrega dos dados passa para a vm, depois a vm informa a view passando os dados.

enum PerformRequest {
    
    // MARK - Movies
    
    static func upcomingMovies( _ completion: @escaping ([Movie]) -> Void) {
        JSONDecoder().decode(Result.self, url: Memento.upcomingMoviesURL()) { result in
            UserDefaultManager.set(value: String(result.page), key: UserDefaults.Keys.currentPageNumberValue)
            UserDefaultManager.set(value: String(result.totalPages), key: UserDefaults.Keys.lastPageNumberValue)
            completion(result.results)
        }
    }
    
    static func searchUpcomingMoview(_ completion: @escaping ([Movie]) -> Void) {
        JSONDecoder().decode(Result.self, url: Memento.searchMoviesURL()) { result in
            completion(result.results)
        }
    }
    
    // MARK - Languages
    
    static func primaryTranslations(_ completion: @escaping ([String]) -> Void) {
        JSONDecoder().decode([String].self, url: Memento.primaryTranslationsURL()) { result in
            completion(result)
        }
    }
    
    static func countries(_ completion: @escaping ([Country]) -> Void) {
        JSONDecoder().decode([Country].self, url: Memento.countriesURL()) { countries in
            completion(countries)
        }
    }
    
    static func languages(_ completion: @escaping ([Language]) -> Void) {
        JSONDecoder().decode([Language].self, url: Memento.languagesURL()) { languages in
            completion(languages)
        }
    }
    
}
