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
        let tv = UITableView(frame: self.view.frame, style: .insetGrouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(NewTableViewCell.self, forCellReuseIdentifier: "NewTableViewCell")
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        setConstraints()
        
        Task { await viewModel.fetchNews() }
        bindTableView()
    }
    
    func setConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func bindTableView() {
        tableView.rx.setDelegate(self).disposed(by: bag)
        
        viewModel.news.bind(to: tableView.rx.items(cellIdentifier: "NewTableViewCell", cellType: NewTableViewCell.self)) { (row, item, cell) in
            cell.textLabel?.text = item.title
            cell.detailTextLabel?.text = item.resDescription
        }
        .disposed(by: bag)

        tableView.rx.itemSelected.subscribe(onNext: { indexPath in

        }).disposed(by: bag)
    }
}

extension NewsViewController : UITableViewDelegate { }
