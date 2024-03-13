//
//  Transaction.swift
//  Hishab
//
//  Created by Sajid Shanta on 25/2/24.
//

import Foundation

struct Transaction: Codable {
    let id: Int
    let amount: String
    let date: String
    let note: String?
    let categoryID: Int
}

struct GetTransactionsResponse: Codable {
    let status: Int
    let message: String
    let transactions: [Transaction]?
}

struct AddTransactionResponse: Codable {
    let status: Int
    let message: String
}

