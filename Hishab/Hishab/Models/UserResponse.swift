//
//  UserResponse.swift
//  Hishab
//
//  Created by Sajid Shanta on 10/3/24.
//

import Foundation

class UserResponse:Codable {
    let status: Int
    let message: String
    let accessToken: String?
    let refreshToken: String?
    let user: User?
}

class User: Codable {
    let id: Int
    let name: String
    let email: String
//    let password: String
}
