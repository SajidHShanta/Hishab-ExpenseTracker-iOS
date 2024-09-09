//
//  AddCategoryVC.swift
//  Hishab
//
//  Created by Sajid Shanta on 11/3/24.
//

import UIKit

class AddCategoryVC: UIViewController {
    @IBOutlet weak var containerStack: UIStackView!
    
    @IBOutlet weak var nameInputStack: UIStackView!
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var typePicker: UISegmentedControl!
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    
    var onDismiss: (() -> Void)?
    
    var selectedTypeSegmentIndex = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    fileprivate func setupViews() {
        containerStack.layoutMargins = UIEdgeInsets(top: 25, left: 16, bottom: 20, right: 16)
        containerStack.isLayoutMarginsRelativeArrangement = true
        containerStack.layer.cornerRadius = 10
        
        typePicker.addTarget(self, action: #selector(typeSegmentedControlValueChanged(_:)), for: .valueChanged)
        
        nameInputStack.layoutMargins = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        nameInputStack.isLayoutMarginsRelativeArrangement = true
        nameInputStack.layer.cornerRadius = 5
        
        cancelBtn.layer.cornerRadius = 5
        saveBtn.layer.cornerRadius = 5
    }
    
    
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: dismissViewController)
    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
        guard let name = nameTF.text else {
            print("Enter valid name!") //TODO: Toast
            return
        }
        
        let type: CategoryType = (selectedTypeSegmentIndex == 0) ? .income : .expense
        
        let parameters: [String: String] = [
            "name": name,
//            "icon": "money-icon.png",
            "type": type.name
        ]
        
        NetworkService.shared.addCategory(dictionary: parameters) { result in
            switch result {
            case .success(let success):
                if success.status == 201 {
                    self.dismiss(animated: true, completion: self.dismissViewController)
                }
                
                //TODO - show toast
                print(success.message)
                
            case .failure( let failure):
                //TODO - show toast
                print(failure.localizedDescription)
            }
        }
    }
    
    @objc func typeSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        // Handle the value changed event
        self.selectedTypeSegmentIndex = sender.selectedSegmentIndex
        print("Selected Segment Index: \(selectedTypeSegmentIndex)")
    }
    
    func dismissViewController() {
        dismiss(animated: true) {
            self.onDismiss?()
        }
    }
}
