//
//  AnswerCollectionViewCell.swift
//  iOS 12 Notifications
//
//  Created by Kirill on 29.10.2019.
//  Copyright © 2019 Andrew Jaffee. All rights reserved.
//

import UIKit

class AnswerCollectionViewCell: UICollectionViewCell {
    private var isHeightCalculated: Bool = false
    public static let reusableIdentifier = "answerCell"
    
    public lazy var keyLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor  = .orange
        return label
    }()
    
    public lazy var answerLabel:UILabel = {
        let answerLabel = UILabel()
        answerLabel.font = .systemFont(ofSize: 18)
        answerLabel.textColor = .black
        return answerLabel
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
       // self.addSubview(keyLabel)
        self.addSubview(answerLabel)
        createConstraint()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        //Exhibit A - We need to cache our calculation to prevent a crash.
        if !isHeightCalculated {
            setNeedsLayout()
            layoutIfNeeded()
            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
            var newFrame = layoutAttributes.frame
            newFrame.size.width = CGFloat(ceilf(Float(size.width)))
            layoutAttributes.frame = newFrame
            isHeightCalculated = true
        }
        return layoutAttributes
    }
    
    
    private func createConstraint() {
        //keyLabel.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        answerLabel.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 10, width: 0, height: 0, enableInsets: false)
    }
}
