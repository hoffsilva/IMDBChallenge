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
        ServiceRequest.fetchData(endPointURL: ConstantsUtil.genresListURL()) { (result) in
            guard let unwrappedResult = result as? UnboxableDictionary else {
                return
            }
            
            do {
                let error: ErrorResponse = try unbox(dictionary: unwrappedResult)
                self.genresListViewModelDelegate.didNotLoadGenreList(message: error.status_message)
                return
            } catch {}
            
            do {
                let genresList : GenresList = try unbox(dictionary: unwrappedResult)
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
                if genreID == (genre.id ?? -1) {
                    genresListString = "\(genre.name ?? ""), "
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
