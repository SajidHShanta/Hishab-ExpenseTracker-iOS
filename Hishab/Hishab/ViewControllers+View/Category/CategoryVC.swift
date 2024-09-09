//
//  CategoryVC.swift
//  Hishab
//
//  Created by Sajid Shanta on 29/2/24.
//

import UIKit

class CategoryVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addCategoryBtn: UIButton!
    
    var categories: [Category] = DataService.shared.categories {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        getCategories()
        setupViews()
    }
    
    fileprivate func getCategories() {
        NetworkService.shared.getCategories() { result in
            switch result {
            case .success(let success):
                if success.status == 200 {
                    guard let categoriesResponse = success.categories else {
                        //TODO - show toast
                        print("error in retrieving categories")
                        return
                    }
                    DataService.shared.categories = categoriesResponse
                    self.categories = DataService.shared.categories
                } else {
                    print(success.message)
                    // TODO- show toast
                }
            case .failure(let failure):
                //TODO-show toast
                print(failure.localizedDescription)
            }
        }
    }
    
    fileprivate func setupViews() {
        title = "Category"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
        
        addCategoryBtn.layer.cornerRadius = 10
    }
    
    func editCategory(at index: Int) {
        let alertController = UIAlertController(title: "Edit Category", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Category Name"
            textField.text = self.categories[index].name
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            if let textField = alertController.textFields?.first, let text = textField.text {
                print("Entered Category Name: \(text)")
//                self.categories[index].name = text
                let parameters: [String: String] = [
                    "newName": text
                ]
                NetworkService.shared.updateCategoryName(id: self.categories[index].id, dictionary: parameters) { result in
                    switch result {
                    case .success(let success):
                        //TODO: show toast
                        print(success.message)
                        
                        if success.status == 200 {
                            print("done")
                            self.getCategories()
                        } else {
                            return
                        }
                    case .failure(let failure):
                        //TODO: show toast
                        return
                    }
                }
            }
        }
        alertController.addAction(saveAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func addNewCategory(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let customAlert = storyboard.instantiateViewController(withIdentifier: "AddCategoryVC") as? AddCategoryVC {
            customAlert.modalPresentationStyle = .overCurrentContext
            customAlert.modalTransitionStyle = .crossDissolve
            present(customAlert, animated: true, completion: nil)
            
            customAlert.onDismiss = { [weak self] in
                self?.getCategories()
            }
        }
    }
    
}
