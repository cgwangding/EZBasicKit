//
//  ObjectsControllerBaseDemo.swift
//  EZBasicKit_Example
//
//  Created by ezbuy on 2019/6/21.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import EZBasicKit

class ObjectsControllerBaseDemoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate let controller = CreditCardController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadData()
    }
    
    fileprivate func loadData() {
        
        let processing = controller.reload(completion: { (_) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            }
            
        }, failure: { (error) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.activityIndicator.stopAnimating()
            }
        })
        
        if processing {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
    }
}

extension ObjectsControllerBaseDemoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let card = controller.objects.object(at: indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreditCardInfo", for: indexPath)
        
        if let cardNum = card?.cardNum.dropLast(4) {
            cell.textLabel?.text = "**** " + cardNum
        }
        
        return cell
    }
}

class CreditCardController: ObjectsControllerBase<CreditCard> {
    
    override func reload(completion: @escaping ([CreditCard]) -> Void, failure: @escaping (Error) -> Void) -> Bool {
        // request server to load credit card data
        
        let result: Bool = true //request result
        
        if result {
            let card1 = CreditCard(num: "4242424242424242")
            let card2 = CreditCard(num: "4444000000000000")
            let card3 = CreditCard(num: "5555555555556666")
            self.objects = [card1, card2, card3]
            completion(self.objects)
        } else {
            //failure(Error)
        }
        
        return true
    }
}
