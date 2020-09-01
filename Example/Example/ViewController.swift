//
//  ViewController.swift
//  Example
//
//  Created by Jeferson Nazario on 31/08/20.
//  Copyright © 2020 jnazario.com. All rights reserved.
//

import UIKit
import BraspagVerifyCard

class ViewController: UITableViewController {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtCvv: UITextField!
    @IBOutlet weak var txtBrand: UITextField!
    
    @IBOutlet weak var swDebit: UISwitch!
    @IBOutlet weak var swCredit: UISwitch!
    
    @IBOutlet weak var btnTest: UIButton!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var txtResult: UITextView!
    
    private var sdk: VerifyCardProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sdk = VerifyCard.instantiate(merchantId: "MERCHANT-ID",
                                     clientId: "CLIENT-ID",
                                     clientSecret: "CLIENT-SECRET",
                                     environment: .sandbox)
    }

    @IBAction func swChanged(sender: UISwitch) {
        swDebit.isOn = sender.tag == 1 ? sender.isOn : !sender.isOn
        swCredit.isOn = sender.tag == 2 ? sender.isOn : !sender.isOn
    }
    
    @IBAction func validateCard(sender: UIButton) {
        let cardType = swDebit.isOn ? CardType.DebitCard : CardType.CreditCard
        
        let card = Card(cardNumber: txtCardNumber.text,
                        holder: txtName.text,
                        expirationDate: txtDate.text,
                        securityCode: txtCvv.text,
                        brand: txtBrand.text,
                        type: cardType)
        let request = VerifyCardRequest(provider: "Cielo30", card: card)
        sdk.verify(request: request) { (response) in
            
        }
    }

}

