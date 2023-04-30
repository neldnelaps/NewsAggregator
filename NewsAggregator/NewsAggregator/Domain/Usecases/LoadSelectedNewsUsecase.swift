//
//  LoadSelectedNewsUsecase.swift
//  NewsAggregator
//
//  Created by Natalia Pashkova on 29.04.2023.
//

import Foundation
import RealmSwift

class LoadSelectedNewsUsecase {
    
    private var realmRepository: RealmGetRepositoryProtocol
    
    init(realmRepository: RealmGetRepositoryProtocol){
        self.realmRepository = realmRepository
    }
    
    func getNews() -> [New] {
        return try! realmRepository.getNews()
    }
    
}
