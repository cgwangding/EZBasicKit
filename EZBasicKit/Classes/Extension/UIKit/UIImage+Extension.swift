//
//  UIImage+Extension.swift
//  EZBasicKit
//
//  Created by wangding on 2019/5/24.
//

import Foundation
import UIKit

// MARK: - UIImage compress

extension UIImage {

    public var pngData: Data? {
        return self.pngData()
    }

    public func compress(to kbLength: Int) -> UIImage {

        guard let data = self.pngData else { return self }

        let targetLength = kbLength * 1024
        let totalLength = data.count

        guard targetLength < totalLength else { return self }

        let scale = CGFloat(totalLength - targetLength) / CGFloat(totalLength)

        guard let compressedData = self.jpegData(compressionQuality: scale), let targetImage = UIImage(data: compressedData) else { return self }
        return targetImage
    }
}

// MARK: - 使用颜色创建图片
extension UIImage {

    public convenience init?(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContext(size)
        defer {
            UIGraphicsEndImageContext()
        }

        color.setFill()
        UIRectFill(CGRect(origin: CGPoint.zero, size: size))
        guard let image = UIGraphicsGetImageFromCurrentImageContext(), let cgImage = image.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}

// MARK: - 重新生成一个对应形状的图片
extension UIImage {

    public var circleImage: UIImage? {

        let shotest = min(self.size.width, self.size.height)

        UIGraphicsBeginImageContext(CGSize(width: shotest, height: shotest))

        let ctx = UIGraphicsGetCurrentContext()
        ctx?.addEllipse(in: CGRect(x: 0, y: 0, width: shotest, height: shotest))
        ctx?.clip()
        self.draw(in: CGRect(x: (shotest - self.size.width) / 2, y: (shotest - self.size.height) / 2, width: self.size.width, height: self.size.height))
        defer {
            UIGraphicsEndImageContext()
        }

        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

// MARK: - 裁剪图片
extension UIImage {

    public func cropped(to bounds: CGRect) -> UIImage? {
        guard let imgeRef = self.cgImage?.cropping(to: bounds) else { return nil }
        return UIImage(cgImage: imgeRef)
    }

    public func cropped(toFit targetSize: CGSize) -> UIImage? {

        var widthImage: CGFloat = 0.0
        var heightImage: CGFloat = 0.0
        var rectRatioed: CGRect

        if self.size.height / self.size.width < targetSize.height / targetSize.width {
            // 图片的height过小, 剪裁其width, 而height不变
            heightImage = self.size.height
            widthImage = heightImage * targetSize.width / targetSize.height
            rectRatioed = CGRect(x: (self.size.width - widthImage) / 2, y: 0, width: widthImage, height: heightImage)
        } else {
            // 图片的width过小, 剪裁其height, 而width不变
            widthImage = self.size.width
            heightImage = widthImage * targetSize.height / targetSize.width
            rectRatioed = CGRect(x: 0, y: (self.size.height - heightImage) / 2, width: widthImage, height: heightImage)
        }

        return self.cropped(to: rectRatioed)
    }
}

// MARK: - 镜像图片
extension UIImage {

    public var mirrored: UIImage? {

        let width = self.size.width
        let height = self.size.height

        UIGraphicsBeginImageContext(self.size)
        defer {
            UIGraphicsEndImageContext()
        }

        let context = UIGraphicsGetCurrentContext()
        context?.interpolationQuality = .high

        context?.translateBy(x: width, y: height)
        context?.concatenate(CGAffineTransform(scaleX: -1.0, y: -1.0))
        context?.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: width, height: height))

        guard let imageRef = context?.makeImage() else { return nil }

        return UIImage(cgImage: imageRef)
    }

    public var rotateDregressPI: UIImage? {
        return self.rotated(by: 180)
    }

    public func rotated(by degrees: CGFloat) -> UIImage? {

        let radians = CGFloat(Double.pi) * degrees / 180.0

        // calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox = UIView(frame: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        rotatedViewBox.transform = CGAffineTransform(rotationAngle: radians)

        let rotatedSize = rotatedViewBox.frame.size

        UIGraphicsBeginImageContext(rotatedSize)
        defer {
            UIGraphicsEndImageContext()
        }

        let context = UIGraphicsGetCurrentContext()

        // Move the origin to the middle of the image so we will rotate and.
        context?.translateBy(x: rotatedSize.width / 2.0, y: rotatedSize.height / 2.0)

        // Rotate the image context
        context?.rotate(by: radians)

        // Now, draw the rotated/scaled image into the context
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.draw(self.cgImage!, in: CGRect(x: -self.size.width / 2.0, y: -self.size.height / 2.0, width: self.size.width, height: self.size.height))

        let imageRotated = UIGraphicsGetImageFromCurrentImageContext()

        return imageRotated
    }

