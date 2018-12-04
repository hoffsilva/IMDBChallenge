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
        setMovieParameters()
        navigationItem.backBarButtonItem?.title = ""
        movieTrailerViewModel.movieTrailerViewModelDelegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action: #selector(shareMovie))
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        loadView()
        setMovieParameters()
        movieTrailerViewModel.loadTrailers(from: upcomingMovieListViewModel.getMovieId(fromMovie: indexPath) )
        tableView.reloadData()
        collectionViewMovieTrailers.reloadInputViews()
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
    
    @objc
    func shareMovie() {
        let message:String = " 🍿🥤 🍿🥤 Hello! I liked this movie. Would you like to watch it with me?. 🎟 🎟"
        let objectsToShare = URL(string: ConstantsUtil.getHostThemoviedbWeb() + "\(upcomingMovieListViewModel.getMovieId(fromMovie: indexPath))")
        let sharedObjects:[AnyObject] = [objectsToShare as AnyObject, message as AnyObject]
        let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook,UIActivity.ActivityType.postToTwitter,UIActivity.ActivityType.mail]
        self.present(activityViewController, animated: true, completion: nil)
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
