//
//  CircleImageView.swift
//  ezbuy
//
//  Created by Arror on 16/1/28.
//  Copyright © 2016年 com.ezbuy. All rights reserved.
//

import UIKit

public class CircleImageView: UIImageView {

    override public func layoutSubviews() {
        super.layoutSubviews()

        let bounds = self.bounds

        let layer = self.layer

        layer.cornerRadius = min(bounds.size.width, bounds.size.height) / 2.0
        layer.masksToBounds = true
    }

}
