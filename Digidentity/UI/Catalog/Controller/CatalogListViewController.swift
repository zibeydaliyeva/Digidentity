//
//  CatalogListViewController.swift
//  Digidentity
//
//  Created by Зибейда Алекперли on 18.11.21.
//

import UIKit

class CatalogListViewController: BaseViewController {
    
    private lazy var viewModel: CatalogListViewModel = {
        return CatalogListViewModel()
    }()
    
    private let catalogView: CatalogCollectionView = {
        let collectionView = CatalogCollectionView()
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillTransition(to size: CGSize,
        with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        catalogView.reloadData()
    }
    
    override func setupUI() {
        super.setupUI()
        navigationItem.title = "Catalog"
        catalogView.dataSource = self
        catalogView.delegate = self
    }
    
    override func addSubviews() {
        super.addSubviews()
        view.addSubview(catalogView)
    }
    
    override func setConstraints() {
        super.setConstraints()
        catalogView.anchor(.fillSuperview(isSafeArea: true))
    }
    

    
}


// MARK: - UICollectionView data source
extension CatalogListViewController:  UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let dataCount = viewModel.catalogCount
        return section == 0 ? dataCount : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            return itemCell(indexPath: indexPath)
        } else {
            return loadingCell(indexPath: indexPath)
        }
    }
    
    func itemCell(indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = catalogView.collectionView.dequeueReusableCell(
                withReuseIdentifier: CatalogCell.ID, for: indexPath) as? CatalogCell,
              let cellViewModel = viewModel.getCatalog(at: indexPath.item)
        else { return UICollectionViewCell() }
        
        cell.configure(cellViewModel)
        return cell
    }
    
    func loadingCell(indexPath: IndexPath) -> UICollectionViewCell {
        let cell = catalogView.collectionView.dequeueReusableCell(
            withReuseIdentifier: LoadingCell.ID, for: indexPath) as? LoadingCell
        return cell ?? UICollectionViewCell()
    }

}


// MARK: - CatalogCollectionViewDelegate delegate

extension CatalogListViewController: CatalogCollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellViewModel = viewModel.getCatalog(at: indexPath.row)
        let vc = CatalogDetailViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.viewModel = cellViewModel
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func scrollViewDidScrollToTop() {
        loadNewerCatalog()
    }
    
    func scrollViewDidScrollToBottom() {
        loadOlderCatalog()
    }
    
    func handleRefresh() {
        loadNewerCatalog()
    }
    
}


// MARK: - Private Load Catalog
extension CatalogListViewController {

    private func initialLoad() {
        viewModel.initialLoad() { [weak self] error  in
            if let error = error {
                self?.errorHandler(error)
            } else {
                self?.catalogView.reloadData()
            }
        }
    }
    
    private func loadNewerCatalog() {
        self.viewModel.loadNewerCatalog { [weak self] error in
            guard let self = self else { return }
            self.catalogView.endRefreshing()
            if let error = error {
                self.errorHandler(error)
            } else {
                self.catalogView.reloadData()
                let item = self.viewModel.newDataCount - 1
                self.catalogView.scrollToItem(at: item)
            }
        }
    }
    
    private func loadOlderCatalog() {
        guard !viewModel.isLastOldFetch else { return }
        catalogView.animateSpinner(true)
        viewModel.loadOlderCatalog { [weak self] error in
            self?.catalogView.animateSpinner(false)
            if let error = error {
                self?.errorHandler(error)
            } else {
                DispatchQueue.main.async {
                    self?.catalogView.reloadData()
                }
            }
        }
    }

}
