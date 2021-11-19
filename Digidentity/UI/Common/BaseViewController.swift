//
//  BaseViewController.swift
//  Digidentity
//
//  Created by Зибейда Алекперли on 16.11.21.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addSubviews()
        setConstraints()
    }
    
    
    func setupUI() {
        
    }
    
    func addSubviews() {
        
    }
    
    func setConstraints() {
        
    }
    
    func errorHandler(_ error: Error) {
        self.trackError(with: error.localizedDescription)
        self.errorAlert(with: error.localizedDescription)
    }


}
