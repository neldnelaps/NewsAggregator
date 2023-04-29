//
//  NewApiTests.swift
//  NewsAggregatorTests
//
//  Created by Natalia Pashkova on 29.04.2023.
//

import XCTest
@testable import NewsAggregator

final class NewApiTests: XCTestCase {

    var sut: URLSession!
    private var apiNew: NewApiProtocol!

    override func setUpWithError() throws {
        try super.setUpWithError()
      
        sut = URLSession(configuration: .default)
        apiNew = NewApi()
    }

    override func tearDownWithError() throws {
        sut = nil
        apiNew = nil
        try super.tearDownWithError()
    }

    func testPerformanceExample() throws { self.measure { } }
    
    func testApiCallCompletes() throws {
      // given
      let urlString = "https://newsdata.io/api/1/news?apikey=pub_21221020bb9c580281896a2305077b7ffbe0f"
      let url = URL(string: urlString)!
      let promise = expectation(description: "Completion handler invoked")
      var statusCode: Int?
      var responseError: Error?

      // when
      let dataTask = sut.dataTask(with: url) { _, response, error in
        statusCode = (response as? HTTPURLResponse)?.statusCode
        responseError = error
        promise.fulfill()
      }
      dataTask.resume()
      wait(for: [promise], timeout: 5)

      // then
      XCTAssertNil(responseError)
      XCTAssertEqual(statusCode, 200)
    }
    
    func testGetNews() async {
        let news = (try? await apiNew.getNews()) ?? []
        XCTAssertEqual(news.count, 10)
    }

}
