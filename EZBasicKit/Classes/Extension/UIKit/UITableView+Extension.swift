//
//  UITableView+Extension.swift
//  EZBasicKit
//
//  Created by wangding on 2019/5/24.
//

import Foundation

// MARK: - UITableView Extension
extension UITableView {

    public var topIndexPath: IndexPath? {

        let sections = self.numberOfSections

        guard sections > 0 else { return nil }

        for i in 0..<sections where self.numberOfRows(inSection: i) > 0 {
            return IndexPath(row: 0, section: i)
        }
        return nil
    }

    public func scrollToTop(_ animated: Bool = true) {

        guard self.topIndexPath != nil else { return }

        self.beginUpdates()
        self.setContentOffset(.zero, animated: animated)
        self.endUpdates()

    }

    public func indexPath(for cellContainersView: UIView) -> IndexPath? {

        guard let cell = cellContainersView.ancestor(ofType: UITableViewCell.self) as? UITableViewCell else {
            return nil
        }
        return self.indexPath(for: cell)
    }
}
