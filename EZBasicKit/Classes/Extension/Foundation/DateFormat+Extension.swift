//
//  DateFormat+Extension.swift
//  EZBasicKit
//
//  Created by wangding on 2019/5/24.
//

import Foundation

extension TimeInterval {

    public func formattedTime(_ format: String = "dd/MM/YYYY HH:mm") -> String {

        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: Date(timeIntervalSince1970: self))
    }
}

extension Int64 {

    public func formattedTime(_ format: String = "dd/MM/YYYY HH:mm") -> String {

        let timeInterval = TimeInterval(self.isUnixTimeStamp ? self : self.unixTimeStamp)

        return timeInterval.formattedTime(format)
    }

    public var unixTimeStamp: Int64 {
        return self / 1000
    }

    public var isUnixTimeStamp: Bool {
        return self < Int64(1e11)
    }
}
