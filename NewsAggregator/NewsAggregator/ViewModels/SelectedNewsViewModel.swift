//
//  SelectedNewsViewModel.swift
//  NewsAggregator
//
//  Created by Natalia Pashkova on 26.04.2023.
//

import Foundation
import RxSwift

class SelectedNewsViewModel {
    
    var news = BehaviorSubject(value: [Result]())

}
