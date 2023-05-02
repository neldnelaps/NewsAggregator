//
//  ContainerDI.swift
//  NewsAggregator
//
//  Created by Natalia Pashkova on 02.05.2023.
//

import Foundation
import Swinject

class ContainerDI {
    
    static let container: Container = {
        let container = Container()
        container.register(RealmGetRepositoryProtocol.self) { _ in RealmGetRepository() }
        container.register(RealmRepositoryProtocol.self) { _ in RealmRepository() }
        container.register(NewsRepositoryProtocol.self) { _ in NewsRepository() }
        
        container.register(LoadNewsUsecase.self) { r in LoadNewsUsecase(newsRepository: r.resolve(NewsRepositoryProtocol.self)!) }
        container.register(LoadSelectedNewsUsecase.self) { r in LoadSelectedNewsUsecase(realmRepository: r.resolve(RealmGetRepositoryProtocol.self)!) }
        container.register(NewDetailsUsecase.self) { r in NewDetailsUsecase(
            realmRepository:  r.resolve(RealmRepositoryProtocol.self)!,
            realmGetRepository:  r.resolve(RealmGetRepositoryProtocol.self)!)
        }
        
        container.register(NewsViewModel.self) { r in
            NewsViewModel(loadNewsUsecase: r.resolve(LoadNewsUsecase.self)!)
        }.inObjectScope(.container)
        
        container.register(SelectedNewsViewModel.self) { r in
            SelectedNewsViewModel(loadSelectedNewsUsecase: r.resolve(LoadSelectedNewsUsecase.self)!)
        }.inObjectScope(.container)
        
        container.register(NewDetailsViewModel.self) { r in
            NewDetailsViewModel(newDetailsUsecase: r.resolve(NewDetailsUsecase.self)!)
        }.inObjectScope(.container)
        
        return container
    }()
    
}
