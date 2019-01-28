//
//  UpcomingMoviesListViewModel.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 01/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

protocol UpcomingMoviesListViewModelDelegate {
    func didLoadMoviesList()
    func didNotLoadMoviesList(message: String)
    func searchIsActive()
}

class UpcomingMoviesListViewModel {
    var upcomingMoviesListViewModelDelegate: UpcomingMoviesListViewModelDelegate?
    
    var moviesList = [Movie]() {
        didSet {
            upcomingMoviesListViewModelDelegate?.didLoadMoviesList()
        }
    }
    
    var tempMoviesList = [Movie]()
    
    func isLanguangeChanged() -> Bool {
        return !UserDefaultManager.get(valueFrom: UserDefaults.Keys.languageChanged).isEmpty
    }
    
    func getUpcomingMovies() {
        PerformRequest.upcomingMovies { [weak self] movies in
            guard let cp = Int(UserDefaultManager.get(valueFrom: UserDefaults.Keys.currentPageNumberValue)) else {
                return
            }
            
            if cp == 1 {
                self?.moviesList.removeAll()
            }
            
            self?.moviesList.append(contentsOf: movies)
            
        }
        UserDefaultManager.set(value: "*", key: UserDefaults.Keys.languageChanged)
    }
    
    func searchMovie(by searchParameter: String) {
        tempMoviesList = moviesList
        moviesList.removeAll()
        upcomingMoviesListViewModelDelegate?.searchIsActive()
        for movie in tempMoviesList {
            if movie.overview.contains(searchParameter) || movie.title.contains(searchParameter) {
                moviesList.append(movie)
            }
        }
        if moviesList.count > 0 {
            upcomingMoviesListViewModelDelegate?.didLoadMoviesList()
        } else {
            formatSearchParam(value: searchParameter)
            PerformRequest.searchUpcomingMoview { [weak self] movies in
                self?.moviesList = movies
            }
        }
    }
    
    private func formatSearchParam(value: String) {
        let formattedValue = value.replacingOccurrences(of: " ", with: "%20")
        UserDefaultManager.set(value: formattedValue, key: UserDefaults.Keys.queryValue)
    }
    
    
    private func getMovie(from indexPath: IndexPath) -> Movie {
        return moviesList[indexPath.row]
    }
    
    private func getPosterUrl(posterPath: String?) -> String {
        if let poster = posterPath {
            return UrlsEnum.posterMainUrl + poster
        } else {
            return ""
        }
    }
    
    private func unwrapValue<T>(value: T?) -> T {
        guard let unwrappedValue = value else {
            return T.self as! T
        }
        return unwrappedValue
    }
    
    func getVoteAvegare(fromMovie atIndexpath: IndexPath) -> Double {
        return unwrapValue(value: getMovie(from: atIndexpath).voteAverage)
    }
    
    func getTitle(fromMovie atIndexpath: IndexPath) -> String {
        return unwrapValue(value: getMovie(from: atIndexpath).title)
    }
    
    func getPoster(fromMovie atIndexpath: IndexPath) -> String {
        return unwrapValue(value: getPosterUrl(posterPath: getMovie(from: atIndexpath).posterPath))
    }
    
    func getGenreId(fromMovie atIndexpath: IndexPath) -> [Int] {
        return unwrapValue(value: getMovie(from: atIndexpath).genreIds)
    }
    
    func getBackdropPoster(fromMovie atIndexpath: IndexPath) -> String {
        return unwrapValue(value: getPosterUrl(posterPath: getMovie(from: atIndexpath).backdropPath))
    }
    
    func getOverview(fromMovie atIndexpath: IndexPath) -> String {
        return unwrapValue(value: getMovie(from: atIndexpath).overview)
    }
    
    func getReleaseDate(fromMovie atIndexpath: IndexPath) -> String {
        return unwrapValue(value: getMovie(from: atIndexpath).releaseDate)
    }
    
    func getMovieId(fromMovie atIndexpath: IndexPath) -> Int {
        return unwrapValue(value: getMovie(from: atIndexpath).id)
    }
}
