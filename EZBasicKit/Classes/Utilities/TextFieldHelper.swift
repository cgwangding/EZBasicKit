//
//  TextFieldHelper.swift
//  ezbuy
//
//  Created by Rocke on 16/3/30.
//  Copyright © 2016年 com.ezbuy. All rights reserved.
//

import UIKit

open class TextFieldHelper: NSObject, UITextFieldDelegate {

    open func setText(_ text: String?, forTextField textField: UITextField) {
    }

    @objc open func adjustedTextFromTextField(_ textField: UITextField) -> String? {
        return textField.text
    }

    func isAvailableIfAdjustParametersFromText(_ text: NSString, range: inout NSRange, replacementString: inout NSString) -> Bool {
        return true
    }

    func adjustText(_ text: inout NSString, caretPosition: inout Int) -> Bool {
        return false
    }

    open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let text: NSString = textField.text as NSString? ?? ""
        var repalcedRange: NSRange = range
        var replacementString: NSString = string as NSString

        guard self.isAvailableIfAdjustParametersFromText(text, range: &repalcedRange, replacementString: &replacementString) else { return false }

        var futureText: NSString = text.replacingCharacters(in: repalcedRange, with: replacementString as String) as NSString
        var caretPosition: Int = repalcedRange.location + replacementString.length

        let adjusted = self.adjustText(&futureText, caretPosition: &caretPosition)

        if !adjusted {
            return true
        } else {
            textField.text = futureText as String
            let newPosition = textField.position(from: textField.beginningOfDocument, offset: caretPosition)!
            textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
            textField.sendActions(for: .editingChanged)
            return false
        }
    }
}

public let NonDigitCharacterSet: CharacterSet = {
    let aSet = NSMutableCharacterSet.decimalDigit()
    aSet.invert()
    return aSet as CharacterSet
}()

open class PhoneNumberTextFieldHelper: TextFieldHelper {

    let lengthLimit: Int

    let decorators: [(string: NSString, range: NSRange)]

    let tolerancePrefix: String?

    public init(lengthLimit: Int? = nil, decorators: [(string: NSString, location: Int)]? = nil, tolerancePrefix: String? = nil) {

        var accl = 0
        self.decorators = decorators?.map({
            let string = $0.string
            let location = $0.location
            let length = string.length
            let val = (string: $0.string, range: NSRange(location: (accl + location), length: length))
            accl += length
            return val
        }) ?? []

        self.lengthLimit = {
            if let limit = lengthLimit {
                return limit + accl
            } else {
                return NSIntegerMax
            }
        }()

        self.tolerancePrefix = tolerancePrefix

        super.init()
    }

    fileprivate enum EditingType: Int {
        case insert
        case delete
        case paste

        init(range: NSRange, replacementString: NSString) {
            if range.length == 0 && replacementString.length == 1 {
                self = .insert
            } else if range.length == 1 && replacementString.length == 0 {
                self = .delete
            } else {
                self = .paste
            }
        }
    }

    open override func setText(_ text: String?, forTextField textField: UITextField) {
        if let text = text {
            var str = text as NSString
            str = self.adjustedWholeText(str)
            var caret = str.length
            self.adjustText(&str, caretPosition: &caret)
            textField.text = str as String
        } else {
            textField.text = nil
        }
    }

    @objc open override func adjustedTextFromTextField(_ textField: UITextField) -> String? {
        if let text = textField.text, let prefix = self.tolerancePrefix {
            return prefix + " " + text
        } else {
            return textField.text
        }
    }

