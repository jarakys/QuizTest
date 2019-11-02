//
//  Quiz1ViewController.swift
//  iOS 12 Notifications
//
//  Created by Kirill on 29.10.2019.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit

class Quiz1ViewController: UIViewController {

    @IBOutlet weak var questionContainerView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerTableView: UITableView!{
        didSet {
            self.answerTableView.delegate = self
            self.answerTableView.dataSource = self
        }
    }
    
    public var currentQuestion: Int = 0
    private var rightAnswerIndexPath: IndexPath?
    //private var quizModel:QuizModel!
    private var question:Question!
    private var dbContext: QuizParser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let path  = Bundle.main.path(forResource: "questionsDb", ofType: "db") {
            let databaseManager = DatabaseManager(databasePath: path)!
            dbContext = QuizParser(databaseManager: databaseManager)
        }
        initQuizModel()
        updateViews()
        answerTableView.backgroundColor = .clear
        questionContainerView.backgroundColor = UIColor(red:0.02, green:0.21, blue:0.49, alpha:1.0)
        questionContainerView.layer.borderColor = UIColor(red:0.19, green:0.40, blue:0.68, alpha:1.0).cgColor
        questionContainerView.layer.borderWidth = 2
        questionContainerView.layer.cornerRadius = 8
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func initQuizModel() {
        do {
            question = try CoreDataManager.instance.getRandomQuestion()
            print(question.answers)
        }
        catch {
            print("error")
        }
    }
    
    private func updateViews() {
        questionLabel.text = question.text
        answerTableView.reloadData()
    }
    
    @IBAction func nextQuestionAction(_ sender: Any) {
        initQuizModel()
        answerTableView.delegate = self
        updateViews()
    }
}

extension Quiz1ViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 15
     }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         let headerView = UIView()
        headerView.backgroundColor = .clear
         return headerView
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        UIView.animate(withDuration: 1.0) {
            if self.question.answers!.answers[indexPath.section].text == self.question.correctAnswerText {
                cell.backgroundColor = .green
            }
            else {
                if let rightIndexPath = self.rightAnswerIndexPath {
                    let rightAnswerCell = tableView.cellForRow(at: rightIndexPath)!
                    rightAnswerCell.backgroundColor = .green
                }
                cell.backgroundColor = UIColor(red:1.00, green:0.25, blue:0.25, alpha:1.0)
            }
        }
        answerTableView.delegate = nil
    }
}

extension Quiz1ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return question.answers?.answers.count ?? 0
      }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath)
        if let keyLabel = cell.viewWithTag(1) as? UILabel {
            keyLabel.text = question.answers!.answers[indexPath.section].key + ": "
        }
        if let answerLabel = cell.viewWithTag(2) as? UILabel {
            answerLabel.text = question.answers!.answers[indexPath.section].text
        }
        if question.answers!.answers[indexPath.section].text == question.correctAnswerText {
            rightAnswerIndexPath = indexPath
        }
        cell.backgroundColor = UIColor(red:0.02, green:0.21, blue:0.49, alpha:1.0)
        cell.layer.borderColor = UIColor(red:0.19, green:0.40, blue:0.68, alpha:1.0).cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        return cell
    }
}
