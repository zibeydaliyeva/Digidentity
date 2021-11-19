//
//  LoadingCell.swift
//  Digidentity
//
//  Created by Зибейда Алекперли on 18.11.21.
//

import UIKit

class LoadingCell: UICollectionViewCell {
    
    static let ID = "LoadingCell"
    
    private let spinner: UIActivityIndicatorView = {
        let view =  UIActivityIndicatorView(style: .gray)
        view.hidesWhenStopped = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
        self.setViews()
        self.layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    private func setViews() {
        contentView.addSubview(spinner)
    }
    
    private func layoutViews() {
        spinner.anchor(.fillSuperview(isSafeArea: true))
    }
    
    private func setupUI() {
        backgroundColor = .white
    }
    
    // MARK: - Animate spinner
    func animateSpinner(_ animate: Bool) {
        DispatchQueue.main.async {
            if animate {
                self.spinner.startAnimating()
            } else{
                self.spinner.stopAnimating()
            }
        }
    }
}
