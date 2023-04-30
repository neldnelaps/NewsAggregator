//
//  SelectedNewsViewModel.swift
//  NewsAggregator
//
//  Created by Natalia Pashkova on 26.04.2023.
//

import Foundation
import RxSwift
import RealmSwift
import RxRelay

class SelectedNewsViewModel {
    
    private let loadSelectedNewsUsecase: LoadSelectedNewsUsecase
    
    let showLoading = BehaviorRelay<Bool>(value: true)
    var items = BehaviorSubject<[New]>(value: [New]())
    var newsArray : [New]
    
    init(loadSelectedNewsUsecase: LoadSelectedNewsUsecase) {
        self.loadSelectedNewsUsecase = loadSelectedNewsUsecase
        newsArray = [New]()
    }
    
    func fetchNews () {
        newsArray = loadSelectedNewsUsecase.getNews()
        self.items.on(.next(newsArray))
        showLoading.accept(false)
    }

}
