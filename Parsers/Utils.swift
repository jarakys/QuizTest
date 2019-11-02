//
//  Utils.swift
//  iOS 12 Notifications
//
//  Created by Kirill on 01.11.2019.
//  Copyright © 2019 Andrew Jaffee. All rights reserved.
//

import UIKit

struct Utils {
    static func parsePhoneNumber(phoneNumber: String) -> String {
        return phoneNumber.replacingOccurrences(of: "+", with: "", options: .literal, range: nil).replacingOccurrences(of: " ", with: "", options: .literal, range: nil )
    }
    
    static func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
}
