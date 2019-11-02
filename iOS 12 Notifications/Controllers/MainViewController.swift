//
//  MainViewController.swift
//  iOS 12 Notifications
//
//  Created by Dmitriy Chumakov on 9/11/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit
import UserNotifications
class MainViewController: UIViewController {
    @IBOutlet weak var gradientLayer: UIImageView!
    @IBOutlet weak var centerRowView: UIView!
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var timePicker: UIPickerView! {
        didSet {
            self.timePicker.dataSource = self
            self.timePicker.delegate = self
        }
    }
    private var storage: LocalStorageProtocol = LocalStorage()
    private var minutes:Int = 0
    private var seconds:Int = 0
    private let time = Array(1...59)
    override func viewDidLoad() {
        super.viewDidLoad()
        minutes = storage.value(key: Keys.minutes)!
        seconds = storage.value(key: Keys.seconds)!
        timePicker.selectRow(self.time.firstIndex(of: minutes)!, inComponent: 0, animated: false)
        timePicker.selectRow(self.time.firstIndex(of: seconds)!, inComponent: 1, animated: false)
        let debitOverdraftNotifCategory = UNNotificationCategory(identifier: "debitOverdraftNotification", actions: [], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([debitOverdraftNotifCategory])
        configureView()
    }
    
    private func configureView() {
        let gradient = CAGradientLayer()
        let bounds = gradientLayer.bounds
        gradient.frame = bounds
        gradient.colors = [UIColor(red:0.08, green:0.00, blue:0.78, alpha:1.0).cgColor, UIColor(red:0.87, green:0.00, blue:0.83, alpha:1.0).cgColor, UIColor(red:0.02, green:0.76, blue:1.00, alpha:1.0).cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.image = getImageFrom(gradientLayer: gradient)!
        gradientLayer.layer.cornerRadius = 25
        centerRowView.layer.borderColor = UIColor(red:0.37, green:0.45, blue:0.99, alpha:0.3).cgColor
        centerRowView.layer.borderWidth = 1
    }
    
    @IBAction func sendNotificationButtonTapped(_ sender: Any) {
        let time = (minutes * 60) + seconds
        startNotif(time: 10, isRepeat: false, uuidString: "quickNotif")
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            guard settings.authorizationStatus == .authorized else { return }
            self.startNotif(time: TimeInterval(time), isRepeat: true, uuidString: "notificationSyject")
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "quizVC")
        navigationController?.pushViewController(controller, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
    
    private func startNotif(time: TimeInterval, isRepeat: Bool, uuidString: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [uuidString])
        let content = UNMutableNotificationContent()
        content.categoryIdentifier = "debitOverdraftNotification"
        content.title = "Swipe for quiz"
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: isRepeat)
        let uuidString = uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    @IBAction func logoutClick(_ sender: Any) {
         UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["notificationSyject"])
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["quickNotif"])
    }
}

extension MainViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return time.count
    }
}

extension MainViewController : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textColor = UIColor(red:0.98, green:1.00, blue:1.00, alpha:1.0)
        var sufix = " M"
        if component == 1 {
            sufix = " S"
        }
        label.font = .systemFont(ofSize: 14)
        let selectedMinRowIndex = pickerView.selectedRow(inComponent: 0)
        let selectedSecRowIndex = pickerView.selectedRow(inComponent: 1)
        if let label = pickerView.view(forRow: selectedMinRowIndex, forComponent: 0) as? UILabel {
            label.font = .systemFont(ofSize: 25)
            label.textColor = UIColor(red:0.02, green:0.76, blue:1.00, alpha:1.0)
        }
        if let label = pickerView.view(forRow: selectedSecRowIndex, forComponent: 1) as? UILabel {
            label.font = .systemFont(ofSize: 25)
            label.textColor = UIColor(red:1.00, green:0.00, blue:0.96, alpha:1.0)
        }
        label.text = time[row].description + sufix
        label.textAlignment = .center
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let value = time[row]
        if let label = pickerView.view(forRow: row, forComponent: component) as? UILabel {
            var color = UIColor(red:0.02, green:0.76, blue:1.00, alpha:1.0)
            if component == 1 {
                color = UIColor(red:1.00, green:0.00, blue:0.96, alpha:1.0)
            }
            label.font = .systemFont(ofSize: 25)
            label.textColor = color
        }
        var key = Keys.minutes
        if component == 1 {
            key = .seconds
        }
        storage.write(key: key, value: value)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
}
