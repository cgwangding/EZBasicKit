//
//  CustomUIKitDemoViewController.swift
//  EZBasicKit_Example
//
//  Created by wangding on 2019/6/5.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import EZBasicKit

class CustomUIKitDemoViewController: UIViewController {

    @IBOutlet weak var contentCopyableLabel: ContentCopyableLabel!
    @IBOutlet weak var optionalPickerLabel: OptionsPickerLabel!
    @IBOutlet weak var strokedView: StrokeBorderView!

    @IBOutlet weak var strokeLeft: UISwitch!
    @IBOutlet weak var strokeRight: UISwitch!
    @IBOutlet weak var strokeBottom: UISwitch!
    @IBOutlet weak var strokeTop: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.optionalPickerLabel.text = "Optionals picker label"
        self.optionalPickerLabel.options = ["1", "2", "3"]
        self.optionalPickerLabel.confirm = { text in
            debugPrint("select a \(text)")
        }
    }
    

    @IBAction func switchValueChanged(_ sender: UISwitch) {

        self.strokedView.rectEdge.remove(.all)

        if sender.isOn {
            switch sender {
            case self.strokeLeft:
                self.strokedView.rectEdge.insert(.left)
            case self.strokeRight:
                self.strokedView.rectEdge.insert(.right)
            case self.strokeBottom:
                self.strokedView.rectEdge.insert(.bottom)
            case self.strokeTop:
                self.strokedView.rectEdge.insert(.top)
            default:break
            }
        } else {
            switch sender {
            case self.strokeLeft:
                self.strokedView.rectEdge.remove(.left)
            case self.strokeRight:
                self.strokedView.rectEdge.remove(.right)
            case self.strokeBottom:
                self.strokedView.rectEdge.remove(.bottom)
            case self.strokeTop:
                self.strokedView.rectEdge.remove(.top)
            default:break
            }
        }

        self.strokedView.layoutSubviews()
    }
}
