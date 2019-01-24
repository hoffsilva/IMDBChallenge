//
//  GereListViewModel.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 04/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Unbox

protocol GenresListViewModelDelegate {
    func didLoadGenresList()
    func didNotLoadGenreList(message: String)
}

class GenreListViewModel {
    var genresListViewModelDelegate: GenresListViewModelDelegate!
    
    var genresList = [Genre]()
    
    func loadGenresList() {
        ServiceRequest.fetchData(endPointURL: Memento.genresListURL()) { result in
            guard let unwrappedResult = result else {
                return
            }
            
            do {
                let error: ErrorResponse = try JSONDecoder().decode(ErrorResponse.self, from: unwrappedResult)
                self.genresListViewModelDelegate.didNotLoadGenreList(message: error.statusMessage)
                return
            } catch {}
            
            do {
                let genresList: GenresList = try JSONDecoder().decode(GenresList.self, from: unwrappedResult)
                guard let unwrappedGenresList = genresList.genres else {
                    return
                }
                self.genresList = unwrappedGenresList
                self.genresListViewModelDelegate.didLoadGenresList()
            } catch {
                self.genresListViewModelDelegate.didNotLoadGenreList(message: error.localizedDescription)
                print(error)
            }
        }
    }
    
    func getGenresListString(from genresListID: [Int]) -> String {
        var genresListString = ""
        for genreID in genresListID {
            for genre in genresList {
                if genreID == (genre.id) {
                    genresListString += "\(genre.name), "
                }
            }
        }
        
        if genresListString.suffix(2) == ", " {
            genresListString.removeLast()
            genresListString.removeLast()
        }
        return genresListString
    }
}
