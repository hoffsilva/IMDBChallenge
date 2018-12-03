//
//  IMBDMoviesTests.swift
//  IMBDMoviesTests
//
//  Created by Hoff Henry Pereira da Silva on 30/11/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import XCTest
@testable import IMBDMovies

class IMBDMoviesTests: XCTestCase {
    
    let upcomingMoviesListViewModel = UpcomingMoviesListViewModel()
    var moviesQuantity = 20

    override func setUp() {
        upcomingMoviesListViewModel.upcomingMoviesListViewModelDelegate = self
        upcomingMoviesListViewModel.getUpcomingMovies()
        moviesQuantity = upcomingMoviesListViewModel.moviesList.count
        upcomingMoviesListViewModel.upcomingMoviesListViewModelDelegate?.didLoadMoviesList()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformance() {
        self.measure {
            upcomingMoviesListViewModel.getUpcomingMovies()
        }
    }
    
    func testGetMovies() {
        
        XCTAssertEqual(20, moviesQuantity)
        testPerformance()
    }

}

extension IMBDMoviesTests: UpcomingMoviesListViewModelDelegate {
    func didLoadMoviesList() {
        moviesQuantity = upcomingMoviesListViewModel.moviesList.count
        print(moviesQuantity)
    }
    
    func didNotLoadMoviesList(message: String) {
        
    }
    
    func searchIsActive() {
        
    }
    
    
}
