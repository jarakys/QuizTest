//
//  RestoreViewController.swift
//  iOS 12 Notifications
//
//  Created by Kirill on 30.10.2019.
//  Copyright © 2019 Andrew Jaffee. All rights reserved.
//

import UIKit

class RestoreViewController: UIViewController {

    @IBOutlet weak var nameField: DesignableUITextField!
    @IBOutlet weak var phoneNumberField: DesignableUITextField!
    @IBOutlet weak var newPassword: DesignableUITextField! {
           didSet {
               self.newPassword.sideViewdelegate = self
           }
       }
    @IBOutlet weak var restorePasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneNumberField.layer.cornerRadius = phoneNumberField.frame.height / 2
        phoneNumberField.layer.borderColor = UIColor(red:0.37, green:0.45, blue:0.99, alpha:0.2).cgColor
        phoneNumberField.layer.borderWidth = 1
        newPassword.layer.borderColor = UIColor(red:0.37, green:0.45, blue:0.99, alpha:0.2).cgColor
        newPassword.layer.borderWidth = 1
        newPassword.layer.cornerRadius = newPassword.frame.height / 2
        nameField.layer.borderColor = UIColor(red:0.37, green:0.45, blue:0.99, alpha:0.2).cgColor
        nameField.layer.borderWidth = 1
        nameField.layer.cornerRadius = nameField.frame.height / 2
        restorePasswordButton.layer.cornerRadius = restorePasswordButton.frame.height / 2
        restorePasswordButton.setGradientBackground(colorTop: UIColor(red:0.16, green:0.36, blue:0.62, alpha:1.0), colorBottom: UIColor(red:0.02, green:0.76, blue:1.00, alpha:1.0))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        label.text = "Welcome to the exam preparation app"
        navigationItem.titleView = label
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func restorePasswordAction(_ sender: Any) {
    }
}

extension RestoreViewController : DesignableUITextFieldDelegate {
    func rightViewClick(sender: UIView) {
        if let imageView  = sender as? UIImageView {
            newPassword.isSecureTextEntry = !newPassword.isSecureTextEntry
            if newPassword.isSecureTextEntry {
                imageView.image = UIImage(named: "eye")
            }
            else {
                imageView.image = UIImage(named: "openEye")
            }
        }
    }
}
