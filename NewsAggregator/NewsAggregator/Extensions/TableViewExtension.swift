//
//  TableViewExtension.swift
//  NewsAggregator
//
//  Created by Natalia Pashkova on 29.04.2023.
//

import Foundation
import UIKit
import RxSwift

extension UITableView {
    
    func setNoDataPlaceholder(_ message: String) {
        let messageLabel = UILabel()
        messageLabel.textColor = .lightGray
        messageLabel.font = .systemFont(ofSize: 17)
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center

        backgroundView = UIView()
        backgroundView?.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }

        separatorStyle = .none
    }
    
    func removeNoDataPlaceholder() {
        self.isScrollEnabled = true
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}



extension Reactive where Base: UITableView {
    func isEmpty(message: String) -> Binder<Bool> {
        return Binder(base) { tableView, isEmpty in
            isEmpty ? tableView.setNoDataPlaceholder(message) : tableView.removeNoDataPlaceholder()
        }
    }
}
