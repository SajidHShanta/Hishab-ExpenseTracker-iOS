//
//  Category.swift
//  Hishab
//
//  Created by Sajid Shanta on 10/3/24.
//

import Foundation

struct Category: Codable {
    let id: Int
    let name: String
//  let icon: String?
    let type: CategoryType
}

enum CategoryType: String, Codable {
    case income
    case expense
    
    var name: String {
        switch self {
        case .income:
            return "income"
        case .expense:
            return "expense"
        }
    }
}

struct GetCategoryResponse: Codable {
    let status: Int
    let message: String
    let categories: [Category]
}

struct AddOrUpdateCategoryResponse: Codable {
    let status: Int
    let message: String
}
