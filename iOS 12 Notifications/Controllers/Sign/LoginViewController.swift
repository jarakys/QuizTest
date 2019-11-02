//
//  Login1ViewController.swift
//  iOS 12 Notifications
//
//  Created by Kirill on 29.10.2019.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loginTextField: DesignableUITextField!
    @IBOutlet weak var passwordTextField: DesignableUITextField! {
        didSet {
            self.passwordTextField.sideViewdelegate = self
        }
    }
    @IBOutlet weak var loginButton: UIButton!
    private var storage: LocalStorageProtocol = LocalStorage()
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initNavigationBar()
    }
    
    private func initView() {
        loginTextField.layer.cornerRadius = loginTextField.frame.height / 2
        passwordTextField.layer.cornerRadius = passwordTextField.frame.height / 2
        loginTextField.layer.borderColor = UIColor(red:0.37, green:0.45, blue:0.99, alpha:0.2).cgColor
        loginTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor(red:0.37, green:0.45, blue:0.99, alpha:0.2).cgColor
        passwordTextField.layer.borderWidth = 1
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        loginButton.setGradientBackground(colorTop: UIColor(red:0.16, green:0.36, blue:0.62, alpha:1.0), colorBottom: UIColor(red:0.02, green:0.76, blue:1.00, alpha:1.0))
    }
    
    private func initNavigationBar() {
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.prefersLargeTitles = true
            navigationBar.isTranslucent = false
            let style = NSMutableParagraphStyle()
            style.firstLineHeadIndent = 30
            let gradient = CAGradientLayer()
            var bounds = navigationBar.bounds
            bounds.size.height += UIApplication.shared.statusBarFrame.size.height
            gradient.frame = bounds
            gradient.colors = [UIColor(red:0.07, green:0.21, blue:0.47, alpha:1.0).cgColor, UIColor(red:0.16, green:0.36, blue:0.62, alpha:1.0).cgColor]
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 1, y: 1)
            if let image = Utils.getImageFrom(gradientLayer: gradient) {
                if #available(iOS 13.0, *) {
                    let largeTitleBackground = UINavigationBarAppearance()
                    largeTitleBackground.backgroundColor = UIColor(patternImage: image)
                    largeTitleBackground.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
                    let titleColor = UIColor(red:0.34, green:0.84, blue:1.00, alpha:1.0)
                    let font:UIFont = .systemFont(ofSize: 40)
                    largeTitleBackground.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor, NSAttributedString.Key.backgroundColor: UIColor.clear, NSAttributedString.Key.paragraphStyle : style, NSAttributedString.Key.font: font]
                    navigationBar.scrollEdgeAppearance = largeTitleBackground
                } else {
                }
                let label = UILabel()
                label.textColor = .white
                label.font = .systemFont(ofSize: 18)
                label.text = "Welcome to the exam preparation app"
                navigationItem.titleView = label
                navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            }
        }
    }
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {
    }
    
    @IBAction func loginAction(_ sender: Any) {
        guard var login = loginTextField.text, let password = passwordTextField.text, (!login.isEmpty || !password.isEmpty) else {
            showAlert(title: "Empty fields", message: "Incorrect data")
            return
        }
        login = Utils.parsePhoneNumber(phoneNumber: login)
        APIClient.login(email: login, password: password, complition: { result in
            switch result {
                case .failure(let error):
                    self.showAlert(title: "Error", message: error.localizedDescription)
                case .success(let user):
                    self.storage.writeStoreable(key: Keys.User, value: user)
                    self.getQuestions()
            }
        })
    }
    
    private func getQuestions() {
        let count = try! CoreDataManager.instance.managedObjectContext.count(for: Question.fetchRequest())
        APIClient.getQuestions(startIndex: count, complition: {result in
            if let questions = try? result.get(){
                for question in questions {
                    print(question.answers.count)
                    let questionCoreData = Question(context: CoreDataManager.instance.managedObjectContext)
                    questionCoreData.correctAnswerText = question.correctAnswerText
                    questionCoreData.text = question.text
                    questionCoreData.idQuestion = question.idQuestion
                    var answersModel:[AnswerDatabaseModel] = []
                    for (index,answer) in question.answers.enumerated() {
                        let answerDb =  AnswerDatabaseModel(key: CaseKey(rawValue: index)!.string(), text: answer)
                        answersModel.append(answerDb)
                    }
                    questionCoreData.answers = Answers(answers: answersModel)
                }
                CoreDataManager.instance.saveContext()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "quizVC")
                self.navigationController?.pushViewController(controller, animated: true)
            }
        })
    }
    
    @IBAction func restoreAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "restoreVC")
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func signupAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "signupVC")
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension LoginViewController : DesignableUITextFieldDelegate {
    func rightViewClick(sender: UIView) {
        if let imageView  = sender as? UIImageView {
            passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
            if passwordTextField.isSecureTextEntry {
                imageView.image = UIImage(named: "eye")
            }
            else {
                imageView.image = UIImage(named: "openEye")
            }
        }
    }
}
