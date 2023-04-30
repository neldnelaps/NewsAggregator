//
//  NewsRepositoryProtocol.swift
//  NewsAggregator
//
//  Created by Natalia Pashkova on 30.04.2023.
//

import Foundation

protocol NewsRepositoryProtocol {
    func getNews() async throws -> [Result]
}
