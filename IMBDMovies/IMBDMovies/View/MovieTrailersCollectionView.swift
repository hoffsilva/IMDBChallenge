//
//  MovieTrailersCollectionView.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 02/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class MovieTrailersCollectionView: UICollectionViewController {
    
    let movieTrailerViewModel = MovieTrailerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTrailerViewModel.loadTrailers(from: 332562)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieTrailerViewModel.movieTrailers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieTrailerCell", for: indexPath) as! MovieTrailerCollectionViewCell
        guard let youtubeURL = URL(string: movieTrailerViewModel.getVideoURL(from: indexPath))
            else { return UICollectionViewCell() }
        cell.movieTrailerWebView.load(URLRequest(url: youtubeURL))
        return cell
    }
    
}

extension MovieTrailersCollectionView: MovieTrailerViewModelDelegate {
    
    func trailersLoaded() {
        collectionView.reloadData()
    }
    
    func trailersNotLoaded(message: String) {
        print(message)
    }
    
}