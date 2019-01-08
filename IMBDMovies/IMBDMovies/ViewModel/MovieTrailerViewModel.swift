//
//  MovieTrailerViewModel.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 02/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Unbox

protocol MovieTrailerViewModelDelegate {
    func trailersLoaded()
    func trailersNotLoaded(message: String)
}

class MovieTrailerViewModel {
    
    var movieTrailerViewModelDelegate: MovieTrailerViewModelDelegate!
    
    var movieTrailers = [MovieTrailer]()
    
    func loadTrailers(from movieID: Int) {
        ServiceRequest.fetchData(endPointURL: Memento.movieTrailersURL(from: movieID)) { (result) in
            
            guard let movieTrailer = result as? UnboxableDictionary else {
                return
            }
            
            do {
                let error: ErrorResponse = try unbox(dictionary: movieTrailer)
                self.movieTrailerViewModelDelegate.trailersNotLoaded(message: error.status_message)
                return
            } catch {}
            
            do {
                let resultMovieTrailers : ResultsMovieTrailer = try unbox(dictionary: movieTrailer)
                self.movieTrailers = resultMovieTrailers.results
                self.movieTrailerViewModelDelegate.trailersLoaded()
            } catch {
                self.movieTrailerViewModelDelegate.trailersNotLoaded(message: error.localizedDescription)
                print(error)
            }
        }
    }
    
    func getVideoURL(from video: IndexPath) -> String {
        return UrlsEnum.host_trailer_url.getValue() + String( movieTrailers[video.row].key)
    }
}