    public func scaled(to targetSize: CGSize, withOriginalRatio: Bool = true) -> UIImage? {
        var sizeFinal = targetSize

        if withOriginalRatio {
            let ratioOriginal = self.size.width / self.size.height
            let ratioTemp = targetSize.width / targetSize.height

            if ratioOriginal < ratioTemp {
                sizeFinal.width = targetSize.height * ratioOriginal
            } else if ratioOriginal > ratioTemp {
                sizeFinal.height = targetSize.width / ratioOriginal
            }
        }

        UIGraphicsBeginImageContext(sizeFinal)
        defer {
            UIGraphicsEndImageContext()
        }

        self.draw(in: CGRect(x: 0, y: 0, width: sizeFinal.width, height: sizeFinal.height))

        let imageScaled = UIGraphicsGetImageFromCurrentImageContext()

        return imageScaled
    }

    public func image(with cornerRadius: CGFloat, backgroundColor: UIColor = UIColor.clear) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)

        UIGraphicsBeginImageContext(self.size)
        defer {
            UIGraphicsEndImageContext()
        }

        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()

        backgroundColor.setFill()
        UIRectFill(rect)

        self.draw(in: rect)

        let imageWithCornerRadius = UIGraphicsGetImageFromCurrentImageContext()

        return imageWithCornerRadius!
    }
}

// MARK: - 添加水印
extension UIImage {

    public func addWaterMark(img: UIImage,in rect: CGRect) -> UIImage? {

        UIGraphicsBeginImageContext(self.size)
        self.draw(in: CGRect(origin: CGPoint.zero, size: self.size))
        defer {
            UIGraphicsEndImageContext()
        }
        img.draw(in: rect)

        return UIGraphicsGetImageFromCurrentImageContext()
    }

    public func addWatermarkInCenter(img: UIImage,
                            size: CGSize) -> UIImage? {
        let rect = CGRect(x: (self.size.width - size.width) / 2,
                          y: (self.size.height - size.height) / 2,
                          width: size.width,
                          height: size.height)

        return addWaterMark(img: img, in: rect)
    }

    public func addWatermark(text: String,
                            point: CGPoint,
                            attributes: [NSAttributedString.Key: Any]?) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0)
        self.draw(in: CGRect(origin: CGPoint.zero, size: self.size))
        defer {
            UIGraphicsEndImageContext()
        }

        (text as NSString).draw(at: point, withAttributes: attributes)

        return UIGraphicsGetImageFromCurrentImageContext()
    }

    public func addWatermark(text: String,
                            point: CGPoint,
                            font: UIFont,
                            color: UIColor = .white) -> UIImage? {
        let paraStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paraStyle.alignment = .center
        let attributes = [
            .font: font,
            .paragraphStyle: paraStyle,
            .foregroundColor: color
            ] as [NSAttributedString.Key: Any]
        return addWatermark(text: text, point: point, attributes: attributes)
    }

}

// MARK: - gif data
extension UIImage {

    public static func GIFImage(with gifData: Data) -> UIImage? {

        guard let source = CGImageSourceCreateWithData(gifData as CFData, nil) else {
            return nil
        }

        let count = CGImageSourceGetCount(source)

        var animatedImage: [UIImage] = []

        var totalDuration = 0.0

        for i in 0..<count {
            guard let imageRef = CGImageSourceCreateImageAtIndex(source, i, nil) else {
                return nil
            }
            
            if count == 1 {
                totalDuration = .infinity
            } else {
                totalDuration += self.getFrameDuration(from: source, at: i)
                animatedImage.append(UIImage(cgImage: imageRef))
            }
        }
        
        return UIImage.animatedImage(with: animatedImage, duration: totalDuration)
    }

    static private func getFrameDuration(from gifInfo: [String: Any]?) -> TimeInterval {
        let defaultFrameDuration = 0.1
        guard let gifInfo = gifInfo else { return defaultFrameDuration }
        
        let unclampedDelayTime = gifInfo[kCGImagePropertyGIFUnclampedDelayTime as String] as? NSNumber
        let delayTime = gifInfo[kCGImagePropertyGIFDelayTime as String] as? NSNumber
        let duration = unclampedDelayTime ?? delayTime
        
        guard let frameDuration = duration else { return defaultFrameDuration }
        return frameDuration.doubleValue > 0.011 ? frameDuration.doubleValue : defaultFrameDuration
    }
    
    static private func getFrameDuration(from imageSource: CGImageSource, at index: Int) -> TimeInterval {
        guard let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, index, nil)
            as? [String: Any] else { return 0.0 }
        
        let gifInfo = properties[kCGImagePropertyGIFDictionary as String] as? [String: Any]
        return getFrameDuration(from: gifInfo)
    }
}
