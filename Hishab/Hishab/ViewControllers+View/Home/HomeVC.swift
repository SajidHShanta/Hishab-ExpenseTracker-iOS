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
    
    var transactions = DataService.shared.transactions {
        didSet {
            transactionsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        
        if let lastLoginTime = UserService.shared.lastLoginTime  {
            if abs(lastLoginTime.timeIntervalSinceNow) >= 10080 { // 7 day
                print("refresh")
                //TODO: refresh the token with new api
            } else {
//                self.show()
                // Entry point for Home
                print("entry of home, api call for all category and transactions")
//                self.dismiss()
            }
        } else {
            DispatchQueue.main.async {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false)
            }
        }

        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        transactions = DataService.shared.transactions
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
    
    @objc fileprivate func showAddTransaction() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let customAlert = storyboard.instantiateViewController(withIdentifier: "AddTransactionVC") as? AddTransactionVC {
            customAlert.modalPresentationStyle = .overCurrentContext
            customAlert.modalTransitionStyle = .crossDissolve
            present(customAlert, animated: true, completion: nil)
            
            customAlert.onDismiss = {
                self.transactions = DataService.shared.transactions
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
