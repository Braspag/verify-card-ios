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
        
        txtName.text = "Nome de teste"
        txtCardNumber.text = "1234123412341234"
        txtDate.text = "11/2025"
        txtCvv.text = "987"
        txtBrand.text = "Visa"
        
        sdk = VerifyCard.instantiate(merchantId: "2A946384-03CB-4A38-A930-0A252B403380",
                                     clientId: "eeb1230a-d756-4bc4-bf92-87ce18a00d2f",
                                     clientSecret: "RdhID4KOY1HsSsuCFU3pmtJO2DhYqwJo5xNkxNATOh8=",
                                     environment: .sandbox)
    }

    @IBAction func swChanged(sender: UISwitch) {
        swDebit.isOn = sender.tag == 1 ? sender.isOn : !sender.isOn
        swCredit.isOn = sender.tag == 2 ? sender.isOn : !sender.isOn
    }
    
    @IBAction func validateCard(sender: UIButton) {
        self.view.endEditing(true)
        
        txtResult.text = ""
        loading.startAnimating()
        btnTest.setTitle("", for: .normal)
        
        let cardType = swDebit.isOn ? CardType.DebitCard : CardType.CreditCard
        
        let card = Card(cardNumber: txtCardNumber.text,
                        holder: txtName.text,
                        expirationDate: txtDate.text,
                        securityCode: txtCvv.text,
                        brand: txtBrand.text,
                        type: cardType)
        let request = VerifyCardRequest(provider: "Cielo30", card: card)
        sdk.verify(request: request) { (response) in
            DispatchQueue.main.async {
                self.stopLoading()
                do {
                    let jsonData = try JSONEncoder().encode(response)
                    let json = String(data: jsonData, encoding: .utf8)
                    
                    self.txtResult.text = json
                    
                } catch let ex {
                    self.txtResult.text = ex.localizedDescription
                }
                
                self.tableView.scrollToRow(at: IndexPath(item: 5, section: 0), at: .top, animated: true)
            }
        }
    }
    
    func stopLoading() {
        self.loading.stopAnimating()
        btnTest.setTitle("Testar", for: .normal)
    }
}

