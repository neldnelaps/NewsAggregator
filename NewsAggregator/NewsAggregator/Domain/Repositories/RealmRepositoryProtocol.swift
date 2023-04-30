//
//  RealmRepositoryProtocol.swift
//  RealmGetRepositoryProtocol.swift
//  NewsAggregator
//
//  Created by Natalia Pashkova on 30.04.2023.
//

import Foundation

protocol RealmGetRepositoryProtocol {
    func getNews() throws -> [New]
}

protocol RealmRepositoryProtocol {
    func addNew(new: New)
    func removeNew(new: New)
}
