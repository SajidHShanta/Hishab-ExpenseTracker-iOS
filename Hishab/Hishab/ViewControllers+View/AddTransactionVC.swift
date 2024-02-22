//
//  AddTransactionVC.swift
//  Hishab
//
//  Created by Sajid Shanta on 22/2/24.
//

import UIKit

class AddTransactionVC: UIViewController {
    @IBOutlet weak var containerStack: UIStackView!
    
    @IBOutlet weak var nameInputStack: UIStackView!
    @IBOutlet weak var categoryInputStack: UIStackView!
    @IBOutlet weak var dateInputStack: UIStackView!
    @IBOutlet weak var noteInputStack: UIStackView!
    
    @IBOutlet weak var selectCategoryBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    
    
    let categories = ["Category 1", "Category 2", "Category 3", "Category 4"] // dropdown options
    var selectedOption: String?

    var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    fileprivate func setupViews() {
        containerStack.layoutMargins = UIEdgeInsets(top: 25, left: 16, bottom: 20, right: 16)
        containerStack.isLayoutMarginsRelativeArrangement = true
        containerStack.layer.cornerRadius = 10
        
        nameInputStack.layoutMargins = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        categoryInputStack.layoutMargins = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        dateInputStack.layoutMargins = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        noteInputStack.layoutMargins = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        
        nameInputStack.isLayoutMarginsRelativeArrangement = true
        categoryInputStack.isLayoutMarginsRelativeArrangement = true
        dateInputStack.isLayoutMarginsRelativeArrangement = true
        noteInputStack.isLayoutMarginsRelativeArrangement = true
        
        nameInputStack.layer.cornerRadius = 5
        categoryInputStack.layer.cornerRadius = 5
        dateInputStack.layer.cornerRadius = 5
        noteInputStack.layer.cornerRadius = 5
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tintColor = UIColor(named: "AccentColor")
        
        cancelBtn.layer.cornerRadius = 5
        saveBtn.layer.cornerRadius = 5
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        //TODO: Save all data
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectCategoryBtnPressed(_ sender: Any) {
          let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
          alert.view.addSubview(pickerView)

          let doneAction = UIAlertAction(title: "Done", style: .default) { _ in
              self.selectCategoryBtn.setTitle(self.selectedOption, for: .normal)
          }

          alert.addAction(doneAction)

          present(alert, animated: true, completion: nil)
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
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedOption = categories[row]
        selectCategoryBtn.setTitle(selectedOption, for: .normal)
    }
}
