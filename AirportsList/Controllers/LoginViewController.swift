//
//  LoginViewController.swift
//  AirportsList_TestTask
//
//  Created by Олег Еременко on 02.10.2020.
//

import UIKit

final class LoginViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var loginTextField: UITextField! {
        didSet {
            loginTextField.delegate = self
            loginTextField.setupTextField(placeholder: "Your login", isSecureTextEntry: false)
        }
    }

    @IBOutlet private weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.delegate = self
            passwordTextField.setupTextField(placeholder: "Your password", isSecureTextEntry: true)
        }
    }

    @IBOutlet private weak var loginButton: UIButton! {
        didSet { loginButton.setupButton(backgroundColor: .blue, title: "Log in", titleColor: .white, cornerRadius: 10) }
    }

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView! {
        didSet { activityIndicator.hidesWhenStopped = true }
    }

    // MARK: - Lifecycle

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

    // MARK: - Private methods

    private func setupView() {
        title = "Login screen"
        hideKeyboardOnTap()
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
            guard let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: MainViewController.identifier) as? MainViewController else { return }
            mainViewController.code = responseData.code
            self.show(mainViewController, sender: nil)
        }
    }

    private func requestAuthorization (username: String, password: String) {
        activityIndicator.startAnimating()
        NetworkService.shared.signIn(userName: username, password: password) { [weak self] result in
            switch result {
            case .success(let authData):
                if authData.status == "ok" {
                    self?.presentMainViewController(with: authData)
                } else {
                    self?.showAlertController(title: "Error", message: ErrorType.invalidLoginPassword.rawValue)
                }
            case .failure(let error):
                self?.showAlertController(title: "Error", message: error.rawValue)
            }
        }
    }

    private func loginAction() {
        if let loginText = loginTextField.text, !loginText.isEmpty,
           let passwordText = passwordTextField.text, !passwordText.isEmpty {
            requestAuthorization(username: loginText,
                                 password: passwordText)
        } else {
            showAlertController(title: "Error",
                                message: ErrorType.noLoginPassword.rawValue)
        }
    }

    // MARK: - IBActions

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        loginAction()
    }

}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginAction()
        return true
    }
}
