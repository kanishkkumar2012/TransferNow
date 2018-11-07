//
//  ViewController.swift
//  TransferNow
//
//  Created by Kanishk KUMAR on 10/30/18.
//  Copyright © 2018 Kanishk KUMAR. All rights reserved.
//

import UIKit

class TransferMoneyViewController: UIViewController {

    // MARK: - Properties
    var apiManager: APIManager!
    let errorTitle = NSLocalizedString("Error", comment: "Error")
    let okBtnTitle = NSLocalizedString("OK", comment: "OK")
    var isSuccessResponse: Bool = false

    @IBOutlet weak var fromAccountNumberTextField: UITextField!
    @IBOutlet weak var toAccountNumberTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var SendBtn: UIButton!

    // MARK: - ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitials()
    }

    // MARK: - Instance Methods
    func setupInitials() {
        self.apiManager = APIManager()
    }

    // MARK: - Actions Methods
    @IBAction func onClickSend(_ sender: Any) {

        guard let amount = self.amountTextField.text?.numberValue, let fromAccountNumber = self.fromAccountNumberTextField.text?.numberValue, let toAccountNumber = self.toAccountNumberTextField.text?.numberValue else {
            self.isSuccessResponse = false
            return
        }

        self.apiManager.initMoneyTransfer(amount: amount as! Int, fromAccountNumber: fromAccountNumber as! Int, toAccountNumber: toAccountNumber as! Int) { (response, error) in

            guard response != nil else {
                //API Response Failed, Show Error Message to User.
                DispatchQueue.main.async {
                    self.presentAlertWithTitle(title: self.errorTitle, message: error!, options: self.okBtnTitle, completion: {_ in })
                }
                return
            }
            self.isSuccessResponse = true
        }
    }

    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if let ident = identifier {
            if ident == "TransferSuccessViewController" {
                if isSuccessResponse != true {
                    //API Response Failed, Show Error Message to User.
                    DispatchQueue.main.async {
                        self.presentAlertWithTitle(title: self.errorTitle, message: "Please enter a valid inputs", options: self.okBtnTitle, completion: {_ in })
                    }
                    return false
                }
            }
        }
        return true
    }
}

extension String {
    var numberValue:NSNumber? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: self)
    }
}
