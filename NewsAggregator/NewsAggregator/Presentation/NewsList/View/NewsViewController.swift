//
//  NewsViewController.swift
//  NewsAggregator
//
//  Created by Natalia Pashkova on 26.04.2023.
//

import Foundation
import UIKit

import SnapKit

import RxSwift
import RxCocoa

class NewsViewController: BaseTableViewController {
    
    //TODO надо переделать опеределение vm через di
    private var viewModel = NewsViewModel(loadNewsUsecase: LoadNewsUsecase(newsRepository: NewsRepository()))
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        Task { await viewModel.fetchNews() }
        bindTableView()
        setupRefreshControl()
    }
    
    // MARK: - Bind
    func bindTableView() {
        tableView.rx.setDelegate(self).disposed(by: bag)
        
        viewModel.showLoading.asObservable().observe(on: MainScheduler.instance).bind(to: indicatorView.rx.isAnimating).disposed(by: bag)
        
        let isEmpty = tableView.rx.isEmpty(message: "Oops, something went wrong")
        viewModel.items.map({ $0.count <= 0 }).distinctUntilChanged().bind(to: isEmpty).disposed(by: bag)

        viewModel.items.bind(to: tableView.rx.items(cellIdentifier: NewTableViewCell.key,
                                                     cellType: NewTableViewCell.self)) { (_, item: Result, cell: NewTableViewCell) in
            cell.titleLabel?.text = item.title
            cell.pubDateLabel?.text = item.pubDate
            cell.creatorLabel?.text = item.creator?.compactMap{$0}.joined(separator: ", ") ?? "anonym"
        }.disposed(by: bag)

        tableView.rx.itemSelected.subscribe(onNext: { indexPath in
            let item = try! self.viewModel.items.value()[indexPath.row]
            let new = New()
            new.title = item.title
            new.creator = item.creator?.compactMap{$0}.joined(separator: ", ") ?? "anonym"
            new.resDescription = item.resDescription
            new.imageURL = item.imageURL
            new.pubDate = item.pubDate
            new.link = item.link

            let vc = NewDetailsViewController(new: new, isSelected: false, indexPath: indexPath)
            self.show(vc, sender: self)
        }).disposed(by: bag)
    
    }
    
    // MARK: - Refresh
    @objc private func refreshNews(_ sender: UIRefreshControl) {
        Task {
            await self.viewModel.fetchNews()
            self.tableView.reloadData()
            sender.endRefreshing()
        }
    }
    
    func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = .clear
        refreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
    }
}

extension NewsViewController : UITableViewDelegate { }
