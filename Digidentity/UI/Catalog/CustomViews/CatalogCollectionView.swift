//
//  CatalogCollectionView.swift
//  Digidentity
//
//  Created by Зибейда Алекперли on 19.11.21.
//

import UIKit

class CatalogCollectionView: UIView {
    
    weak var delegate: CatalogCollectionViewDelegate?
    
    private let padding: CGFloat = 16
    private let space: CGFloat = 15
    
    private lazy var flowFlayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = space
        layout.minimumLineSpacing = space
        layout.sectionInset = .zero
        return layout
    }()
    
    private let refresh: UIRefreshControl = {
        var refresh = UIRefreshControl()
        refresh.tintColor = .gray
        refresh.addTarget(
            self,
            action: #selector(handleRefresh),
            for: .valueChanged)
        return refresh
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero, collectionViewLayout: flowFlayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(
            horizontalInset: 0, verticalInset: 0)
        collectionView.clipsToBounds = true
        collectionView.backgroundColor = .clear
        collectionView.refreshControl = refresh
        return collectionView
    }()

    
    var dataSource: UICollectionViewDataSource? {
        get {
            return collectionView.dataSource
        }
        set {
            collectionView.dataSource = newValue
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupUI()
        addSubviews()
        setConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        collectionView.registerCell( CatalogCell.self,
                                     identifier: CatalogCell.ID)
        
        collectionView.registerCell( LoadingCell.self,
                                     identifier: LoadingCell.ID)
        collectionView.delegate = self
    }
    
    private func addSubviews() {
        self.addSubview(collectionView)
    }
    
    private func setConstraints() {
        collectionView.anchor(
            .top(),
            .leading(15),
            .trailing(-15),
            .bottom())
    }
    
    @objc private func handleRefresh() {
        self.delegate?.handleRefresh()
    }
    
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func endRefreshing() {
        refresh.endRefreshing()
    }
    
    func scrollToItem(at item: Int) {
        let indexPath = IndexPath(item: item, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .top, animated: false)
    }

    func animateSpinner(_ animate: Bool) {
        let loadingCellIndex = IndexPath(item: 0, section: 1)
            
        guard let cell = collectionView.cellForItem(at: loadingCellIndex) as? LoadingCell
        else { return }
        cell.animateSpinner(animate)

    }
}

extension CatalogCollectionView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let safeFrame = safeAreaLayoutGuide.layoutFrame.width
        let contentFrame = safeFrame - padding * 2
        let itemCount: CGFloat = safeFrame > 538 ? 4 : 2
        let itemsFrame = contentFrame - space * (itemCount - 1)
        let itemWidth: CGFloat = itemsFrame / itemCount
        let itemHeight = itemWidth + 60
        let itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        let loadingWidth = contentFrame
        let loadingSize = CGSize(width: loadingWidth, height: 40)
        return indexPath.section == 0 ? itemSize : loadingSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.collectionView(collectionView, didSelectItemAt: indexPath)
    }
    
    
}


extension CatalogCollectionView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isTopCell(scrollView) {
            self.delegate?.scrollViewDidScrollToTop()
        }
        if isLastCell(scrollView) {
            self.delegate?.scrollViewDidScrollToBottom()
        }
    }
    
    private func isLastCell(_ scrollView: UIScrollView) -> Bool {
        let currentOffset = scrollView.contentOffset.y
        let contentSizeHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height
        let maximumOffset = contentSizeHeight - scrollViewHeight
        
        return currentOffset >= 0 &&
               currentOffset >= maximumOffset
    }

    private func isTopCell(_ scrollView: UIScrollView) -> Bool {
        return scrollView.contentSize.height > 0 &&
               ((scrollView.contentOffset.y + scrollView.safeAreaInsets.top) == 0)
    }
    

}
