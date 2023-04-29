//
//  Result.swift
//  NewsAggregator
//
//  Created by Natalia Pashkova on 26.04.2023.
//

import Foundation

struct Result: Codable {
    
    let title: String
    let link: String
    let creator: [String]?
    let resDescription: String?
    let pubDate: String
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case title, link, creator
        case resDescription = "description"
        case pubDate
        case imageURL = "image_url"
    }
    
}
