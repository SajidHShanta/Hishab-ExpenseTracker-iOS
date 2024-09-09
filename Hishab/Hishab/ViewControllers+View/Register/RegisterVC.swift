//
//  RegisterVC.swift
//  Hishab
//
//  Created by Sajid Shanta on 10/3/24.
//

import UIKit

class RegisterVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: PasswordTextField!
    @IBOutlet weak var confirmPasswordTF: PasswordTextField!
    @IBOutlet weak var registerBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.isHidden = false
        
        setupViews()
    }
    
    fileprivate func setupViews() {
        //MARK: - Setup Text fields
        nameTF.delegate = self
        nameTF.layer.borderWidth = 1
        nameTF.layer.borderColor = UIColor(hexString: "#F7F7F7").cgColor
        nameTF.backgroundColor = UIColor(hexString: "#F7F7F7", alpha: 0.4)
        nameTF.layer.cornerRadius = 10
        nameTF.clipsToBounds = true
        nameTF.addTarget(self, action: #selector(nameTFDidBeginEditing), for: UIControl.Event.editingDidBegin)
        nameTF.addTarget(self, action: #selector(nameTFDidEndEditing), for: UIControl.Event.editingDidEnd)
        nameTF.attributedPlaceholder = .init(string: "Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: "#2C2948")])
        
        emailTF.delegate = self
        emailTF.layer.borderWidth = 1
        emailTF.layer.borderColor = UIColor(hexString: "#F7F7F7").cgColor
        emailTF.backgroundColor = UIColor(hexString: "#F7F7F7", alpha: 0.4)
        emailTF.layer.cornerRadius = 10
        emailTF.clipsToBounds = true
        emailTF.keyboardType = .emailAddress
        emailTF.addTarget(self, action: #selector(emailTFDidBeginEditing), for: UIControl.Event.editingDidBegin)
        emailTF.addTarget(self, action: #selector(emailTFDidEndEditing), for: UIControl.Event.editingDidEnd)
        emailTF.attributedPlaceholder = .init(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: "#2C2948")])
        
        passwordTF.delegate = self
        passwordTF.layer.borderWidth = 1
        passwordTF.layer.borderColor = UIColor(hexString: "#F7F7F7").cgColor
        passwordTF.backgroundColor = UIColor(hexString: "#F7F7F7", alpha: 0.4)
        passwordTF.layer.cornerRadius = 10
        passwordTF.clipsToBounds = true
        passwordTF.addTarget(self, action: #selector(passwordTFDidBeginEditing), for: UIControl.Event.editingDidBegin)
        passwordTF.addTarget(self, action: #selector(passwordTFDidEndEditing), for: UIControl.Event.editingDidEnd)
        passwordTF.attributedPlaceholder = .init(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: "#2C2948")])
        
        confirmPasswordTF.delegate = self
        confirmPasswordTF.layer.borderWidth = 1
        confirmPasswordTF.layer.borderColor = UIColor(hexString: "#F7F7F7").cgColor
        confirmPasswordTF.backgroundColor = UIColor(hexString: "#F7F7F7", alpha: 0.4)
        confirmPasswordTF.layer.cornerRadius = 10
        confirmPasswordTF.clipsToBounds = true
        confirmPasswordTF.addTarget(self, action: #selector(cofirmPasswordTFDidBeginEditing), for: UIControl.Event.editingDidBegin)
        confirmPasswordTF.addTarget(self, action: #selector(cofirmPasswordTFDidEndEditing), for: UIControl.Event.editingDidEnd)
        confirmPasswordTF.attributedPlaceholder = .init(string: "Confirm Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: "#2C2948")])
        
        
        
        registerBtn.layer.cornerRadius = 10
    }
    
    @IBAction func register(_ sender: UIButton) {
        
        guard let email = emailTF.text else {
            //TODO: show toast
//            self.view.makeToast("Invalid Email!")
            return
        }
        if !isValidEmail(email) {
            //TODO: show toast
            //            self.view.makeToast("Invalid Email!")
            return
        }
        
        guard let name = nameTF.text else {
            //TODO: show toast
//            self.view.makeToast("Invalid Name!")
            return
        }
        
        guard let password = passwordTF.text,
              let confirmPassword = confirmPasswordTF.text else {
//                  self.view.makeToast("Invalid Password!")
                  return
              }
        
        if password == confirmPassword {
            //TODO: - create account
            let parameters: [String: String] = [
                "email": email,
                "name": name,
                "password": password
            ]
            
            NetworkService.shared.register(dictionary: parameters) { result in
                switch result {
                case .success(let success):
                    if success.status == 200 {
                        guard let accessToken = success.accessToken,
                              let refreshToken = success.refreshToken,
                              let user = success.user else {
                            //                    self.view.makeToast("Please check your email, password and try again")
                            fatalError()
                        }
                        
                        
                        // Login successfull!
                        UserService.shared.saveUserData(name: user.name, email: user.email, accessToken: accessToken, refreshToken: refreshToken)
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let vc = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                        
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.window?.rootViewController = UINavigationController(rootViewController: vc)
                        
                        let options: UIView.AnimationOptions = .transitionCrossDissolve
                        
                        let duration: TimeInterval = 0.3
                        
                        if let window = appDelegate.window {
                            UIView.transition(with:  window, duration: duration, options: options, animations: {}, completion:
                                                { completed in
                            })
                        }
                    } else {
                        // TODO: show toasr
                        print(success.message)
                    }
                    
                case .failure(let failure):
                    //TODO: show toast
                    print(failure.localizedDescription)
                }
            }
            
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//            let vc = storyBoard.instantiateViewController(withIdentifier: "MainTab") as! MainTabVC
//            self.navigationController?.pushViewController(vc, animated: true)
            
        } else {
//            self.view.makeToast("Password and Confirm password are not same!")
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    @objc func nameTFDidBeginEditing() {
        nameTF.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        nameTF.backgroundColor = UIColor(named: "AccentColor")?.withAlphaComponent(0.1)
    }
    
    @objc func nameTFDidEndEditing() {
        nameTF.layer.borderColor = UIColor(hexString: "#F7F7F7").cgColor
        nameTF.backgroundColor = UIColor(hexString: "#F7F7F7", alpha: 0.4)
    }
    
    @objc func emailTFDidBeginEditing() {
        emailTF.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        emailTF.backgroundColor = UIColor(named: "AccentColor")?.withAlphaComponent(0.1)
    }
    
    @objc func emailTFDidEndEditing() {
        emailTF.layer.borderColor = UIColor(hexString: "#F7F7F7").cgColor
        emailTF.backgroundColor = UIColor(hexString: "#F7F7F7", alpha: 0.4)
        
        //TODO: add proper toast after validation
        //self.view.makeToast("Nice email, Demo toast message!")
    }
    
    @objc func passwordTFDidBeginEditing() {
        passwordTF.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        passwordTF.backgroundColor = UIColor(named: "AccentColor")?.withAlphaComponent(0.1)
    }
    
    @objc func passwordTFDidEndEditing() {
        passwordTF.layer.borderColor = UIColor(hexString: "#F7F7F7").cgColor
        passwordTF.backgroundColor = UIColor(hexString: "#F7F7F7", alpha: 0.4)
    }
    
    @objc func cofirmPasswordTFDidBeginEditing() {
        confirmPasswordTF.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        confirmPasswordTF.backgroundColor = UIColor(named: "AccentColor")?.withAlphaComponent(0.1)
    }
    
    @objc func cofirmPasswordTFDidEndEditing() {
        confirmPasswordTF.layer.borderColor = UIColor(hexString: "#F7F7F7").cgColor
        confirmPasswordTF.backgroundColor = UIColor(hexString: "#F7F7F7", alpha: 0.4)
    }
}

