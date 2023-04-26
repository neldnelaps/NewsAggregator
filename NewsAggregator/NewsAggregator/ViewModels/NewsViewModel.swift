//
//  NewsViewModel.swift
//  NewsAggregator
//
//  Created by Natalia Pashkova on 26.04.2023.
//

import Foundation
import RxSwift

class NewsViewModel {
    
    var news = BehaviorSubject(value: [Result]())
    private var apiNew: NewApiProtocol = NewApi()
    
    func fetchNews() async {
        let news = (try? await apiNew.getNews()) ?? []
        self.news.on(.next(news))
    }
}
