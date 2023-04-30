//
//  NewsRepository.swift
//  NewsAggregator
//
//  Created by Natalia Pashkova on 26.04.2023.
//

import Foundation

class NewsRepository : NewsRepositoryProtocol {
    
    private let headers: [String: String] = [:]
    private let urlComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = ClientAPI.host
        return components
    }()

    func getNews() async throws -> [Result] {
        var components = urlComponents
        components.path = "/api/1/news"
        components.queryItems = [
            URLQueryItem(name: "apikey", value: "\(ClientAPI.apiKey)"),
            URLQueryItem(name: "language", value: Locale.current.languageCode)]

        guard let componentsUrl = components.url
        else { throw ErrorRepository(message: "Incorrect URL") }

        let response = try await baseRequest(from: componentsUrl) as Response
        return response.results
    }
    
    private func baseRequest<T: Decodable>(from url: URL) async throws -> T {
        var request = URLRequest(url: url)
        print(url)
        request.allHTTPHeaderFields = headers
        let data = try await URLSession.shared.data(for: request).0
        return try JSONDecoder().decode(T.self, from: data)
    }
    
}
