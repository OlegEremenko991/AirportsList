//
//  AlertManager.swift
//  AirportsList_TestTask
//
//  Created by Олег Еременко on 02.10.2020.
//

import UIKit

final class AlertService {

    static func customAlert(title: String, message: String, style: UIAlertController.Style? = nil, actions: [UIAlertAction]) -> UIAlertController {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: style ?? .alert)
        actions.forEach { alertController.addAction($0) }
        return alertController
    }
}
