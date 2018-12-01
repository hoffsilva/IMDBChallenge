//
//  UpcomingMoviesListTableView.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 01/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class UpcomingMoviesListTableView: UITableViewController {
    
    let upcomingMoviesListViewModel = UpcomingMoviesListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        upcomingMoviesListViewModel.upcomingMoviesListViewModelDelegate = self
        upcomingMoviesListViewModel.getUpcomingMovies()
    }
    
}


//MARK - Delegates and Datasources

extension UpcomingMoviesListTableView {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingMoviesListViewModel.moviesList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieItemCell", for: indexPath) as! UpcomingMovieItemTableViewCell
        cell.movieAverage.text = "\(upcomingMoviesListViewModel.getVoteAvegare(fromMovie: indexPath))"
        cell.movieBackdropPosterImageView.startAnimating()
        cell.movieBackdropPosterImageView.sd_setImage(with: URL(string: upcomingMoviesListViewModel.getBackdropPoster(fromMovie: indexPath))) { (image, error, cacheType, url) in
            if error == nil {
                cell.movieBackdropPosterImageView.image = image
                cell.movieBackdropPosterImageView.stopAnimating()
            }
        }
        cell.movieReleaseDate.text = ""
        cell.movieTitle.text = upcomingMoviesListViewModel.getTitle(fromMovie: indexPath)
        return cell
    }
    
}

extension UpcomingMoviesListTableView: UpcomingMoviesListViewModelDelegate {
    func didLoadMoviesList() {
        self.tableView.reloadData()
    }
    
    func didNotLoadMoviesList(message: String) {
        print("OOOps")
    }
    
    
}

