//
//  UserService.swift
//  Hishab
//
//  Created by Sajid Shanta on 10/3/24.
//

import Alamofire

class UserService {
    static let shared = UserService()
    
    private init(){ }
    
    var access_token: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    var refresh_token: String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    
    var lastLoginTime: Date? {
        return UserDefaults.standard.value(forKey: "last_login_time") as? Date
    }
    
    var userName: String? {
        return UserDefaults.standard.string(forKey: "user_name")
    }
    
    var userEmail: String? {
        return UserDefaults.standard.string(forKey: "user_email")
    }
    
    func saveUserData(name: String, email: String, accessToken: String, refreshToken: String) {
        UserDefaults.standard.set(name, forKey: "user_name")
        UserDefaults.standard.set(email, forKey: "user_email")
        UserDefaults.standard.set(accessToken, forKey: "access_token")
        UserDefaults.standard.set(accessToken, forKey: "refresh_token")
        UserDefaults.standard.set(Date(), forKey: "last_login_time")
    }
    
    func deleteUserData() {
        UserDefaults.standard.removeObject(forKey: "user_name")
        UserDefaults.standard.removeObject(forKey: "user_email")
        UserDefaults.standard.removeObject(forKey: "access_token")
        UserDefaults.standard.removeObject(forKey: "refresh_token")
        UserDefaults.standard.removeObject(forKey: "last_login_time")
    }
}

