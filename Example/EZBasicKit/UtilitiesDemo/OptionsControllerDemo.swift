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

public class CreditCard: NSObject, Identifiable {
    
    public var identifier: String {
        return self.cardNum
    }
    
    public let cardNum: String
    
    public init(num: String) {
        self.cardNum = num
        super.init()
    }
    
    public override var hash: Int {
        return self.nsHashValue
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        return self.nsIsEqual(object)
    }
}

class CardsDataViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var controller: CardsDataController?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //load credit card data and assign to controllr
        let card1 = CreditCard(num: "4242424242424242")
        let card2 = CreditCard(num: "4444000000000000")
        let card3 = CreditCard(num: "5555555555556666")
        self.controller = CardsDataController(cards: [card1, card2, card3])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CardsDataViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller?.cardsController?.options.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CardsDataCell = tableView.dequeueReusableCell(withIdentifier: CardsDataCell.id, for: indexPath) as! CardsDataCell
        let option = controller?.cardsController?.options.object(at: indexPath.row)
        cell.cardInfo = option
        cell.setSelected(option == controller?.cardsController?.selectedOption, animated: false)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var cardNumLabel: UILabel!
    
    func updateCell(info: CreditCard?) {
        
        if let num = info?.cardNum.dropLast(4) {
            self.cardNumLabel.text = "**** " + num
        } else {
            self.cardNumLabel.text = nil
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectButton.isSelected = selected
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cardInfo = nil
    }
}
