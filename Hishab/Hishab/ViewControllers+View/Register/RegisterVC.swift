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
        
        guard let password = passwordTF.text,
              let confirmPassword = confirmPasswordTF.text else {
//                  self.view.makeToast("Invalid Password!")
                  return
              }
        
        if password == confirmPassword {
            //TODO: - create account
            
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//            let vc = storyBoard.instantiateViewController(withIdentifier: "MainTab") as! MainTabVC
//            self.navigationController?.pushViewController(vc, animated: true)
            
        } else {
//            self.view.makeToast("Password and Confirm password are not same!")
        }
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

