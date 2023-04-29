//
//  NewsAggregatorUITests.swift
//  NewsAggregatorUITests
//
//  Created by Natalia Pashkova on 26.04.2023.
//

import XCTest
@testable import NewsAggregator

final class NewsAggregatorUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        let title = app.staticTexts["News"]
        XCTAssertTrue(title.exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
}
