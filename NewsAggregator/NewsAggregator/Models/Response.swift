//
//  Response.swift
//  NewsAggregator
//
//  Created by Natalia Pashkova on 26.04.2023.
//

import Foundation

struct Response: Codable {
    let status: String
    let results: [Result]
    //let totalResults: Int
    //let nextPage: String
}
