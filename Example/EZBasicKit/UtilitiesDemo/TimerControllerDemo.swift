//
//  TimerControllerDemo.swift
//  EZBasicKit_Example
//
//  Created by ezbuy on 2019/6/10.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import EZBasicKit

enum TimerControllerType {
    case countDownTimerController
    case backgroundCountDownTimerController
}

class TimerControllerDemoViewController: UIViewController {
    
    var timer: CountDownTimerController?
    
    var backgroundTimer: BackgroundCountDownTimerController?
    
    var leftTime: Int = 24 * 3600
    
    @IBOutlet weak var countDownTimerControllerLabel: UILabel!
    
    @IBOutlet weak var backgroundCountDownTimerControllerLabel: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let pageStepTime: DispatchTimeInterval = .seconds(1)
        
        // CountDownTimerController usage
        self.timer = CountDownTimerController(interval: pageStepTime, times: self.leftTime, handler: { (_, time) in
            self.countdown(time: Int64(time), type: .countDownTimerController)
        })
        self.timer?.start()
        
        //BackgroundCountDownTimerController usage
        backgroundTimer = BackgroundCountDownTimerController(interval: .seconds(1), times: leftTime) { (_, time) in
            self.countdown(time: Int64(time), type: .backgroundCountDownTimerController)
        }
        backgroundTimer?.start()
    }
    
    func countdown(time: Int64, type: TimerControllerType) {
        
        guard time > 0 else {  timer?.cancel(); timer = nil; return }
        
        let date = Date(timeIntervalSinceNow: TimeInterval(time))
        
        let components = NSCalendar.current.dateComponents([.day, .hour, .minute, .second], from: Date(), to: date)
        
        let day = components.day ?? 0
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        let second = components.second ?? 0
        
        
        let timerStr: String = {
            
            let dayStr = "\(day) \(day > 1 ? "Days  " : "Day  ")"
            let hourStr = TimerControllerDemoViewController.dateFormat(hour)
            let minuteStr = TimerControllerDemoViewController.dateFormat(minute)
            let secondStr = TimerControllerDemoViewController.dateFormat(second)
            
            var dateStr = hourStr + " : " + minuteStr + " : " + secondStr
            
            if day > 0 {
                dateStr = dayStr + dateStr
            }
            
            return dateStr
        }()
        
        switch type {
        case .countDownTimerController:
            self.countDownTimerControllerLabel.text = timerStr
        case .backgroundCountDownTimerController:
            self.backgroundCountDownTimerControllerLabel.text = timerStr
        }
    }
    
    deinit {
        // CountDownTimerController usage
        timer?.cancel()
        timer = nil
        //BackgroundCountDownTimerController usage
        backgroundTimer?.cancel()
        backgroundTimer = nil
    }
    
    class func dateFormat(_ ls: Int?, rs: String? = nil) -> String {
        
        let l: String = {
            guard let count = ls , count >= 0 else { return "-" }
            
            return String(format: "%02d", count)
        }()
        
        let r: String = {
            
            guard let des = rs else { return "" }
            
            return (ls ?? 0) > 0 ? (des + "s") : des
        }()
        
        return l + r
    }
}
