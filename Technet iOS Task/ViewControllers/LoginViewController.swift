//
//  ViewController.swift
//  Technet iOS Task
//
//  Created by Tom Holmes on 07/09/2022.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var emailIsValid: Bool = false
    var passworldIsValid: Bool = false
        
    var canLogin: Bool {
        get {
            return emailIsValid && passworldIsValid
        }
    }
    
    let appServices = AppServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        emailTextField.text = ""
        passwordTextField.text = ""
        emailTextFieldDidChange()
        passwordTextFieldDidChange()
        emailTextField.becomeFirstResponder()
    }

    func setup() {
        emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange), for: .editingChanged)
        emailTextField.setupRightImage(imageName: "success_tick")
        emailTextField.rightView?.isHidden = true
        
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
        passwordTextField.setupRightImage(imageName: "success_tick")
        passwordTextField.rightView?.isHidden = true
        
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    
    // MARK: - IBOutlet Target Functions
    
    @objc func emailTextFieldDidChange() {
        emailIsValid = appServices.isValidEmailAddress(emailAddressString: emailTextField.text!)
        emailTextField.rightView?.isHidden = !emailIsValid
    }
    
    @objc func passwordTextFieldDidChange() {
        passworldIsValid = appServices.isValidPassword(passwordString: passwordTextField.text!)
        passwordTextField.rightView?.isHidden = !passworldIsValid
    }
    
    @objc func handleLogin() {
        if emailIsValid && passworldIsValid {
            let vc = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
            navigationController?.pushViewController(vc, animated: true)
        } else if emailIsValid && !passworldIsValid {
            // Show password invalid alert dialog
            let alert = UIAlertController(title: "Password Invalid", message: appServices.passwordInvalidMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else if !emailIsValid && passworldIsValid {
            // Show email invalid alert dialog
            let alert = UIAlertController(title: "Email Invalid", message: appServices.emailInvalidMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            // Show both invalid alert dialog
            let alert = UIAlertController(title: "Invalid Login Details", message: appServices.invalidLoginMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

