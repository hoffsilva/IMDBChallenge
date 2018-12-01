//
//  UpcomingMoviesListViewModel.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 01/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//
import Unbox
import Foundation

protocol UpcomingMoviesListViewModelDelegate {
    func didLoadMoviesList()
    func didNotLoadMoviesList(message: String)
}

class UpcomingMoviesListViewModel {
    
    var upcomingMoviesListViewModelDelegate: UpcomingMoviesListViewModelDelegate?
    
    var moviesList = [Movie]()
    
    func getUpcomingMovies() {
        let url = ConstantsUtil.getApiMainUrl() +
                  ConstantsUtil.getUpcomingMoviesPath() +
                  ConstantsUtil.getApiKeyParam() +
                  ConstantsUtil.getApiKeyValue() +
                  ConstantsUtil.getLanguageParam() +
                  ConstantsUtil.getLanguageValue() +
                  ConstantsUtil.getPageParam() +
                  "\(ConstantsUtil.getCurrentPageNumber())"
        ServiceRequest.fetchData(endPointURL: url) { (result) in
            do {
                let results: Result = try unbox(dictionary: result)
                
                guard let currentPageNumber = results.page else {
                    return
                }
                ConstantsUtil.setCurrentPageNumber(currentPageNumber: currentPageNumber)
                
                guard let lastPageNumber = results.total_pages else {
                    return
                }
                ConstantsUtil.setLastPageNumber(lastPageNumber: lastPageNumber)
                
                guard let movies = results.results else {
                    return
                }
                
                for movie in movies {
                    self.moviesList.append(movie)
                }
        
                self.upcomingMoviesListViewModelDelegate?.didLoadMoviesList()
                
            } catch {
                print(error)
                self.upcomingMoviesListViewModelDelegate?.didNotLoadMoviesList(message: error.localizedDescription)
                return
            }
        }
    }
    
    private func getMovie(from indexPath: IndexPath) -> Movie {
        return moviesList[indexPath.row]
    }
    
    private func getPosterUrl(poster_path: String?) -> String {
        let poster = poster_path ?? "https://vignette.wikia.nocookie.net/simpsons/images/6/60/No_Image_Available.png"
        return ConstantsUtil.getPosterMainUrl() + poster
    }
    
    private func unwrapValue<T>(value: T?) -> T {
        guard let unwrappedValue = value else {
            return T.self as! T
        }
        print(unwrappedValue)
        return unwrappedValue
    }
    
    func getVoteAvegare(fromMovie atIndexpath: IndexPath) -> Double {
        return unwrapValue(value: getMovie(from: atIndexpath).vote_average)
    }
    
    func getTitle(fromMovie atIndexpath: IndexPath) -> String {
        return unwrapValue(value: getMovie(from: atIndexpath).title)
    }
    
    func getPoster(fromMovie atIndexpath: IndexPath) -> String {
        return unwrapValue(value: getPosterUrl(poster_path: getMovie(from: atIndexpath).poster_path))
    }
    
    func getGenreId(fromMovie atIndexpath: IndexPath) -> [Int] {
        return unwrapValue(value: getMovie(from: atIndexpath).genre_ids)
    }
    
    func getBackdropPoster(fromMovie atIndexpath: IndexPath) -> String {
        return unwrapValue(value: getPosterUrl(poster_path: getMovie(from: atIndexpath).backdrop_path))
    }
    
    func getOverview(fromMovie atIndexpath: IndexPath) -> String {
        return unwrapValue(value: getMovie(from: atIndexpath).overview)
    }
}
