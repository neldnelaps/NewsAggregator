//
//  SelectedNewsViewController.swift
//  NewsAggregator
//
//  Created by Natalia Pashkova on 26.04.2023.
//

import Foundation
import UIKit

import RxSwift

class SelectedNewsViewController: BaseTableViewController {
    
    private var viewModel = SelectedNewsViewModel()
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Selected News"
        bindTableView()
    }

    func bindTableView() {
        tableView.rx.setDelegate(self).disposed(by: bag)
        
        viewModel.showLoading.asObservable().observe(on: MainScheduler.instance).bind(to: indicatorView.rx.isAnimating).disposed(by: bag)
        
        let isEmpty = tableView.rx.isEmpty(message: "No selected news")
        viewModel.news.map({ $0.count <= 0 }).distinctUntilChanged().bind(to: isEmpty).disposed(by: bag)
        
        viewModel.news.bind(to: tableView.rx.items(cellIdentifier: NewTableViewCell.key,
                                                   cellType: NewTableViewCell.self))
        { (_, item: New, cell: NewTableViewCell) in
            cell.titleLabel?.text = item.title
            cell.pubDateLabel?.text = item.pubDate
            cell.creatorLabel?.text = item.creator
        }.disposed(by: bag)
        
        tableView.rx.itemSelected.subscribe(onNext: { indexPath in
            let item = try! self.viewModel.news.value()[indexPath.row]
            let new = New()
            new.title = item.title
            new.creator = item.creator
            new.resDescription = item.resDescription
            new.imageURL = item.imageURL
            new.pubDate = item.pubDate
            new.link = item.link

            let vc = NewDetailsViewController(new: new, isSelected: true, indexPath: indexPath)
            self.show(vc, sender: self)
        }).disposed(by: bag)
        
    }
}

extension SelectedNewsViewController : UITableViewDelegate { }
