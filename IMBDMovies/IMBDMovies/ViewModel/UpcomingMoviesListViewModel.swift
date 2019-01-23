//
import Foundation
//  UpcomingMoviesListViewModel.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 01/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//
import Unbox

protocol UpcomingMoviesListViewModelDelegate {
    func didLoadMoviesList()
    func didNotLoadMoviesList(message: String)
    func searchIsActive()
}

class UpcomingMoviesListViewModel {
    var upcomingMoviesListViewModelDelegate: UpcomingMoviesListViewModelDelegate?
    
    var moviesList = [Movie]()
    
    var tempMoviesList = [Movie]()
    
    func isLanguangeChanged() -> Bool {
        return !MementoEnum.languageChanged.getValue().isEmpty
    }
    
    func getUpcomingMovies() {
        fetchDataFromTMDB(by: Memento.upcomingMoviesURL())
        MementoEnum.languageChanged.setValue(value: "*")
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
            fetchDataFromTMDB(by: Memento.searchMoviesURL())
        }
    }
    
    private func formatSearchParam(value: String) {
        let formattedValue = value.replacingOccurrences(of: " ", with: "%20")
        MementoEnum.queryValue.setValue(value: formattedValue)
    }
    
    private func fetchDataFromTMDB(by url: String) {
        ServiceRequest.fetchData(endPointURL: url) { result in
            
            guard let movieData = result else {
                self.upcomingMoviesListViewModelDelegate?.didNotLoadMoviesList(message: "The movie database is not available.")
                return
            }
            
            //            do {
            //                let error: ErrorResponse = try unbox(dictionary: movieData as! UnboxableDictionary)
            //                self.upcomingMoviesListViewModelDelegate?.didNotLoadMoviesList(message: error.status_message)
            //                return
            //            } catch {}
            //
            do {
                let results = try JSONDecoder().decode(Result.self, from: movieData)
                
                MementoEnum.currentPageNumberValue.setValue(value: String(results.page))
                MementoEnum.lastPageNumberValue.setValue(value: String(results.totalPages))
                
                let cp = Int(MementoEnum.currentPageNumberValue.getValue()) ?? 0
                
                if cp == 1 {
                    self.moviesList.removeAll()
                }
                for movie in results.results {
                    self.moviesList.append(movie)
                }
                
                self.upcomingMoviesListViewModelDelegate?.didLoadMoviesList()
                
            } catch {
                print(error)
                self.upcomingMoviesListViewModelDelegate?.didNotLoadMoviesList(message: error.localizedDescription)
            }
        }
    }
    
    private func getMovie(from indexPath: IndexPath) -> Movie {
        return moviesList[indexPath.row]
    }
    
    private func getPosterUrl(posterPath: String?) -> String {
        if let poster = posterPath {
            return UrlsEnum.posterMainUrl.getValue() + poster
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
