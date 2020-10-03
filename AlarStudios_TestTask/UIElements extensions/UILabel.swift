//
//  UILabel_Extension.swift
//  AlarStudios_TestTask
//
//  Created by Олег Еременко on 02.10.2020.
//

import UIKit

extension UILabel {
    
    func setupLabel(text: String, textAlignment: NSTextAlignment? = nil, font: UIFont? = nil, cornerRadius: CGFloat? = nil, numberOfLines: Int? = nil) {
        self.text = text
        self.textAlignment = textAlignment ?? .left
        self.font = font ?? UIFont(name: "Verdana", size: 17)
        self.layer.cornerRadius = cornerRadius ?? 0
        self.numberOfLines = numberOfLines ?? 0
    }
    
}
