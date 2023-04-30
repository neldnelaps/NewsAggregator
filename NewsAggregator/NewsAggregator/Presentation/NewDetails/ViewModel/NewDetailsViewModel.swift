//
//  NewDetailsViewModel.swift
//  NewsAggregator
//
//  Created by Natalia Pashkova on 28.04.2023.
//

import Foundation
import RealmSwift

class NewDetailsViewModel {
    
    var newsArray : [New]
    private let newDetailsUsecase: NewDetailsUsecase

    init(newDetailsUsecase: NewDetailsUsecase) {
        self.newDetailsUsecase = newDetailsUsecase
        newsArray = [New]()
        fetchNews ()
    }
    
    func fetchNews () {
        newsArray = newDetailsUsecase.getNews()
    }
    
    func addNew(new: New) {
        newDetailsUsecase.addNew(new: new)
    }
    
    func removeNew(new: New) {
        newDetailsUsecase.removeNew(new: new)
    }
    
}
