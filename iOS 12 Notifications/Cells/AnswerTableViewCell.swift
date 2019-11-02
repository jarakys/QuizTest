//
//  AnswerTableViewCell.swift
//  iOS 12 Notifications
//
//  Created by Kirill on 28.10.2019.
//  Copyright © 2019 Andrew Jaffee. All rights reserved.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {

    static let reusableIndetifier = "answerCell"
    
    public lazy var viewContainer: UIView = {
       let view = UIView()
        return view
    }()
    
    public lazy var icon: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "a")
        return imageView
    }()
    
    public lazy var answerText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = UIColor(red:0.08, green:0.00, blue:0.78, alpha:1.0)
        label.text = "Here text"
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let view = UIView()
        view.backgroundColor = .clear
        self.selectedBackgroundView = view
        // Configure the view for the selected state
    }
    
    private func createViews() {
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(viewContainer)
        viewContainer.addSubview(icon)
        viewContainer.addSubview(answerText)
        addConstraint()
    }
    
    private func addConstraint() {
        viewContainer.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 30, paddingRight: 20, width: 0, height: 0, enableInsets: false)
        icon.anchor(top: viewContainer.topAnchor, left: viewContainer.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 40, height: 40, enableInsets: false)
        answerText.anchor(top: icon.topAnchor, left: icon.rightAnchor, bottom: viewContainer.bottomAnchor, right: viewContainer.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }

}
