//
//  New.swift
//  NewsAggregator
//
//  Created by Natalia Pashkova on 28.04.2023.
//

import Foundation

import RealmSwift

class New : Object {
    
    @Persisted var title : String
    @Persisted var link : String
    @Persisted var creator : String
    @Persisted var resDescription : String?
    @Persisted var pubDate : String
    @Persisted var imageURL : String?
    
    override static func primaryKey() -> String? {
        return "title"
    }
    
}
