//
//  LoadNewsUsecase.swift
//  NewsAggregator
//
//  Created by Natalia Pashkova on 29.04.2023.
//

import Foundation

class LoadNewsUsecase {
    
    private var newsRepository: NewsRepositoryProtocol
    
    init(newsRepository: NewsRepositoryProtocol){
        self.newsRepository = newsRepository
    }
    
    func getNews() async -> [Result] {
        let news = (try? await newsRepository.getNews()) ?? []
        return news
    }
    
}
