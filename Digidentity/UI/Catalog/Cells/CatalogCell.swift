//
//  CatalogCell.swift
//  Digidentity
//
//  Created by Зибейда Алекперли on 18.11.21.
//

import UIKit

class CatalogCell: UICollectionViewCell {
    
    static let ID = "CatalogCell"
    
    private let imgView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel(
            fontSize: 12,
            color: .mainTextColor)
        return label
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel(
            fontSize: 12,
            color: .grayColor)
        return label
    }()
    
    private let confidenceLabel: UILabel = {
        let label = UILabel(
            fontSize: 12,
            color: .grayColor)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func addSubviews() {
        contentView.addSubview(imgView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(idLabel)
        contentView.addSubview(confidenceLabel)
    }
    
    private func setConstraints() {
        imgView.anchor(
            .top(),
            .leading(),
            .trailing(),
            .heightEqualTo(imgView.widthAnchor))
        
        nameLabel.anchor(
            .leading(),
            .trailing(),
            .top(imgView.bottomAnchor, constant: 5))
        
        idLabel.anchor(
            .leading(),
            .trailing(),
            .top(nameLabel.bottomAnchor, constant: 5))
        
        confidenceLabel.anchor(
            .leading(),
            .trailing(),
            .top(idLabel.bottomAnchor, constant: 5))
  
    }
    
 
    // MARK: - Set data
    func configure(_ viewModel: CatalogCellViewModel) {
        idLabel.text = "ID: \(viewModel.id)"
        nameLabel.text = "Name: \(viewModel.text)"
        confidenceLabel.text = "Confidence: \(String(viewModel.confidence))"
        imgView.loadImageFromUrl(viewModel.imagePath)
    }
}
