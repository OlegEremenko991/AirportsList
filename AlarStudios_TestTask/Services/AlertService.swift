//
//  AlertManager.swift
//  AlarStudios_TestTask
//
//  Created by Олег Еременко on 02.10.2020.
//

import UIKit

public final class AlertService {

    static func customAlert(title: String, message: String, style: UIAlertController.Style? = nil, actions: [UIAlertAction]) -> UIAlertController {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: style ?? .alert)
        for action in actions { alertController.addAction(action) }
        return alertController
    }

}
