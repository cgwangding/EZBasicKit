//
//  TimerController.swift
//  ezbuy
//
//  Created by 张鹏 on 16/10/21.
//  Copyright © 2016年 com.ezbuy. All rights reserved.
//

import Foundation

public class TimerController {

    private enum State {
        case resumed
        case suspend
        case cancel
    }
    
    private var state: State = .suspend
    
    private let internalTimer: DispatchSourceTimer

    public typealias TimerControllerHandler = (TimerController) -> Void

    private var handler: TimerControllerHandler

    public init(interval: DispatchTimeInterval, queue: DispatchQueue = .main , handler: @escaping TimerControllerHandler) {

        self.handler = handler
        internalTimer = DispatchSource.makeTimerSource(queue: queue)
        internalTimer.setEventHandler { [weak self] in
            if let strongSelf = self {
                handler(strongSelf)
            }
        }
        internalTimer.schedule(deadline: .now() + interval, repeating: interval)
    }

    public static func repeaticTimer(interval: DispatchTimeInterval, queue: DispatchQueue = .main , handler: @escaping TimerControllerHandler ) -> TimerController {
        return TimerController(interval: interval, queue: queue, handler: handler)
    }

    deinit {
        
        if state == .suspend {
            self.internalTimer.resume()
        }
        self.internalTimer.cancel()
    }

    public func start() {
        if state == .resumed {
            return
        }
        state = .resumed
        internalTimer.resume()
    }
    
    public func suspend() {
        if state == .suspend {
            return
        }
        state = .suspend
        internalTimer.suspend()
    }

    public func cancel() {
        if state == .cancel {
            return
        }
        state = .cancel
        internalTimer.cancel()
    }

    public func rescheduleRepeating(interval: DispatchTimeInterval) {
        internalTimer.schedule(deadline: .now() + interval, repeating: interval)
    }

    public func rescheduleHandler(handler: @escaping TimerControllerHandler) {
        self.handler = handler
        internalTimer.setEventHandler { [weak self] in
            if let strongSelf = self {
                handler(strongSelf)
            }
        }
    }
}

//MARK: Count Down
public class CountDownTimerController {

    fileprivate let internalTimer: TimerController

    fileprivate var leftTimes: Int

    private let originalTimes: Int

    private let handler: (CountDownTimerController, _ leftTimes: Int) -> Void

    public init(interval: DispatchTimeInterval, times: Int,queue: DispatchQueue = .main , handler:  @escaping (CountDownTimerController, _ leftTimes: Int) -> Void ) {

        self.leftTimes = times
        self.originalTimes = times
        self.handler = handler
        self.internalTimer = TimerController.repeaticTimer(interval: interval, queue: queue, handler: { _ in
        })
        self.internalTimer.rescheduleHandler { [weak self]  (_) in
            if let strongSelf = self {
                if strongSelf.leftTimes > 0 {
                    strongSelf.leftTimes = strongSelf.leftTimes - 1
                    strongSelf.handler(strongSelf, strongSelf.leftTimes)
                } else {
                    strongSelf.internalTimer.cancel()
                }
            }
        }
    }

    public func start() {
        self.internalTimer.start()
    }

    public func cancel() {
        self.internalTimer.cancel()
    }

    public func reCountDown() {
        self.leftTimes = self.originalTimes
    }
}

public class BackgroundCountDownTimerController: CountDownTimerController {
    
    private var startTime: CFAbsoluteTime = 0.0
    
    public override init(interval: DispatchTimeInterval, times: Int, queue: DispatchQueue = .main, handler: @escaping (CountDownTimerController, _ leftTimes: Int) -> Void) {
        super.init(interval: interval, times: times, queue: queue, handler: handler)
        
        NotificationCenter.default.addObserver(forName: UIApplication.willResignActiveNotification, object: nil, queue: nil) { [weak self] _ in
            guard let strongSelf = self else { return }

            strongSelf.startTime = CFAbsoluteTimeGetCurrent()
        }
        
        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: nil) { [weak self] _ in
            guard let strongSelf = self else { return }
            
            strongSelf.leftTimes -= Int(ceil(CFAbsoluteTimeGetCurrent() - strongSelf.startTime))
            strongSelf.startTime = 0.0
        }
    }
}
