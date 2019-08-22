//
//  UICollectionView+Extension.swift
//  EZBasicKit
//
//  Created by wangding on 2019/5/24.
//

import Foundation

// MARK: - UICollectionView Extension

extension UICollectionView {

    public func indexPath(for cellContainersView: UIView) -> IndexPath? {

        guard let cell = cellContainersView.ancestor(ofType: UICollectionViewCell.self) as? UICollectionViewCell else {
            return nil
        }
        return self.indexPath(for: cell)
    }
}
