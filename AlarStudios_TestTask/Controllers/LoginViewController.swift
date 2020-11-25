//
//  LoginViewController.swift
//  AlarStudios_TestTask
//
//  Created by Олег Еременко on 02.10.2020.
//

import UIKit

final class LoginViewController: UIViewController {

    // MARK: IBOutlets

    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        clearTextFields()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        activityIndicator.stopAnimating()
    }

    // MARK: Private methods

    private func setupView() {
        self.title = "Login screen"
        
        activityIndicator.hidesWhenStopped = true
        
        loginTextField.setupTextField(placeholder: "Your login", isSecureTextEntry: false)
        
        passwordTextField.setupTextField(placeholder: "Your password", isSecureTextEntry: true)
        
        loginButton.setupButton(backgroundColor: .blue, title: "Log in", titleColor: .white, cornerRadius: 10)
    
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
        self.hideKeyboardOnTap()
        
    }

    private func clearTextFields() {
        loginTextField.text = ""
        passwordTextField.text = ""
        loginTextField.becomeFirstResponder()
    }

    private func showAlertController(title: String, message: String) {
        DispatchQueue.main.async {
            let okAction = UIAlertAction(title: "Ok!", style: .cancel, handler: nil)
            let alert = AlertService.customAlert(title: title, message: message, actions: [okAction])
            self.present(alert, animated: true)
            
            self.activityIndicator.stopAnimating()
        }
    }

    private func presentMainViewController(with responseData: ResponseModel) {
        DispatchQueue.main.async {
            guard let mainViewController = self.storyboard?.instantiateViewController(identifier: MainViewController.identifier) as? MainViewController else { return }
            mainViewController.code = responseData.code
            self.show(mainViewController, sender: nil)
        }
    }

    private func requestAuthorization (username: String, password: String) {
        NetworkService.shared.signIn(userName: username, password: password) { result in
            switch result {
            case .success(let authData):
                if authData.status == "ok" {
                    self.presentMainViewController(with: authData)
                } else {
                    self.showAlertController(title: "Error", message: ErrorType.invalidLoginPassword.rawValue)
                }
            case .failure(let error):
                self.showAlertController(title: "Error", message: error.rawValue)
            }
        }
    }

    // MARK: IBActions

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        if loginTextField.text == "" || passwordTextField.text == "" {
            showAlertController(title: "Error", message: ErrorType.noLoginPassword.rawValue)
        } else {
            requestAuthorization(username: loginTextField.text ?? "", password: passwordTextField.text ?? "")
        }
    }

}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        requestAuthorization(username: loginTextField.text ?? "", password: passwordTextField.text ?? "")
        activityIndicator.startAnimating()
        return true
    }
}
