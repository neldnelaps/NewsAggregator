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
    let showLoading = BehaviorRelay<Bool>(value: true)
    var news = BehaviorSubject(value: [New]())
    
    let realm = try! Realm()
    var newsArray : [New]
    var token : NotificationToken?
    
    init() {
        newsArray =  [New]()
        fetchNews ()
        token = realm.observe({[weak self] _, realm in
            self?.fetchNews()
        })
        showLoading.accept(false)
    }
    
    func fetchNews () {
        newsArray = try! Realm().objects(New.self).map({$0})
        self.news.on(.next(newsArray))
    }

}
