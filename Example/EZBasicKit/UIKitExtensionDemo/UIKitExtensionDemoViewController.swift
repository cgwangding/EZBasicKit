//
//  UIKitExtensionDemoViewController.swift
//  EZBasicKit_Example
//
//  Created by qiuming on 2019/6/12.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import EZBasicKit

enum actionType: Int {
    case compress     = 1001
    case color        = 1002
    case circle       = 1003
    case cropped      = 1004
    case mirrored     = 1005
    case rotate       = 1006
    case scaled       = 1007
    case cornerRadius = 1008
    case water1       = 1009
    case water2       = 1010
    case water3       = 1011
    case water4       = 1012
    case GIF          = 1013
    case badgeShown   = 1014
    case textShown    = 1015
    case snapShot     = 1016
}

enum alertStyle: Int {
    case defalut = 2001
    case alert   = 2002
    case autoDismiss = 2003
}


class UIKitExtensionDemoViewController: UIViewController {
    
    @IBOutlet weak var intervalButton: UIButton!
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var enlargeInsetBtn: UIButton!
    
    @IBOutlet weak var hexColorLabel: UILabel!
    
    @IBOutlet weak var randomLabel: UILabel!

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var originImageView: UIImageView!
    
    @IBOutlet weak var tappedImageView: UIImageView!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var displayView: UIView!
    
    @IBOutlet weak var displayImageView: UIImageView!
    
    fileprivate var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
                self.setupTimeIntervalButton()
        self.setupEnlargeInsetBtn()
        self.setupColor()
        self.setupImageView()
    }
    
    
    /// UIViewController + Extension
    @IBAction func alertStyleButtonTapped(_ sender: UIButton) {
        switch sender.tag {
            
        case alertStyle.defalut.rawValue:
            self.presentAlert(title: "", message: "default") { (alert) in
                let ignoreAction = UIAlertAction(title: "Ignore", style: .default, handler: nil)
                alert.addAction(ignoreAction)
                
                let viewAction = UIAlertAction(title: "View", style: .default, handler: nil)
                alert.addAction(viewAction)
            }
            
        case alertStyle.alert.rawValue:
            self.presentAlert(title: "", message: "alert", buttontitle: "OK")
            
        case alertStyle.autoDismiss.rawValue:
            self.presentAutoDismissAlert(message: "autoDissmiss", delay: 2, finished: nil)
            
        default: break
        }
    }
    
    
    
    /// UIView + Extension
    @IBAction func viewExtensionButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case actionType.badgeShown.rawValue:
            self.displayView.isBadgeShown = true
            
        case actionType.textShown.rawValue:
            self.displayView.badgeText = "10"
            
        case actionType.snapShot.rawValue:
            self.displayImageView.image = self.displayView.snapShot()
        
        case actionType.cornerRadius.rawValue:
            self.displayView.setCornerRadius(10)
            
        default:
            break
        }
    }
    
    
    /// UIImage+Extension
    @IBAction func mirroredButtonTapped(_ sender: UIButton) {
        
        switch sender.tag {
        case actionType.compress.rawValue:
            self.originImageView.image = UIImage(named: "original")!.compress(to: 100)
            
        case actionType.color.rawValue:
            self.originImageView.image = UIImage(color: UIColor.green, size: CGSize(width: 60, height: 60))
            
        case actionType.circle.rawValue:
             self.originImageView.image = UIImage(named: "original")?.circleImage
            
        case actionType.cropped.rawValue:
            self.originImageView.image = UIImage(named: "original")?.circleImage
            
        case actionType.mirrored.rawValue:
            self.originImageView.image = UIImage(named: "original")?.mirrored
            
        case actionType.rotate.rawValue:
            self.originImageView.image = UIImage(named: "original")?.rotated(by: 90)
            
        case actionType.scaled.rawValue:
            self.originImageView.image = UIImage(named: "original")?.scaled(to: CGSize(width: 60, height: 60))
            
        case actionType.cornerRadius.rawValue:
            self.originImageView.image = UIImage(named: "original")?.image(with: 10, backgroundColor: UIColor.gray)
            
        case actionType.water1.rawValue:
            self.originImageView.image = UIImage(named: "original")!.addWaterMark(img: UIImage(named: "hot")!, in: self.originImageView.bounds)
            
        case actionType.water2.rawValue:
            self.originImageView.image = UIImage(named: "original")!.addWatermarkInCenter(img: UIImage(named: "hot")!, size: CGSize(width: 60, height: 60))
            
        case actionType.water3.rawValue:
            self.originImageView.image = UIImage(named: "original")!.addWatermark(text: "版本所有", point: CGPoint(x: 20, y: 20), attributes: [NSAttributedString.Key.foregroundColor: UIColor.green])
            
        case actionType.water4.rawValue:
            self.originImageView.image = UIImage(named: "original")!.addWatermark(text: "翻版必究", point: CGPoint(x: 20, y: 20), font: UIFont.systemFont(ofSize: 16))
            
        case actionType.GIF.rawValue:
            guard let path = Bundle.main.path(forResource: "joy", ofType: "gif"), let data = NSData(contentsOfFile: path) as Data? else { return }
            
            self.originImageView.image = UIImage.GIFImage(with: data)
      
        default:
            break
        }
    }
    
}

extension UIKitExtensionDemoViewController {
    fileprivate func setupImageView() {
        self.tappedImageView.ez_addTarget(self, action: #selector(touchMe))
    }
    
    @objc func touchMe() {
        self.tipLabel.text = "选中了"
    }
}


// UIColor+Hex
extension UIKitExtensionDemoViewController {
    
    fileprivate func setupColor() {
        self.hexColorLabel.textColor = UIColor(0x949494)
        self.randomLabel.textColor = UIColor().random
        self.imageView.image = UIColor.green.createImage(self.imageView.bounds.size)
    }
}

// UIButton+Extension
extension UIKitExtensionDemoViewController {
    
    // 扩大点击区域
    fileprivate func setupEnlargeInsetBtn() {
        enlargeInsetBtn.ez_enlargeInst = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    // 防重复多次点击
    fileprivate func setupTimeIntervalButton() {
        intervalButton.ez_acceptEventInterval = 2.0
        intervalButton.addTarget(self, action: #selector(timeIntervalBtnTapped), for: .touchUpInside)
    }
    
    @objc func timeIntervalBtnTapped() {
        currentIndex += 1
        self.countLabel.text = "当前点击\(currentIndex)次"
    }
}
