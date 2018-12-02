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
        ServiceRequest.fetchData(endPointURL: ConstantsUtil.movieTrailersURL(from: movieID)) { (result) in
            do {
                let resultMovieTrailers : ResultsMovieTrailer = try unbox(dictionary: result as! UnboxableDictionary)
                self.movieTrailers = resultMovieTrailers.results
                //self.movieTrailerViewModelDelegate.trailersLoaded()
            } catch {
                self.movieTrailerViewModelDelegate.trailersNotLoaded(message: error.localizedDescription)
                print(error)
            }
        }
    }
    
    func getVideoURL(from video: IndexPath) -> String {
        return ConstantsUtil.hostTrailerURL(from: movieTrailers[video.row].key)
    }
}
