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
    
    var exp: XCTestExpectation!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceGetUpcomingMovies() {
        self.measure {
            exp = expectation(description: "Upcoming movies fetch")
            VerifyConnection.fetchData(endPointURL: ConstantsUtil.upcomingMoviesURL(), responseJSON: { (result) in
                self.exp.fulfill()
            })
            self.wait()
        }
    }
    
    func testGetUpcomingMovies() {
        exp = expectation(description: "Get upcoming movies")
        VerifyConnection.fetchData(endPointURL: ConstantsUtil.upcomingMoviesURL()) { (result) in
            XCTAssertTrue(result is UnboxableDictionary)
            self.exp.fulfill()
        }
        wait()
    }
    
    
    func testGetSearchMovie() {
        ConstantsUtil.setQueryValue(value: "avengers")
        exp = expectation(description: "Search movie by parameter")
        VerifyConnection.fetchData(endPointURL: ConstantsUtil.searchMoviesURL()) { (result) in
            XCTAssertTrue(result is UnboxableDictionary)
            self.exp.fulfill()
        }
        wait()
    }
    
    func testQueryValue() {
        XCTAssertEqual("avengers", ConstantsUtil.getQueryValue())
    }
    
    func testGetPrimaryTranslations() {
        exp = expectation(description: "Primary Translations")
        VerifyConnection.fetchData(endPointURL: ConstantsUtil.primaryTranslationsURL()) { (result) in
            XCTAssertTrue(result is Array<String>)
            self.exp.fulfill()
        }
        wait()
    }
    
    func testGetCountries() {
        exp = expectation(description: "Countries")
        VerifyConnection.fetchData(endPointURL: ConstantsUtil.countriesURL()) { (result) in
            XCTAssertTrue(result is Array<UnboxableDictionary>)
            self.exp.fulfill()
        }
        wait()
    }
    
    func testGetLanguages() {
        exp = expectation(description: "Languages")
        VerifyConnection.fetchData(endPointURL: ConstantsUtil.languagesURL()) { (result) in
            XCTAssertTrue(result is Array<UnboxableDictionary>)
            self.exp.fulfill()
        }
        wait()
    }
    
    func testConnection() {
        XCTAssertTrue(Alamofire.NetworkReachabilityManager(host: "www.google.com")?.isReachable ?? false)
    }

}

extension IMBDMoviesTests {
    
    func wait() {
        waitForExpectations(timeout: 10) { (error) in
            print(error?.localizedDescription ?? "Error")
        }
    }
    
}
