//
//  CatalogDetailViewController.swift
//  Digidentity
//
//  Created by Зибейда Алекперли on 19.11.21.
//

import UIKit

class CatalogDetailViewController: BaseViewController {
    
    var viewModel: CatalogCellViewModel?
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel(
            fontSize: 16,
            color: .mainTextColor,
            alignment: .center)
        return label
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel(
            fontSize: 12,
            color: .grayColor,
            alignment: .center)
        return label
    }()
    
    private let confidenceLabel: UILabel = {
        let label = UILabel(
            fontSize: 12,
            color: .grayColor,
            alignment: .center)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.nameLabel,
            self.idLabel,
            self.confidenceLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewData()
    }
    
    override func setupUI() {
        super.setupUI()
    }
    
    override func addSubviews() {
        super.addSubviews()
        view.addSubview(imageView)
        view.addSubview(stackView)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        imageView.anchor(
            .top(view.safeAreaTopAnchor),
            .leading(),
            .trailing(),
            .height(200))
        
        stackView.anchor(
            .top(imageView.bottomAnchor, constant: 5),
            .leading(25),
            .trailing(-25))
    }
    
    private func setViewData() {
        guard let viewModel = viewModel else { return }
        navigationItem.title = viewModel.text
        
        nameLabel.text = viewModel.text
        idLabel.text = "ID: \(viewModel.id)"
        confidenceLabel.text = "Confidence: \(String(viewModel.confidence))"
        imageView.loadImageFromUrl(viewModel.imagePath)
    }
    
}
