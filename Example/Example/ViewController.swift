//
//  ViewController.swift
//  Example
//
//  Created by Jeferson Nazario on 31/08/20.
//  Copyright © 2020 jnazario.com. All rights reserved.
//

import UIKit
import BraspagVerifyCard

class ViewController: UIViewController {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtCvv: UITextField!
    
    @IBOutlet weak var btnTest: UIButton!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var txtResult: UITextView!
    
    private var sdk: VerifyCardProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sdk = VerifyCard.instantiate(accessToken: "", merchantId: "", clientId: "", clientSecret: "", environment: .sandbox) as! VerifyCardProtocol
    }


}

