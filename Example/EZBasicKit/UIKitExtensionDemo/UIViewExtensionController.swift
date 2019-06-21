//
//  UIViewExtensionController.swift
//  EZBasicKit_Example
//
//  Created by qiuming on 2019/6/21.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

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

class UIViewExtensionController: UIViewController {
    
    @IBOutlet weak var originImageView: UIImageView!
    
    @IBOutlet weak var tappedImageView: UIImageView!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var displayView: UIView!
    
    @IBOutlet weak var displayImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupImageView()
        setupBlurEffectView()
    }
    
    fileprivate func setupBlurEffectView() {
        let blurEffect = UIView(frame: CGRect(x: 35, y: self.displayView.origin.y + 40, width: 45, height: 45), blurEffectStyle: .dark)
        
        self.view.addSubview(blurEffect)
    }
    
    fileprivate func setupImageView() {
        self.tappedImageView.ez_addTarget(self, action: #selector(touchMe))
        
        if let circleImageView = UIImageView(circle: CGRect(x: 240, y: self.tappedImageView.origin.y + 40, width: 60, height: 60)) {
            circleImageView.image = UIImage(named: "original")
            self.view.addSubview(circleImageView)
        }
        
    }
    
    @objc func touchMe() {
        self.tipLabel.text = "选中了"
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

}
