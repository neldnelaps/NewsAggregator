//
//  ErrorApi.swift
//  NewsAggregator
//
//  Created by Natalia Pashkova on 26.04.2023.
//

import Foundation

struct ErrorApi: Error {
    let message: String
    var localizedDescription: String { message }
}
