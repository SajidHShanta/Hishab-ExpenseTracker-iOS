//
//  Transaction.swift
//  Hishab
//
//  Created by Sajid Shanta on 25/2/24.
//

import Foundation

struct Transaction {
    let id: String
    let amount: Double
    let date: Date
    let note: String?
    let categoryID: String
}

struct Category {
    let id: String
    let name: String
    let icon: String?
    let type: Type
}

enum Type {
    case income
    case expense
}
