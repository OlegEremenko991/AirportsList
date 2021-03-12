//
//  UITextField_Extension.swift
//  AirportsList_TestTask
//
//  Created by Олег Еременко on 02.10.2020.
//

import UIKit

extension UITextField {
    func setupTextField(placeholder: String,
                        borderWidth: CGFloat? = nil,
                        borderColor: UIColor? = nil,
                        cornerRadius: CGFloat? = nil,
                        isSecureTextEntry: Bool) {
        self.placeholder = placeholder
        self.layer.borderWidth = borderWidth ?? 1
        self.layer.borderColor = borderColor?.cgColor ?? UIColor.systemGray4.cgColor
        self.layer.cornerRadius = cornerRadius ?? 5
        self.isSecureTextEntry = isSecureTextEntry
    }

}
