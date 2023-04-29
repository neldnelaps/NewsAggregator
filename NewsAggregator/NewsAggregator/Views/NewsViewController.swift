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

class NewsViewController: UIViewController {
    
    private var viewModel = NewsViewModel()
    private var bag = DisposeBag()
    
    lazy var tableView : UITableView = {
        let tv = UITableView(frame: self.view.frame)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(UINib(nibName: "NewTableViewCell", bundle: nil), forCellReuseIdentifier: "NewTableViewCell")
        return tv
    }()
    
    let indicatorView : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"

        setConstraints()

        Task { await viewModel.fetchNews() }
        bindTableView()
        setupRefreshControl()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { _ in } completion: { [self] _ in
            self.tableView.reloadData()
        }
    }
    
    func setConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        view.addSubview(indicatorView)
        indicatorView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.view)
            make.centerX.equalTo(self.view)
        }
    }
    
    func bindTableView() {
        tableView.rx.setDelegate(self).disposed(by: bag)
        
        viewModel.showLoading.asObservable().observe(on: MainScheduler.instance).bind(to: indicatorView.rx.isAnimating).disposed(by: bag)

        viewModel.news.bind(to: tableView.rx.items(cellIdentifier: "NewTableViewCell",
                                                     cellType: NewTableViewCell.self)) { (_, item: Result, cell: NewTableViewCell) in
            cell.titleLabel?.text = item.title
            cell.pubDateLabel?.text = item.pubDate
            cell.creatorLabel?.text = item.creator?.compactMap{$0}.joined(separator: ", ") ?? "anonym"
        }.disposed(by: bag)

        tableView.rx.itemSelected.subscribe(onNext: { indexPath in
            DispatchQueue.main.async {
                let vc = NewDetailsViewController()
                        
                let item = try! self.viewModel.news.value()[indexPath.row]
                vc.new.title = item.title
                vc.new.creator = item.creator?.compactMap{$0}.joined(separator: ", ") ?? "anonym"
                vc.new.resDescription = item.resDescription
                vc.new.imageURL = item.imageURL
                vc.new.pubDate = item.pubDate
                vc.new.link = item.link
                self.show(vc, sender: self)
            }
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
