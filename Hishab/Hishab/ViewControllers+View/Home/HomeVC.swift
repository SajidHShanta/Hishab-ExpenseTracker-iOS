//
//  HomeVC.swift
//  Hishab
//
//  Created by Sajid Shanta on 22/2/24.
//

import UIKit

class HomeVC: UIViewController {
    //MARK: - Upper Cards
    @IBOutlet weak var incomeCard: UIView!
    @IBOutlet weak var expensesCard: UIView!
    @IBOutlet weak var balanceCard: UIView!
    @IBOutlet weak var chartCard: UIView!
    
    @IBOutlet weak var incomeAmountLabel: UILabel!
    @IBOutlet weak var expensesAmountLabel: UILabel!
    @IBOutlet weak var balanceAmountLabel: UILabel!
    
    @IBOutlet weak var incomeDetailsBtn: UIView!
    @IBOutlet weak var expensesDetailsBtn: UIView!
    @IBOutlet weak var balanceDetailsBtn: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    //MARK: - Actions Stack
    @IBOutlet weak var actionContainerStack: UIStackView!
    
    @IBOutlet weak var reportBtn: UIStackView!
    @IBOutlet weak var historyBtn: UIStackView!
    @IBOutlet weak var categoryBtn: UIStackView!
    
    //MARK: Transactions
    @IBOutlet weak var seeAllTransactionsBtn: UIStackView!
    @IBOutlet weak var transactionsTableView: UITableView!
    @IBOutlet weak var addTransactionBtn: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        
        if let lastLoginTime = UserService.shared.lastLoginTime  {
            if abs(lastLoginTime.timeIntervalSinceNow) >= 604800 { // 7 day
                print("refresh")
                //TODO: refresh the token with new api
            } else {
                // Entry point for Home
                print("entry of home, api call for all category and transactions")
                setupData()
            }
        } else {
            DispatchQueue.main.async {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false)
            }
        }
        
//        setupData()
    }
    
    fileprivate func setupData() {
        let group = DispatchGroup()
        group.enter()
        NetworkService.shared.getCategories() { result in
            group.leave()
            switch result {
            case .success(let success):
                if success.status == 200 {
                    guard let categoriesResponse = success.categories else {
                        //TODO: - show toast
                        print("error in retrieving categories")
                        return
                    }
                    DataService.shared.categories = categoriesResponse
                } else {
                    print(success.message)
                    // TODO: - show toast
                }
            case .failure(let failure):
                //TODO-show toast
                print(failure.localizedDescription)
            }
        }
        
        group.enter()
        NetworkService.shared.getTransactions { result in
            group.leave()
            switch result {
            case .success(let success):
                if success.status == 200 {
                    guard let transactionsResponse = success.transactions else {
                        //TODO: - show toast
                        print("error in retrieving transactions")
                        return
                    }
                    DataService.shared.transactions = transactionsResponse
//                    self.transactions = DataService.shared.transactions
                }
            case .failure(let failure):
                //TODO: show toast
                print(failure.localizedDescription)
            }
        }
        
//        self.view.show()
        group.notify(queue: .main) {
//            self.view.hide()
            self.setupViews()
            self.refreshData()
        }
    }
    
    fileprivate func setupViews() {
        let logo = UIImage(named: "logo-transparent")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        //MARK: - Upper Cards
        incomeCard.layer.cornerRadius = 10
        expensesCard.layer.cornerRadius = 10
        balanceCard.layer.cornerRadius = 10
        chartCard.layer.cornerRadius = 10
        
        incomeDetailsBtn.layer.cornerRadius = 15
        expensesDetailsBtn.layer.cornerRadius = 15
        balanceDetailsBtn.layer.cornerRadius = 15
        
        //TODO: add action to details btn
        incomeDetailsBtn.isUserInteractionEnabled = true
        let incomeBtnTapGesture = UITapGestureRecognizer(target: self, action: #selector(showIncomeVC))
        incomeDetailsBtn.addGestureRecognizer(incomeBtnTapGesture)
        
        expensesDetailsBtn.isUserInteractionEnabled = true
        let expensesBtnTapGesture = UITapGestureRecognizer(target: self, action: #selector(showExpensesVC))
        expensesDetailsBtn.addGestureRecognizer(expensesBtnTapGesture)
         
        //MARK: - Actions Stack
        actionContainerStack.layer.cornerRadius = 10
        //TODO: add action to 3 btn
        historyBtn.isUserInteractionEnabled = true
        let historyBtnTapGesture = UITapGestureRecognizer(target: self, action: #selector(showHistoryVC))
        historyBtn.addGestureRecognizer(historyBtnTapGesture)
        
        categoryBtn.isUserInteractionEnabled = true
        let categoryBtnTapGesture = UITapGestureRecognizer(target: self, action: #selector(showCategoryVC))
        categoryBtn.addGestureRecognizer(categoryBtnTapGesture)
        
        //MARK: - Transactions
        transactionsTableView.dataSource = self
        transactionsTableView.delegate = self
        transactionsTableView.register(UINib(nibName: "TransactionTableViewCell", bundle: nil), forCellReuseIdentifier: "TransactionTableViewCell")
        
        //MARK: - Add addTransactionBtn
        let addTransactionTapGesture = UITapGestureRecognizer(target: self, action: #selector(showAddTransaction))
        addTransactionBtn.isUserInteractionEnabled = true
        addTransactionBtn.addGestureRecognizer(addTransactionTapGesture)
    }
    
    fileprivate func refreshData() {
        transactionsTableView.reloadData()
        //update TF values
        var totalIncome: Double = 0
        var totalExpenses: Double = 0
        for transaction in DataService.shared.transactions {
            guard let amount = Double(transaction.amount) else { return }
            guard let category = DataService.shared.categories.filter({ $0.id == transaction.categoryID }).first else {
                return
            }
            
            switch category.type {
            case .income:
                totalIncome += amount
            case .expense:
                totalExpenses += amount
            }
        }
        incomeAmountLabel.text = String(totalIncome)
        expensesAmountLabel.text = String(totalExpenses)
        balanceAmountLabel.text = String(totalIncome-totalExpenses)
    }
    
    @objc fileprivate func showAddTransaction() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let customAlert = storyboard.instantiateViewController(withIdentifier: "AddTransactionVC") as? AddTransactionVC {
            customAlert.modalPresentationStyle = .overCurrentContext
            customAlert.modalTransitionStyle = .crossDissolve
            present(customAlert, animated: true, completion: nil)
            
            customAlert.onDismiss = {
                self.setupData()
            }
        }
    }
    
    @objc fileprivate func showIncomeVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "IncomeVC")
        navigationController?.pushViewController(nextViewController, animated: true)
    }

    @objc fileprivate func showExpensesVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "ExpensesVC")
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc fileprivate func showHistoryVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "HistoryVC")
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc fileprivate func showCategoryVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "CategoryVC")
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}
