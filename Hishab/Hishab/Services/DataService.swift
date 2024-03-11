//
//  DataService.swift
//  Hishab
//
//  Created by Sajid Shanta on 25/2/24.
//

import Foundation

class DataService {
    static let shared = DataService()
    
    private init() { }
    
    var categories: [Category] = []
    var transactions: [Transaction] = [
//        .init(id: "1", amount: 540, date: Date(), note: "Burger King khaisi", categoryID: 1),
//        .init(id: "2", amount: 2003, date: Date(), note: "Bashundhara Basha", categoryID: 2),
//        .init(id: "3", amount: 50000, date: Date()-1, note: "Monthly Betun", categoryID: 3),
    ]
    
    func addTransaction(amount: Double, date: Date, note: String?, categoryID: Int) {
        let transaction = Transaction(id: UUID().uuidString, amount: amount, date: date, note: note, categoryID: categoryID)
        self.transactions.append(transaction)
    }
    
    func saveCategories(_ categories: [Category]) {
        self.categories = categories
    }
}
