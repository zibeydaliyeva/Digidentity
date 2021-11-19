//
//  CatalogCollectionViewDelegate.swift
//  Digidentity
//
//  Created by Зибейда Алекперли on 19.11.21.
//

import UIKit

protocol CatalogCollectionViewDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    func scrollViewDidScrollToTop()
    func scrollViewDidScrollToBottom()
    func handleRefresh()
}
