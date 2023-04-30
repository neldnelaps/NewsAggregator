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
   
    private let loadNewsUsecase: LoadNewsUsecase
    
    let showLoading = BehaviorRelay<Bool>(value: true)
    let items = BehaviorSubject<[Result]>(value: [Result]())

    init(loadNewsUsecase: LoadNewsUsecase) {
        self.loadNewsUsecase = loadNewsUsecase
    }
    
    // MARK: - Input
    func fetchNews() async {
        let news = await loadNewsUsecase.getNews()
        showLoading.accept(false)
        self.items.on(.next(news))
    }
    
}
