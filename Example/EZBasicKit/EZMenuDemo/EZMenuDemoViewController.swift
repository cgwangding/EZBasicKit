//
//  EZMenuDemoViewController.swift
//  EZBasicKit_Example
//
//  Created by wangding on 2019/7/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import EZBasicKit

class EZMenuDemoViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction(_:)))
        longPress.minimumPressDuration = 0.75
        longPress.numberOfTouchesRequired = 1

        self.label.addGestureRecognizer(longPress)

        let longPress2 = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction(_:)))
        longPress2.minimumPressDuration = 0.75
        longPress2.numberOfTouchesRequired = 1
        self.button.addGestureRecognizer(longPress2)
    }
    

    @objc func longPressAction(_ gesture: UILongPressGestureRecognizer) {

        debugPrint(gesture)
        let menu = EZMenuController.shared
        guard !menu.isMenuVisible else { return }

        let view = gesture.view

        var items: [EZMenuItem] = []

        switch view {
        case self.label:
            let item1 = EZMenuItem(title: "Click to change text color", image: UIImage(named: "edit")) { (_) in
                self.label.textColor = UIColor.random
            }
            items.append(item1)

            let item2 = EZMenuItem(title: nil, image: UIImage(named: "edit")) { (_) in
                debugPrint("这里只有一个图片")
            }
            items.append(item2)

            let item3 = EZMenuItem(title: "Only a text here", image: nil) { (_) in
                debugPrint("这里只有一段文字")
            }
            items.append(item3)
        case self.button:
            let item1 = EZMenuItem(title: "Click to change background color", image: UIImage(named: "edit")) { (_) in
                self.button.backgroundColor = UIColor.random
            }
            items.append(item1)

            let item2 = EZMenuItem(title: nil, image: UIImage(named: "edit")) { (_) in
                debugPrint("这里只有一个图片")
            }
            items.append(item2)

            let item3 = EZMenuItem(title: "Only a text here", image: nil) { (_) in
                debugPrint("这里只有一段文字")
            }
            items.append(item3)
        default: break
        }

        menu.items = items
        menu.setTargetRect(view?.frame ?? CGRect.zero, in: self.view)
        menu.setMenuVisible(true, in: self)
    }

}
