//
//  UsecaseTests.swift
//  NewsAggregatorTests
//
//  Created by Natalia Pashkova on 01.05.2023.
//

@testable import NewsAggregator
import XCTest

final class UsecaseTests: XCTestCase {

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

    func testPerformanceExample() throws { self.measure { } }
    
    func testLoadNewsUsecase_getNews() async throws {
        // given
        var сount = 10
        let useсase = LoadNewsUsecase(newsRepository: NewsRepository())
        
        // when
        let news = await useсase.getNews()
        
        // then
        XCTAssertEqual(news.count, сount)
    }
    
    func testNewDetailsUsecase_addGetNews() throws {
        // given
        var сount = 1
        let useсase = NewDetailsUsecase(realmRepository: RealmRepository(), realmGetRepository: RealmGetRepository())
        let new = New()
        new.title = "Title"
        new.resDescription = "Description"
        
        // when
        useсase.addNew(new: new)
        let news = useсase.getNews()
        
        // then
        XCTAssertEqual(news.count, сount)
        XCTAssertEqual(news[0].resDescription, "Description")
    }

}
