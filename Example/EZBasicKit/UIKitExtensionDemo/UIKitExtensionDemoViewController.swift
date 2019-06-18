//
//  UIKitExtensionDemoViewController.swift
//  EZBasicKit_Example
//
//  Created by qiuming on 2019/6/12.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import EZBasicKit

class UIKitExtensionDemoViewController: UIViewController {
    
    @IBOutlet weak var intervalButton: UIButton!
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var enlargeInsetBtn: UIButton!
    
    @IBOutlet weak var hexColorLabel: UILabel!
    
    @IBOutlet weak var randomLabel: UILabel!

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var originImageView: UIImageView!
    
    @IBOutlet weak var compressImageView: UIImageView!
    
    @IBOutlet weak var circleImageView: UIImageView!
    
    @IBOutlet weak var gifImageView: UIImageView!
    
    @IBOutlet weak var water1ImageView: UIImageView!
    
    @IBOutlet weak var water2ImageView: UIImageView!
    
    @IBOutlet weak var water3ImageView: UIImageView!
    
    @IBOutlet weak var water4ImageView: UIImageView!
    
    
    
    @IBOutlet weak var croppedImageView: UIImageView!
    
    @IBOutlet weak var cropped2ImageView: UIImageView!
    
    
    @IBOutlet weak var colorImageView: UIImageView!
    
    
    fileprivate var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.setupTimeIntervalButton()
        self.setupEnlargeInsetBtn()
        self.setupColor()
        self.setupImage()
        self.waterImage()
    }
}



// UIImage+Extension
extension UIKitExtensionDemoViewController {
    
    fileprivate func setupImage() {
        compressImage()
//        colorImage()
        creatCircleImage()
        croppedImage()
        gifImage()
        waterImage()
    }
    
    /// - gif 图片
    private func gifImage() {
        guard let path = Bundle.main.path(forResource: "joy", ofType: "gif"), let data = NSData(contentsOfFile: path) as Data? else { return }
        
        self.gifImageView.image = UIImage.GIFImage(with: data)
    }
    
    /// - 添加水印
    private func waterImage() {
        
        self.water1ImageView.image = UIImage(named: "original")!.addWaterMark(img: UIImage(named: "hot")!, in: self.water1ImageView.bounds)

        self.water2ImageView.image = UIImage(named: "original")!.addWatermarkInCenter(img: UIImage(named: "hot")!, size: CGSize(width: 60, height: 60))

        self.water3ImageView.image = UIImage(named: "original")!.addWatermark(text: "版本所有", point: self.water3ImageView.center, attributes: [NSAttributedString.Key.foregroundColor: UIColor.green])
        
        self.water4ImageView.image = UIImage(named: "original")!.addWatermark(text: "翻版必究", point: self.water4ImageView.center, font: UIFont.systemFont(ofSize: 16))
    }
    
    private func creatMirroredImage() {
        
    }
    
    private func croppedImage() {
        
    }
    
    private func creatCircleImage() {
        self.circleImageView.image = UIImage(named: "original")?.circleImage
    }
    
    private func colorImage() {
        self.colorImageView.image = UIImage(color: UIColor.green, size: CGSize(width: 60, height: 60))
    }
    
    private func compressImage() {
        self.compressImageView.image = UIImage(named: "original")!.compress(to: 100)
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
