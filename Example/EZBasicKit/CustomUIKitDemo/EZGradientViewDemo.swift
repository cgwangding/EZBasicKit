//
//  EZGradientViewDemo.swift
//  EZBasicKit_Example
//
//  Created by ezbuy on 2019/7/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import EZBasicKit

class EZGradientViewDemo: UIViewController {

    @IBOutlet weak var gradientView1: EZGradientView!
    @IBOutlet weak var gradientView2: EZGradientView!
    @IBOutlet weak var gradientView3: EZGradientView!
    @IBOutlet weak var gradientView4: EZGradientView!
    @IBOutlet weak var gradientView5: EZGradientView!
    @IBOutlet weak var gradientView6: EZGradientView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //gradientView with different type
        let colorArr = [UIColor(0xfff6b7), UIColor(0xf6416c)]
        gradientView1.gradientColors = colorArr
        gradientView2.gradientColors = colorArr
        gradientView3.gradientColors = colorArr
        
        if #available(iOS 12.0, *) {
            gradientView2.type = .conic
            gradientView3.type = .radial
        } else {
            // Fallback on earlier versions
        }
        
        //gradientView with different start point and end point
        gradientView4.gradientColors = colorArr
        gradientView4.startPoint = CGPoint(x: 0, y: 0)
        gradientView4.endPoint = CGPoint(x: 1, y: 1)
        
        //gradientView with three colors and different locations
        let colorArr1 = [UIColor(0x12c2e9), UIColor(0xc471ed), UIColor(0xf64f59)]
        gradientView5.gradientColors = colorArr1
        gradientView6.gradientColors = colorArr1
        gradientView6.locations = [0.25,0.5,0.75]
    }
}
