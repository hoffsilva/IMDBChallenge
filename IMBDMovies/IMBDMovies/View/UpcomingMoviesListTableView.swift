//
//  UpcomingMoviesListTableView.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 01/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import SDWebImage
import UIKit

class UpcomingMoviesListTableView: UITableViewController {
    let upcomingMoviesListViewModel = UpcomingMoviesListViewModel()
    let genresListViewModel = GenreListViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    var selectedIndex: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pleaseWait()
        configureSearchBar()
        addRefreshControl()
        upcomingMoviesListViewModel.upcomingMoviesListViewModelDelegate = self
        genresListViewModel.genresListViewModelDelegate = self
        genresListViewModel.loadGenresList()
        upcomingMoviesListViewModel.getUpcomingMovies()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.isHidden = false
        if upcomingMoviesListViewModel.isLanguangeChanged() {
            updateMoviesList()
        }
    }
}

// MARK: - Delegates and Datasources

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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieItemCell", for: indexPath) as? UpcomingMovieItemTableViewCell else {
            return UITableViewCell()
        }
        cell.movieAverage.text = "\(upcomingMoviesListViewModel.getVoteAvegare(fromMovie: indexPath))"
        cell.movieBackdropPosterImageView.sd_addActivityIndicator()
        cell.movieBackdropPosterImageView.startAnimating()
        cell.movieGenresLabel.text = genresListViewModel.getGenresListString(from: upcomingMoviesListViewModel.getGenreId(fromMovie: indexPath))
        cell.movieBackdropPosterImageView.sd_setImage(with: URL(string: upcomingMoviesListViewModel.getBackdropPoster(fromMovie: indexPath))) { image, error, _, _ in
            if error == nil {
                cell.movieNoPosterImageView.isHidden = true
                if let unwrappedImage = image {
                    cell.movieBackdropPosterImageView.image = unwrappedImage
                }
                cell.movieBackdropPosterImageView.stopAnimating()
            } else {
                cell.movieNoPosterImageView.isHidden = false
                cell.movieNoPosterImageView.image = #imageLiteral(resourceName: "logo_tmdb")
            }
        }
        cell.movieReleaseDate.text = upcomingMoviesListViewModel.getReleaseDate(fromMovie: indexPath)
        cell.movieTitle.text = upcomingMoviesListViewModel.getTitle(fromMovie: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let currentPage = Int(UserDefaultManager.get(valueFrom: UserDefaults.Keys.currentPageNumberValue)) else {
            return
        }
        guard let lastPage = Int(UserDefaultManager.get(valueFrom: UserDefaults.Keys.lastPageNumberValue)) else {
            return
        }
        if indexPath.row == upcomingMoviesListViewModel.moviesList.count - 1 {
            if currentPage <= lastPage {
                pleaseWait()
                UserDefaultManager.set(value: String(currentPage + 1), key: UserDefaults.Keys.currentPageNumberValue)
                upcomingMoviesListViewModel.getUpcomingMovies()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath
        performSegue(withIdentifier: "segueDetailMovie", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetailMovie" {
            guard let movieDetailView = segue.destination as? DetailMovieTableView else {
                return
            }
            movieDetailView.upcomingMovieListViewModel = upcomingMoviesListViewModel
            movieDetailView.genreListViewModel = genresListViewModel
            movieDetailView.indexPath = selectedIndex
        }
    }
    
    @IBAction func openLanguageTableView() {
        performSegue(withIdentifier: "segueLanguage", sender: self)
        tableView.isHidden = true
    }
}

extension UpcomingMoviesListTableView: UpcomingMoviesListViewModelDelegate {
    func didLoadMoviesList() {
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
        clearAllNotice()
    }
    
    func didNotLoadMoviesList(message: String) {
        clearAllNotice()
        tableView.refreshControl?.endRefreshing()
        noticeOnlyText(message)
    }
    
    func searchIsActive() {
        tableView.reloadData()
    }
}

extension UpcomingMoviesListTableView: GenresListViewModelDelegate {
    func didLoadGenresList() {
        print("Genres Ok")
    }
    
    func didNotLoadGenreList(message: String) {
        print("Genres not Ok.")
    }
}

extension UpcomingMoviesListTableView: UISearchControllerDelegate, UISearchBarDelegate {
    func configureSearchBar() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search movies..."
        searchController.searchBar.barStyle = .blackTranslucent
        searchController.searchBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        if upcomingMoviesListViewModel.moviesList.isEmpty {
            updateMoviesList()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if upcomingMoviesListViewModel.moviesList.isEmpty {
            updateMoviesList()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let isEmpty = searchBar.text?.isEmpty else {
            return
        }
        if !isEmpty {
            pleaseWait()
            upcomingMoviesListViewModel.searchMovie(by: searchBar.text!)
        }
    }
}

extension UpcomingMoviesListTableView {
    @objc
    func updateMoviesList() {
        pleaseWait()
        UserDefaultManager.set(value: String(1), key: UserDefaults.Keys.currentPageNumberValue)
        upcomingMoviesListViewModel.getUpcomingMovies()
    }
    
    func addRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Updating movies list", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        tableView.refreshControl?.addTarget(self, action: #selector(updateMoviesList), for: .valueChanged)
    }
}
