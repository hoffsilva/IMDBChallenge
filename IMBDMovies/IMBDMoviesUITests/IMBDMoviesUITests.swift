//
//  IMBDMoviesUITests.swift
//  IMBDMoviesUITests
//
//  Created by Hoff Henry Pereira da Silva on 30/11/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import XCTest

class IMBDMoviesUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testChangeLanguageInPortrait() {
        
        changeLanguage(by: UIDeviceOrientation.portrait)
        
    }
    
    func testChangeLanguageInLandscape() {
        
        changeLanguage(by: UIDeviceOrientation.landscapeLeft)
        
    }
    
    func changeLanguage(by orientation: UIDeviceOrientation) {
        XCUIDevice.shared.orientation = orientation
        app.navigationBars["Upcoming Movies"].buttons["Language"].tap()
        app.tables.staticTexts["DEUTSCH - Germany"].tap()
        app.buttons["YES"].tap()
    }

}
