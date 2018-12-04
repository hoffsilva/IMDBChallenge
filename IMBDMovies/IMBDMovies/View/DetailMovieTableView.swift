//
//  DetailMovieTableView.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 01/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage


class DetailMovieTableView: UITableViewController {
    
    
    var upcomingMovieListViewModel: UpcomingMoviesListViewModel!
    var movieTrailerViewModel = MovieTrailerViewModel()
    var collectionViewMovieTrailers: UICollectionView!
    var indexPath: IndexPath!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTrailerViewModel.movieTrailerViewModelDelegate = self
        setMovieParameters()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func setMovieParameters() {
        backgroundImageView.sd_addActivityIndicator()
        backgroundImageView.startAnimating()
        print(upcomingMovieListViewModel.getPoster(fromMovie: indexPath))
        backgroundImageView.sd_setImage(with: URL(string: upcomingMovieListViewModel.getPoster(fromMovie: indexPath))) { (image, error, cache, url) in
            if error == nil {
                self.backgroundImageView.image = image
            } else {
                self.backgroundImageView.image = #imageLiteral(resourceName: "logo_tmdb")
            }
            self.backgroundImageView.stopAnimating()
        }
        titleLabel.text = upcomingMovieListViewModel.getTitle(fromMovie: indexPath)
        averageLabel.text = "\(upcomingMovieListViewModel.getVoteAvegare(fromMovie: indexPath))"
        overviewLabel.text = upcomingMovieListViewModel.getOverview(fromMovie: indexPath)
        releaseDateLabel.text = upcomingMovieListViewModel.getReleaseDate(fromMovie: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination.isKind(of: MovieTrailersCollectionView.self) {
            (segue.destination as? MovieTrailersCollectionView)?.movieTrailerViewModel.loadTrailers(from: upcomingMovieListViewModel.getMovieId(fromMovie: indexPath))
            (segue.destination as? MovieTrailersCollectionView)?.movieTrailerViewModel.movieTrailerViewModelDelegate = self
            collectionViewMovieTrailers = (segue.destination as? MovieTrailersCollectionView)?.collectionView
        }
    }
}

extension DetailMovieTableView: MovieTrailerViewModelDelegate {
    func trailersLoaded() {
        collectionViewMovieTrailers.reloadData()
    }
    
    func trailersNotLoaded(message: String) {
        noticeOnlyText(message)
    }
    
    
}
