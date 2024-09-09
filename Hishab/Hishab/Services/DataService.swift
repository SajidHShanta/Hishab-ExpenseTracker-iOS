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
    var transactions: [Transaction] = []
    
//    func addTransaction(amount: Double, date: Date, note: String?, categoryID: Int) {
//        let transaction = Transaction(id: UUID().uuidString, amount: amount, date: date, note: note, categoryID: categoryID)
//        self.transactions.append(transaction)
//    }
//    
//    func saveCategories(_ categories: [Category]) {
//        self.categories = categories
//    }
}
