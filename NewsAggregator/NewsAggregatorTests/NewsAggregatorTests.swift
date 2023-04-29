//
//  NewsAggregatorTests.swift
//  NewsAggregatorTests
//
//  Created by Natalia Pashkova on 26.04.2023.
//

import XCTest
import RealmSwift
@testable import NewsAggregator

final class NewsAggregatorTests: XCTestCase {
    var sut: New!
    var realm: Realm!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = New()
        sut.title = "Title"
        sut.resDescription = "Depiction"

        realm = try! Realm()
    }
    
    override func setUp() {
        super.setUp()
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testAddNew() throws {
        try! realm.write {
            realm.add(sut)
        }

        let new = realm.objects(New.self).first(where: { $0.title == "Title" })!

        XCTAssert(new.title == "Title")
        XCTAssert(new.resDescription == "Depiction")
    }
    
    func testDeleteNote() throws {
        try! realm.write {
            realm.add(sut)
        }

        try! realm.write {
            realm.deleteAll()
        }
        XCTAssertNil(realm.objects(New.self).first(where: { $0.title == "Title" }))
    }

}