    override func isAvailableIfAdjustParametersFromText(_ text: NSString, range: inout NSRange, replacementString: inout NSString) -> Bool {

        func onlyContainNonDigitsInText(_ text: NSString) -> Bool {
            return text.numberOfCharactersInCharacterSet(NonDigitCharacterSet) == text.length
        }

        func deletingRangeOfDecoratorInLocation(_ location: Int) -> NSRange? {

            for case let (_, range) in self.decorators {
                if NSMaxRange(range) == location {
                    return range
                }
            }
            return nil
        }

        let edittingType = EditingType(range: range, replacementString: replacementString)

        switch edittingType {
        case .insert:
            if onlyContainNonDigitsInText(replacementString) {
                return false
            } else {
                let overflow = text.length >= self.lengthLimit
                return !overflow
            }
        case .delete:
            if let deletingDecoratorRange = deletingRangeOfDecoratorInLocation(NSMaxRange(range)) {
                if deletingDecoratorRange.location > 0 {
                    range = NSMakeRange(deletingDecoratorRange.location - 1, deletingDecoratorRange.length + 1)
                }
                return true
            } else {
                return true
            }
        case .paste:
            if replacementString.length == 0 {
                return true
            } else if onlyContainNonDigitsInText(replacementString) {
                return false
            } else if text.length == range.length {

                replacementString = self.adjustedWholeText(replacementString)

                return true
            } else {
                return true
            }
        }
    }

    func adjustedWholeText(_ text: NSString) -> NSString {
        var reval = text.stringByRemovingCharactersInCharacterSet(NonDigitCharacterSet)

        if let prefix = self.tolerancePrefix?.stringByRemovingCharactersInCharacterSet(NonDigitCharacterSet) , reval.hasPrefix(prefix) {
            reval = reval.substring(from: prefix.utf16.count) as NSString
        }

        return reval
    }

    @discardableResult
    override func adjustText(_ text: inout NSString, caretPosition: inout Int) -> Bool {

        caretPosition -= text.numberOfCharactersInCharacterSet(NonDigitCharacterSet, inRange: NSRange(location: 0, length: caretPosition))
        text = text.stringByRemovingCharactersInCharacterSet(NonDigitCharacterSet)

        text = self.textByAddingDecoratorsFromText(text, caretPosition: &caretPosition)

        if text.length > self.lengthLimit {
            text = text.substring(to: self.lengthLimit) as NSString
            caretPosition = min(self.lengthLimit, caretPosition)
        }

        return true
    }

    func textByAddingDecoratorsFromText(_ text: NSString, caretPosition: inout Int) -> NSString {
        let mutableString = NSMutableString(string: text)
        for case let(decorater, range) in self.decorators {
            if mutableString.length >= range.location {
                if caretPosition >= range.location {
                 caretPosition += range.length
                }
                mutableString.insert(decorater as String, at: range.location)

            }
        }
        return mutableString
    }
}

extension NSString {

    fileprivate func numberOfCharactersInCharacterSet(_ aSet: CharacterSet, inRange nsrange: NSRange? = nil) -> Int {

        let nsrange = nsrange ?? NSRange(location: 0, length: self.length)
        guard let range = nsrange.toCountableRange() else { return 0 }

        return range.map({ self.character(at: $0)}).reduce(0) { val, character in

            if let scalar = UnicodeScalar(character), aSet.contains(scalar) {
                return val + 1
            } else {
                return val
            }
        }
    }
}

extension String {

    public func stringByRemovingCharactersInCharacterSet(_ aSet: CharacterSet) -> String {

        return (self as NSString).stringByRemovingCharactersInCharacterSet(aSet) as String
    }
}

extension NSMutableString {

    public func removeCharactersInCharacterSet(_ aSet: CharacterSet) {

        var searchRange = NSRange(location: 0, length: self.length)

        while searchRange.length != 0 {
            let foundRange = self.rangeOfCharacter(from: aSet, options: [], range: searchRange)
            if foundRange.location == NSNotFound {
                searchRange = NSRange(location: NSMaxRange(searchRange), length: 0)
            } else {
                self.deleteCharacters(in: foundRange)
                searchRange = NSRange(location: foundRange.location, length: NSMaxRange(searchRange) - NSMaxRange(foundRange))
            }

        }
    }
}
extension NSString {

    public func stringByRemovingCharactersInCharacterSet(_ aSet: CharacterSet) -> NSString {

        let mutableString = NSMutableString(string: self)
        mutableString.removeCharactersInCharacterSet(aSet)
        return mutableString
    }
}

extension NSRange {

    public func toCountableRange() -> CountableRange<Int>? {
        if self.location != NSNotFound {
            return self.location..<(NSMaxRange(self))
        } else {
            return nil
        }
    }
}
