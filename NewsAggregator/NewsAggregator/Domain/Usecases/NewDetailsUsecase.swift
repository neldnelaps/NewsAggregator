//
//  NewDetailsUsecase.swift
//  NewsAggregator
//
//  Created by Natalia Pashkova on 30.04.2023.
//

import Foundation

class NewDetailsUsecase {
    
    private var realmRepository: RealmRepositoryProtocol
    private var realmGetRepository: RealmGetRepositoryProtocol
    
    init(realmRepository: RealmRepositoryProtocol, realmGetRepository :RealmGetRepositoryProtocol){
        self.realmRepository = realmRepository
        self.realmGetRepository = realmGetRepository
    }
    
    func getNews() -> [New] {
        return try! realmGetRepository.getNews()
    }
    
    func addNew(new: New) {
        realmRepository.addNew(new: new)
    }
    
    func removeNew(new: New) {
        realmRepository.removeNew(new: new)
    }
    
}
