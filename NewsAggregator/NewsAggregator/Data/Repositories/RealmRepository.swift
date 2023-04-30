//
//  RealmRepository.swift
//  NewsAggregator
//
//  Created by Natalia Pashkova on 30.04.2023.
//

import Foundation
import RealmSwift
import RxRealm

class BaseRealmRepository {
    
    fileprivate var realm: Realm {
        return try! Realm()
    }
    
}

class RealmGetRepository: BaseRealmRepository, RealmGetRepositoryProtocol {
    
    func getNews() throws -> [New] {
        return realm.objects(New.self).map({$0})
    }

}

class RealmRepository: BaseRealmRepository, RealmRepositoryProtocol {
    
    func addNew(new: New) {
        let existingNew = realm.object(ofType: New.self, forPrimaryKey: new.title)

        if existingNew != nil {
           return
        } else {
            try! realm.write {
                realm.create(New.self, value: new, update: .all)
            }
        }
    }
    
    func removeNew(new: New) {
        do {
            try realm.write {
                realm.delete(new)
                realm.refresh()
            }
        }
        catch let error as NSError {
            print("Error deleting new: \(error)")
        }
    }
    
}
