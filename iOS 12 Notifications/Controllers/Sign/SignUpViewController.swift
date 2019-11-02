//
//  SignUp1ViewController.swift
//  iOS 12 Notifications
//
//  Created by Kirill on 30.10.2019.
//  Copyright © 2019 Andrew Jaffee. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var passwordField: DesignableUITextField!{
        didSet {
            self.passwordField.sideViewdelegate = self
        }
    }
    @IBOutlet weak var phoneNumberField: DesignableUITextField!
    @IBOutlet weak var nameField: DesignableUITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initNavigationBar()
    }
    
    private func initView() {
        phoneNumberField.layer.cornerRadius = phoneNumberField.frame.height / 2
        phoneNumberField.layer.borderColor = UIColor(red:0.37, green:0.45, blue:0.99, alpha:0.2).cgColor
        phoneNumberField.layer.borderWidth = 1
        passwordField.layer.borderColor = UIColor(red:0.37, green:0.45, blue:0.99, alpha:0.2).cgColor
        passwordField.layer.borderWidth = 1
        passwordField.layer.cornerRadius = passwordField.frame.height / 2
        nameField.layer.borderColor = UIColor(red:0.37, green:0.45, blue:0.99, alpha:0.2).cgColor
        nameField.layer.borderWidth = 1
        nameField.layer.cornerRadius = nameField.frame.height / 2
        signupButton.layer.cornerRadius = signupButton.frame.height / 2
        signupButton.setGradientBackground(colorTop: UIColor(red:0.16, green:0.36, blue:0.62, alpha:1.0), colorBottom: UIColor(red:0.02, green:0.76, blue:1.00, alpha:1.0))
    }
    
    private func initNavigationBar() {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        label.text = "Welcome to the exam preparation app"
        navigationItem.titleView = label
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func signupAction(_ sender: Any) {
        guard var login = phoneNumberField.text, let password = passwordField.text, let name = nameField.text, (!login.isEmpty || !password.isEmpty || !name.isEmpty) else {
            showAlert(title: "Empty fields", message: "Incorrect data")
            return
        }
        login = Utils.parsePhoneNumber(phoneNumber: login)
        APIClient.register(name: name, email: login, password: password, complition: {result in
            switch result {
                case .failure(let error):
                    self.showAlert(title: "Error", message: error.localizedDescription)
                case .success:
                    self.performSegue(withIdentifier: "unwindSegueToLoginVC", sender: self)
            }
        })
    }
    
    
    @IBAction func loginAction(_ sender: Any) {
    }
}

extension SignUpViewController : DesignableUITextFieldDelegate {
    func rightViewClick(sender: UIView) {
        if let imageView  = sender as? UIImageView {
            passwordField.isSecureTextEntry = !passwordField.isSecureTextEntry
            if passwordField.isSecureTextEntry {
                imageView.image = UIImage(named: "eye")
            }
            else {
                imageView.image = UIImage(named: "openEye")
            }
        }
    }
}
