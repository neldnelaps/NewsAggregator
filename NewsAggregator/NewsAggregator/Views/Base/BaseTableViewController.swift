//
//  BaseTableViewController.swift
//  NewsAggregator
//
//  Created by Natalia Pashkova on 29.04.2023.
//

import Foundation
import UIKit

class BaseTableViewController: UIViewController{
    
    lazy var tableView : UITableView = {
        let tv = UITableView(frame: self.view.frame)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(UINib(nibName: NewTableViewCell.key, bundle: nil), forCellReuseIdentifier: NewTableViewCell.key)
        return tv
    }()
    
    let indicatorView : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
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
            make.centerY.equalToSuperview().offset(-50)
            make.centerX.equalTo(self.view)
        }
    }
    
}
