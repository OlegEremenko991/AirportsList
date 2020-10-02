//
//  AlertManager.swift
//  AlarStudios_TestTask
//
//  Created by Олег Еременко on 02.10.2020.
//

import UIKit

final class AlertManager {
    static func showAlert(title: String, message: String, style: UIAlertController.Style? = nil, actions: [UIAlertAction]) -> UIAlertController {        
        let alert = UIAlertController(title: title, message: message, preferredStyle: style ?? .alert)
        for action in actions {
            alert.addAction(action)
        }
        
        return alert
    }
}
