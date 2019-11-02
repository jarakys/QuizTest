//
//  DesignableUITextField.swift
//  iOS 12 Notifications
//
//  Created by Kirill on 29.10.2019.
//  Copyright © 2019 Andrew Jaffee. All rights reserved.
//

import UIKit

protocol DesignableUITextFieldDelegate: class {
    func rightViewClick(sender: UIView)
}

@IBDesignable
class DesignableUITextField: UITextField {

    // Provides left padding for images
    public weak var sideViewdelegate: DesignableUITextFieldDelegate?
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x -= rightPadding
        return textRect
    }

    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.inset(by: UIEdgeInsets(top: 0, left: leftTextPadding, bottom: 0, right: rightTextPadding))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.inset(by: UIEdgeInsets(top: 0, left: leftTextPadding, bottom: 0, right: rightTextPadding))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.inset(by: UIEdgeInsets(top: 0, left: leftTextPadding, bottom: 0, right: rightTextPadding))
    }
    
    //@IBInspectable var textPadding: UIEdgeInsets =
    
    @IBInspectable var leftTextPadding: CGFloat = 0
    @IBInspectable var rightTextPadding: CGFloat = 0

    @IBInspectable var leftPadding: CGFloat = 0
    
    @IBInspectable var rightPadding: CGFloat = 0

    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }

    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            imageView.tintColor = color
            leftView = imageView
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
        if let image = rightImage {
            rightViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            rightView = imageView
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.rightViewTap))
            rightView!.isUserInteractionEnabled = true
            rightView!.addGestureRecognizer(tap)
        } else {
            rightViewMode = UITextField.ViewMode.never
            rightView = nil
        }

        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    }
    
    @objc func rightViewTap(_ sender: UITapGestureRecognizer) {
        sideViewdelegate?.rightViewClick(sender: rightView!)
     }
    
}
