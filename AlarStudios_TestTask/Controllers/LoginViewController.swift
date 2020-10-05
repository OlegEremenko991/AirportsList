//
//  LoginViewController.swift
//  AlarStudios_TestTask
//
//  Created by Олег Еременко on 02.10.2020.
//

import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
        let okAction = UIAlertAction(title: "Ok!", style: .cancel, handler: nil)
        let alert = AlertService.showAlert(title: title, message: message, actions: [okAction])
        self.present(alert, animated: true)
    }
    
    private func requestAuthorization (username: String, password: String) {
        NetworkService.signIn(userName: username, password: password) { (auth, error) in
            if let authorizationData = auth {
                if authorizationData.status == "ok" {
                    DispatchQueue.main.async {
                        guard let secondVC = self.storyboard?.instantiateViewController(identifier: MainViewController.identifier) as? MainViewController else { return }
                        secondVC.code = auth!.code
                        self.show(secondVC, sender: nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showAlertController(title: "Error", message: "Incorrect login/password")
                        self.activityIndicator.stopAnimating()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.showAlertController(title: "Error", message: "Request failed")
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.hidesWhenStopped = true
                }
            }
        }
    }

    // MARK: IBActions
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        if loginTextField.text != "" && passwordTextField.text != "" {
            activityIndicator.startAnimating()
            requestAuthorization(username: loginTextField.text ?? "", password: passwordTextField.text ?? "")
        } else {
            showAlertController(title: "Error", message: "Please enter your login and password")
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
