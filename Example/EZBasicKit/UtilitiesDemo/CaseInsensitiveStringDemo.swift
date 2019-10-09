//
//  CaseInsensitiveStringDemo.swift
//  EZBasicKit_Example
//
//  Created by ezbuy on 2019/6/10.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import EZBasicKit

public enum Origin: String {
    case china
    case singpore
    case malaysia
    case thailand
    case pakistan
    case unknown
    
    init(code: String) {
        switch CaseInsensitiveString(code) {
        case "china":
            self = .china
        case "singpore":
            self = .singpore
        case "malaysia":
            self = .malaysia
        case "thailand":
            self = .thailand
        case "pakistan":
            self = .pakistan
        default:
            self = .unknown
        }
    }
}

class CaseInsensitiveStringViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    
    var tag: Int = -100
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func doneButtonDidTapped(_ sender: UIButton) {
        let origin = Origin(code: textField.text ?? "")
        
        let lastRedLabel = view.viewWithTag(tag) as? UILabel
        lastRedLabel?.backgroundColor = UIColor.clear
        
        switch origin {
        case .china:
            tag = 200
        case .singpore:
            tag = 201
        case .malaysia:
            tag = 202
        case .thailand:
            tag = 203
        case .pakistan:
            tag = 204
        default:
            tag = -100
        }
        
        guard tag != -100 else {
//            self.presentAlert(title: "", message: "No such country", buttontitle: "OK")
            return
        }
        
        let currentLabel = view.viewWithTag(tag) as? UILabel
        currentLabel?.backgroundColor = UIColor.red
    }
}
