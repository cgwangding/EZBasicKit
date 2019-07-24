//
//  EZMenuController.swift
//  MenuItemKit-Swift
//
//  Created by wangding on 2019/6/30.
//  Copyright © 2019 lazyapps. All rights reserved.
//

import UIKit

public class EZMenuItem: NSObject {

    public var title: String?
    public var image: UIImage?
    public var action: ((EZMenuItem) -> Void)?
    public init(title: String?, image: UIImage?, action: ((EZMenuItem) -> Void)?) {
        super.init()
        self.title = title
        self.image = image
        self.action = action
    }
}

extension EZMenuItem {

    static let EZItemHeight: CGFloat = 30

    func menuItemSize() -> CGSize {
        let height: CGFloat = EZMenuItem.EZItemHeight

        let button = UIButton(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 9, bottom: 0, right: 9)
        button.setTitle(self.title, for: UIControl.State())
        button.setImage(self.image, for: UIControl.State())

        let size = button.systemLayoutSizeFitting(CGSize(width: CGFloat.infinity, height: height), withHorizontalFittingPriority: .defaultLow, verticalFittingPriority: .required)

        return CGSize(width: size.width, height: height)
    }
}

public class EZMenuController: UIViewController {


    public static let shared: EZMenuController = {
        let menuBundle = Bundle.ezBasicKitResourceBundle
        let vc = UIStoryboard(name: "EZMenu", bundle: menuBundle ).instantiateInitialViewController() as! EZMenuController
        return vc
    }()

    @IBOutlet weak var collectionView: UICollectionView!

    public var items: [EZMenuItem]?

    public fileprivate(set) var isMenuVisible: Bool = false
    
    public var menuVisibleAction: ((Bool) -> Void)?

    @available(*, unavailable)
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self

        self.collectionView.reloadData()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.menuVisibleAction?(true)
        if self.isViewLoaded {
            self.collectionView.reloadData()
        }
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.menuVisibleAction?(false)
    }

    fileprivate var _targetRect: CGRect = .zero
    fileprivate var _targetView: UIView?

    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let width = self.items?.reduce(0, { (result, item) -> CGFloat in
            return result + item.menuItemSize().width
        }) ?? 0
        self.preferredContentSize = CGSize(width: width, height: EZMenuItem.EZItemHeight)
    }
}

extension EZMenuController {

    public func setTargetRect(_ frame: CGRect, in view: UIView?) {
        self._targetRect = frame
        self._targetView = view
    }

    public func setMenuVisible(_ visible: Bool, in viewController: UIViewController?) {
        let shared = EZMenuController.shared
        shared.modalPresentationStyle = .popover
        shared.popoverPresentationController?.sourceRect = self._targetRect
        shared.popoverPresentationController?.sourceView = self._targetView
        shared.popoverPresentationController?.permittedArrowDirections = [.up, .down]
        shared.popoverPresentationController?.delegate = self
        shared.popoverPresentationController?.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        EZMenuController.shared.isMenuVisible = visible
        viewController?.present(shared, animated: false, completion: {
            self.collectionView.reloadData()
        })
    }
}

extension EZMenuController: UIPopoverPresentationControllerDelegate {

    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

    public func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        EZMenuController.shared.isMenuVisible = false
    }
}

extension EZMenuController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = self.items?[indexPath.row] else {
            return UICollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EZMenuItemCollectionCell", for: indexPath)
        let button = cell.viewWithTag(101) as? UIButton
        button?.setTitle(item.title, for: UIControl.State())
        button?.setImage(item.image, for: UIControl.State())
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        guard let item = self.items?[indexPath.row] else {
            return
        }
        self.dismiss(animated: false) {
            EZMenuController.shared.isMenuVisible = false
            item.action?(item)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let item = self.items?[indexPath.row] else {
            return .zero
        }
        return item.menuItemSize()
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
