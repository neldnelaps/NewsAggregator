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
    
    private var viewModel = NewDetailsViewModel()
    private var bag = DisposeBag()

    var new = New()
    var isSelected : Bool = false
    
    var indexPath : IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        var addButton : UIBarButtonItem
        if isSelected {
            addButton = UIBarButtonItem(title: "Remove", style: .done, target: self, action: #selector(removeAction))
        } else {
            addButton = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addAction))
        }
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
    
    @objc func addAction () {
        let alert = UIAlertController(title: "New", message: "Add news to favorites?", preferredStyle: .alert)
        alert.view.tintColor = .systemYellow
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self] _ in
            guard let vc = self else { return }
            self?.viewModel.addNew(new: vc.new)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    @objc func removeAction() {
        guard let index = indexPath else { return }
        let alert = UIAlertController(title: "New", message: "Remove news from favorites?", preferredStyle: .alert)
        alert.view.tintColor = .systemYellow
        alert.addAction(UIAlertAction(title: "Remove", style: .destructive) { [weak self] _ in
            self?.viewModel.removeNew(indexPath: index)
            self?.navigationController?.popViewController(animated: true)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(alert, animated: true)
    }

}
