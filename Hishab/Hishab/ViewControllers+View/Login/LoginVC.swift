//
//  LoginVC.swift
//  Hishab
//
//  Created by Sajid Shanta on 10/3/24.
//

import UIKit
import Alamofire

class LoginVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: PasswordTextField!
    @IBOutlet weak var signinBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.isHidden = true
        navigationItem.hidesBackButton = true
        navigationController?.hidesBarsOnSwipe = true
        
        setupViews()
    }
    
    fileprivate func setupViews() {
        //MARK: - Setup Text fields
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
        
        signinBtn.layer.cornerRadius = 10
    }
    
    @IBAction func login(_ sender: UIButton) {
        emailTF.text = "newuser@example.com"
        passwordTF.text = "password123"
        
        guard let email = emailTF.text,
              let password = passwordTF.text else { return }
        
        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]
        
//        self.show()
        NetworkService.shared.login(dictionary: parameters) { result in
//            self.dismiss()
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
                    UserService.shared.saveUserData(name: user.name ?? "user name", email: user.email, accessToken: accessToken, refreshToken: refreshToken)
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
                    fatalError()
//                    self.view.makeToast("Please check your email, password and try again")
                }
                
        
            case .failure(let failure):
//                self.view.makeToast("Please check your email, password and try again")
                break
            }
        }
//
//        let url = "https://ecommercebe.azurewebsites.net/api/users/login"
//        let parameters: [String: String] = [
//            "email": username,
//            "password": password
//            ]
        
//        // login
//        self.show()
//        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
//            .responseDecodable( of: LoginResponse.self, completionHandler: { response in
//                self.dismiss()
//                switch response.result {
//                 case .success(let success):
//                     print(success)
//                     if let error = success.message {
//                         self.view.makeToast(error)
//                         print(error)
//                         return
//                     }
// 
//                     // login success
//                     guard let name = success.name,
//                           let email = success.email,
//                           let isAdmin = success.isAdmin,
//                           let token = success.token
//                     else {
//                         self.view.makeToast("Error! try again.")
//                         print("Error! try again.")
//                         return
//                     }
//                     UserService.shared.token = token
//                     UserService.shared.name = name
//                     UserService.shared.email = email
//                     UserService.shared.isAdmin = isAdmin
// 
//                     let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                     let vc = storyBoard.instantiateViewController(withIdentifier: "MainTab") as! MainTabVC
//                     self.navigationController?.pushViewController(vc, animated: true)
// 
//                 case.failure(let failure):
//                     print(failure.localizedDescription)
//                     self.view.makeToast(failure.localizedDescription)
//                 }
//            })
    }
    
    @IBAction func registerPage(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "RegisterVC")
        navigationController?.pushViewController(nextViewController, animated: true)
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
}

