//
//  OptionsControllerDemo.swift
//  EZBasicKit_Example
//
//  Created by ezbuy on 2019/6/10.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import EZBasicKit

public class CardsDataController: NSObject {
    
    public var cardsController: OptionsController<CreditCard>?

    public init(cards: [CreditCard]) {
        self.cardsController = OptionsController<CreditCard>(options: cards)
    }
}

public class CreditCard: NSObject {
    
}
