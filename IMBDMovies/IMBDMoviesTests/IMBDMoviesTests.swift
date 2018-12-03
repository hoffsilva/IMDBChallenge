//
//  IMBDMoviesTests.swift
//  IMBDMoviesTests
//
//  Created by Hoff Henry Pereira da Silva on 30/11/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import XCTest
import Unbox
import Alamofire
@testable import IMBDMovies

class IMBDMoviesTests: XCTestCase {
    
    let upcomingMoviesListViewModel = UpcomingMoviesListViewModel()
    var moviesQuantity = 20

    override func setUp() {
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceGetUpcomingMovies() {
        self.measure {
            let exp = expectation(description: "Server fetch")
            ServiceRequest.fetchData(endPointURL: ConstantsUtil.upcomingMoviesURL(), responseJSON: { (result) in
                exp.fulfill()
            })
            waitForExpectations(timeout: 100000, handler: { (error) in
                print(error?.localizedDescription ?? "Error")
            })
        }
    }
    
    func testGetUpcomingMovies() {
        ServiceRequest.fetchData(endPointURL: ConstantsUtil.upcomingMoviesURL()) { (result) in
            XCTAssertNotNil(result as! UnboxableDictionary)
        }
    }
    
    func testConnection() {
        XCTAssertTrue(Alamofire.NetworkReachabilityManager(host: "www.google.com")?.isReachable ?? false)
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
