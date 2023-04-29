//
//  NewsViewModel.swift
//  NewsAggregator
//
//  Created by Natalia Pashkova on 26.04.2023.
//

import Foundation
import RxSwift
import RxRelay

class NewsViewModel {
    let showLoading = BehaviorRelay<Bool>(value: true)
    var news = BehaviorSubject(value: [Result]())
    private var apiNew: NewApiProtocol = NewApi()
    
    init() {
        Task {
            await fetchNews()
            showLoading.accept(false)
        }
    }
    
    func fetchNews() async {
        let news = (try? await apiNew.getNews()) ?? []
        self.news.on(.next(news))
    }
}
