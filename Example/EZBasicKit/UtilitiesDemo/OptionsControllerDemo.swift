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

class CardsDataViewController: UITableViewController {
    
    var controller: CardsDataController?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //load credit card data and assign to controllr
        self.controller = CardsDataController(cards: [])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelection = false
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller?.cardsController?.options.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CardsDataCell = tableView.dequeueReusableCell(withIdentifier: CardsDataCell.id, for: indexPath) as! CardsDataCell
        let option = controller?.cardsController?.options.object(at: indexPath.row)
        cell.cardInfo = option
        cell.setSelected(option == controller?.cardsController?.selectedOption, animated: false)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        controller?.cardsController?.selectedOption = controller?.cardsController?.options.object(at: indexPath.row)
    }
}

class CardsDataCell: UITableViewCell {
    
    static let id = "CardsDataCell"
    
    var cardInfo: CreditCard? {
        didSet{
            self.updateCell(info: self.cardInfo)
        }
    }
    
    lazy var selectButton: UIButton = {
        let b = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        return b
    }()
    
    func updateCell(info: CreditCard?) {
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectButton.isSelected = selected
    }
}
