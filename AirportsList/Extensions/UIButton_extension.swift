//
//  UIButton_Extension.swift
//  AirportsList_TestTask
//
//  Created by Олег Еременко on 02.10.2020.
//

import UIKit

extension UIButton {
    func setupButton(backgroundColor: UIColor,
                     title: String,
                     titleColor: UIColor,
                     cornerRadius: CGFloat) {
        self.backgroundColor = backgroundColor
        self.setTitleColor(titleColor, for: .normal)
        self.layer.cornerRadius = cornerRadius
        self.setTitle(title, for: .normal)
    }

}
