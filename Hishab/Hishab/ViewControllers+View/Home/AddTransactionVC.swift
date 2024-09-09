//
//  AddTransactionVC.swift
//  Hishab
//
//  Created by Sajid Shanta on 22/2/24.
//

import UIKit
import DropDown

class AddTransactionVC: UIViewController {
    @IBOutlet weak var containerStack: UIStackView!
    
    @IBOutlet weak var nameInputStack: UIStackView!
    @IBOutlet weak var categoryInputStack: UIStackView!
    @IBOutlet weak var noteInputStack: UIStackView!
    
    @IBOutlet weak var typePicker: UISegmentedControl!
    @IBOutlet weak var amountTF: UITextField!
    @IBOutlet weak var noteTF: UITextField!
    
    @IBOutlet weak var selectCategoryBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    
    var onDismiss: (() -> Void)?
    
    var selectedTypeSegmentIndex = 1 {
        didSet {
            categories = DataService.shared.categories.filter({ $0.type == ((selectedTypeSegmentIndex == 0) ? .income : .expense) })
            selectedCategory = nil
            selectCategoryBtn.setTitle("Select Category", for: .normal)
        }
    }
    var categories = DataService.shared.categories.filter({ $0.type == .expense }) {
        didSet {
            categoryDropDown.dataSource = categories.map({ $0.name })
        }
    }
    var selectedCategory: Category? = nil
    
    let categoryDropDown = DropDown()
    
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
        categoryInputStack.layoutMargins = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        noteInputStack.layoutMargins = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        
        nameInputStack.isLayoutMarginsRelativeArrangement = true
        categoryInputStack.isLayoutMarginsRelativeArrangement = true
        noteInputStack.isLayoutMarginsRelativeArrangement = true
        
        nameInputStack.layer.cornerRadius = 5
        categoryInputStack.layer.cornerRadius = 5
        noteInputStack.layer.cornerRadius = 5
        
        categoryDropDown.dataSource = categories.map({ $0.name })
        categoryDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            selectCategoryBtn.setTitle(item, for: .normal)
            selectedCategory = categories[index]
            categoryDropDown.hide()
        }
        
        cancelBtn.layer.cornerRadius = 5
        saveBtn.layer.cornerRadius = 5
    }
    
    
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: dismissViewController)
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        
        guard let amountText = amountTF.text,
              let amount = Double(amountText) else {
            print("Input correct amount!") //TODO: Toast
            return
        }
        
        guard let category = selectedCategory else {
            print("Select category!") //TODO: Toast
            return
        }
        
        var parameters: [String : Any] = [:]
        if (noteTF.text != nil) {
            parameters = [
                "amount": amountText,
                "note": noteTF.text ?? "",
                "categoryID": category.id
            ]
        } else {
            parameters = [
                "amount": amountText,
                "categoryID": category.id
            ]
        }
        
        NetworkService.shared.addTransaction(dictionary: parameters) { result in
            switch result {
            case .success(let success):
                //TODO: Show Toast
                print(success.message)

                if success.status == 201 {
                    self.dismiss(animated: true, completion: self.dismissViewController)
                }
            case .failure(let failure):
                //TODO: Show Toast
                print(failure.localizedDescription)
            }
        }
    }
    
    @IBAction func selectCategoryBtnPressed(_ sender: Any) {
        categoryDropDown.show()
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


extension AddTransactionVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row].name
    }
}
