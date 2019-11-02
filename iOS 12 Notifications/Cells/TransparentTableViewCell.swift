//
//  TransparentTableViewCell.swift
//  iOS 12 Notifications
//
//  Created by Kirill on 31.10.2019.
//  Copyright © 2019 Andrew Jaffee. All rights reserved.
//

import UIKit

class TransparentHightlightTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: false)
        let view  = UIView()
        view.backgroundColor = UIColor.clear
        self.selectedBackgroundView = view
        // Configure the view for the selected state
    }

}

