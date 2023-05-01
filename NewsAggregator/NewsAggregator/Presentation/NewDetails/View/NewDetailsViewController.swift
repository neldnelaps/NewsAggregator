//
//  NewDetailsViewController.swift
//  NewsAggregator
//
//  Created by Natalia Pashkova on 28.04.2023.
//

import UIKit
import SDWebImage
import RxSwift

class NewDetailsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var creatorLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var linkTextView: UITextView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //TODO надо переделать опеределение vm через di
    private var viewModel = NewDetailsViewModel(newDetailsUsecase: NewDetailsUsecase(
        realmRepository: RealmRepository(),
        realmGetRepository: RealmGetRepository()))
    
    private var bag = DisposeBag()

    var new = New()
    var isSelected : Bool = false
    
    var indexPath : IndexPath?

    init(new: New, isSelected: Bool, indexPath: IndexPath) {
        self.new = new
        self.isSelected = isSelected
        self.indexPath = indexPath
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let addButton = UIBarButtonItem(title: isSelected ? "Remove" : "Add", style: .done, target: self, action: #selector(action))
        self.navigationItem.rightBarButtonItem = addButton
        
        titleLabel.text = new.title
        creatorLabel.text = new.creator
        linkTextView.text = new.link
        descriptionLabel.text = new.resDescription

        guard let imageUrl = new.imageURL, let url = URL(string: imageUrl) else {
            imageView.isHidden = true
            return
        }
        imageView.sd_setImage(with: url,
                              placeholderImage: UIImage(named: "ic_placeholder"),
                              options: [.continueInBackground, .progressiveLoad],
                              completed: nil)
    }

    // MARK: - Alert
    @objc func action() {
        if isSelected {
            presentAlert(title: "New", message: "Remove news from favorites?", actionTitle: "Remove",
                handler: { [weak self] in
                guard let vc = self, let index = vc.indexPath else { return }
                self?.viewModel.removeNew(new: (self?.viewModel.newsArray[index.row])!)
                self?.navigationController?.popViewController(animated: true)
                })
        } else {
            presentAlert(title: "New", message: "Add news to favorites?", actionTitle: "Add",
                handler: { [weak self] in
                    guard let vc = self else { return }
                    self?.viewModel.addNew(new: vc.new)
                })
        }
    }
    
    func presentAlert(title: String, message: String, actionTitle: String, handler: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = .systemYellow
        alert.addAction(UIAlertAction(title: actionTitle, style: .default) { _ in
            handler?()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }

}
