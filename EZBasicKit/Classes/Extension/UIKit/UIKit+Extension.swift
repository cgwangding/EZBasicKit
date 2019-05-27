//
//  UIKit+Extension.swift
//  EZBasicKit
//
//  Created by wangding on 2019/5/24.
//

import Foundation

// MARK: - UIImage

extension UIImage {

    func compress(to kbLength: Int) -> UIImage {

        guard let data = self.pngData() else { return self }

        let targetLength = kbLength * 1024
        let totalLength = data.count

        guard targetLength < totalLength else { return self }

        let scale = CGFloat(totalLength - targetLength) / CGFloat(totalLength)

        guard let compressedData = self.jpegData(compressionQuality: scale), let targetImage = UIImage(data: compressedData) else { return self }
        return targetImage
    }

}
