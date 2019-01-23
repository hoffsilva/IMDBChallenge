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
    func searchIsActive()
}




class UpcomingMoviesListViewModel {
    
    var upcomingMoviesListViewModelDelegate: UpcomingMoviesListViewModelDelegate?
    
    var moviesList = [Movie]()
    
    var tempMoviesList = [Movie]()
    
    func isLanguangeChanged() -> Bool {
        return !MementoEnum.language_changed.getValue().isEmpty
    }
    
    func  getUpcomingMovies() {
        fetchDataFromTMDB(by: Memento.upcomingMoviesURL())
        MementoEnum.language_changed.setValue(value: "*")
    }
    
    func searchMovie(by searchParameter: String) {
        tempMoviesList = moviesList
        moviesList.removeAll()
        self.upcomingMoviesListViewModelDelegate?.searchIsActive()
        for movie in tempMoviesList {
            if movie.overview.contains(searchParameter) || movie.title.contains(searchParameter) {
                moviesList.append(movie)
            }
        }
        if moviesList.count > 0 {
            self.upcomingMoviesListViewModelDelegate?.didLoadMoviesList()
        } else {
            formatSearchParam(value: searchParameter)
            fetchDataFromTMDB(by: Memento.searchMoviesURL())
        }
    }
    
    private func formatSearchParam(value: String) {
        let formattedValue = value.replacingOccurrences(of: " ", with: "%20")
        MementoEnum.query_value.setValue(value: formattedValue)
    }
    
    
    private func fetchDataFromTMDB(by url: String) {
        
        ServiceRequest.fetchData(endPointURL: url) { (result) in
            
            guard let movieData = result else {
                self.upcomingMoviesListViewModelDelegate?.didNotLoadMoviesList(message: "The movie database is not available.")
                return
            }
            
            do {
                let error: ErrorResponse = try unbox(dictionary: movieData as! UnboxableDictionary)
                self.upcomingMoviesListViewModelDelegate?.didNotLoadMoviesList(message: error.status_message)
                return
            } catch {}
            
            do {
                let results: Result = try unbox(dictionary: movieData as! UnboxableDictionary)
                
                guard let currentPageNumber = results.page else {
                    self.upcomingMoviesListViewModelDelegate?.didNotLoadMoviesList(message: "Could not load movie data.")
                    return
                }
                MementoEnum.current_page_number_value.setValue(value: String(currentPageNumber))
                
                guard let lastPageNumber = results.total_pages else {
                    self.upcomingMoviesListViewModelDelegate?.didNotLoadMoviesList(message: "Could not load movie data.")
                    return
                }
                MementoEnum.last_page_number_value.setValue(value: String(lastPageNumber))
                
                guard let movies = results.results else {
                    self.upcomingMoviesListViewModelDelegate?.didNotLoadMoviesList(message: "Could not load movie data.")
                    return
                }
                
                let cp = Int(MementoEnum.current_page_number_value.getValue()) ?? 0
                
                if cp == 1 {
                    self.moviesList.removeAll()
                }
                for movie in movies {
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
    
    private func getPosterUrl(poster_path: String?) -> String {
        if let poster = poster_path {
           return UrlsEnum.poster_main_url.getValue() + poster
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
    
    func getReleaseDate(fromMovie atIndexpath: IndexPath) -> String {
        return unwrapValue(value: getMovie(from: atIndexpath).release_date)
    }
    
    func getMovieId(fromMovie atIndexpath: IndexPath) -> Int {
        return unwrapValue(value: getMovie(from: atIndexpath).id)
    }
}
