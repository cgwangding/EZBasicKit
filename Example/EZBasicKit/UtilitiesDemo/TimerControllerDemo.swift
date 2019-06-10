//
//  TimerControllerDemo.swift
//  EZBasicKit_Example
//
//  Created by ezbuy on 2019/6/10.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import EZBasicKit

class TimerControllerDemoViewController: UIViewController {
    
    var timer: CountDownTimerController?
    
    var backgroundTimer: BackgroundCountDownTimerController?
    
    var showSeconds: Int = 5
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let pageStepTime: DispatchTimeInterval = .seconds(1)
        
        // CountDownTimerController usage
        self.timer = CountDownTimerController(interval: pageStepTime, times: self.showSeconds, handler: { (_, times) in
            //do something
        })
        self.timer?.start()
        
        //BackgroundCountDownTimerController usage
        backgroundTimer = BackgroundCountDownTimerController(interval: .seconds(1), times: showSeconds) { (_, time) in
            //do something
        }
        backgroundTimer?.start()
    }
    
    deinit {
        // CountDownTimerController usage
        timer?.cancel()
        timer = nil
        //BackgroundCountDownTimerController usage
        backgroundTimer?.cancel()
        backgroundTimer = nil
    }
}
