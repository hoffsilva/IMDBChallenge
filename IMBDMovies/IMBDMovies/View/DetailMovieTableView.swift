//
//  DetailMovieTableView.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 01/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import SDWebImage
import UIKit

class DetailMovieTableView: UITableViewController {
    var upcomingMovieListViewModel: UpcomingMoviesListViewModel!
    var genreListViewModel: GenreListViewModel!
    var movieTrailerViewModel = MovieTrailerViewModel()
    var movieTrailerCollectionView = MovieTrailersCollectionView()
    var collectionViewMovieTrailers: UICollectionView!
    var indexPath: IndexPath!
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var averageLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var genresListLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMovieParameters()
        navigationItem.backBarButtonItem?.title = ""
        movieTrailerViewModel.movieTrailerViewModelDelegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action: #selector(shareMovie))
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        loadView()
        setMovieParameters()
        containerView.addSubview(collectionViewMovieTrailers)
        containerView.didMoveToSuperview()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func setMovieParameters() {
        backgroundImageView.sd_addActivityIndicator()
        backgroundImageView.startAnimating()
        backgroundImageView.sd_setImage(with: URL(string: upcomingMovieListViewModel.getPoster(fromMovie: indexPath))) { image, error, _, _ in
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
        genresListLabel.text = genreListViewModel.getGenresListString(from: upcomingMovieListViewModel.getGenreId(fromMovie: indexPath))
        releaseDateLabel.text = upcomingMovieListViewModel.getReleaseDate(fromMovie: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination.isKind(of: MovieTrailersCollectionView.self) {
            (segue.destination as? MovieTrailersCollectionView)?.movieTrailerViewModel.loadTrailers(from: upcomingMovieListViewModel.getMovieId(fromMovie: indexPath))
            (segue.destination as? MovieTrailersCollectionView)?.movieTrailerViewModel.movieTrailerViewModelDelegate = self
            collectionViewMovieTrailers = (segue.destination as? MovieTrailersCollectionView)?.collectionView
            movieTrailerCollectionView = ((segue.destination as? MovieTrailersCollectionView).self)!
        }
    }
    
    @objc
    func shareMovie() {
        let message: String = " 🍿🥤 🍿🥤 Hello! I liked this movie. Would you like to watch it with me?. 🎟 🎟"
        let objectsToShare = URL(string: UrlsEnum.hostThemoviedbWeb.getValue() + String(upcomingMovieListViewModel.getMovieId(fromMovie: indexPath)))
        let sharedObjects: [AnyObject] = [objectsToShare as AnyObject, message as AnyObject]
        let activityViewController = UIActivityViewController(activityItems: sharedObjects, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = view
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook, UIActivity.ActivityType.postToTwitter, UIActivity.ActivityType.mail]
        present(activityViewController, animated: true, completion: nil)
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
