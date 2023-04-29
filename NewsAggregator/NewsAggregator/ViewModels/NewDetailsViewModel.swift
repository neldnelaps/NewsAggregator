//
//  NewDetailsViewModel.swift
//  NewsAggregator
//
//  Created by Natalia Pashkova on 28.04.2023.
//

import Foundation
import RealmSwift

class NewDetailsViewModel {
    let realm = try! Realm()
    var newsArray : [New]
    var token : NotificationToken?
    
    init() {
        newsArray =  [New]()
        fetchNews ()
        token = realm.observe({[weak self] _, realm in
            self?.fetchNews()
        })
    }
    func fetchNews () {
        newsArray = try! Realm().objects(New.self).map({$0})
    }
    
    func addNew(new: New) {
        let existingNew = realm.object(ofType: New.self, forPrimaryKey: new.id)

        if let existingNew = existingNew {
           return
        } else {
            try! realm.write {
                realm.create(New.self, value: new, update: .all)
            }
        }
    }
    
    func removeNew(indexPath: IndexPath) {
        do {
            try realm.write {
                realm.delete(newsArray[indexPath.row])
                realm.refresh()
                newsArray.remove(at: indexPath.row)
            }
        }
        catch let error as NSError {
            print("Error deleting new: \(error)")
        }
    }
}
